/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


#import "UITextField+YJAdd.h"
#import <objc/runtime.h>
#import "NSString+YJAdd.h"

@implementation UITextField (YJAdd)


- (void)setYi_placeholderColor:(UIColor *)yi_placeholderColor {
    objc_setAssociatedObject(self, &@selector(yi_placeholderColor), yi_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (@available(iOS 13.0, *)) {
        NSMutableAttributedString * att = [NSMutableAttributedString.alloc initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:yi_placeholderColor}];
        self.attributedPlaceholder = att;
    } else {
        [self setValue:yi_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
}

- (UIColor *)yi_placeholderColor {
    return objc_getAssociatedObject(self, &@selector(yi_placeholderColor));
}

- (void)setAddNoti:(BOOL)addNoti {
    
    objc_setAssociatedObject(self, @selector(addNoti), [NSNumber numberWithBool:addNoti], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, _cmd) boolValue];
    return obj;
}

- (void)setYi_maximumLimit:(NSInteger)yi_maximumLimit {
    objc_setAssociatedObject(self, @selector(yi_maximumLimit), @(yi_maximumLimit), OBJC_ASSOCIATION_ASSIGN);
    [self addTextChangeNoti];
}

- (NSInteger)yi_maximumLimit {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setTextHandle:(void (^)(NSString *))textHandle {
    objc_setAssociatedObject(self, @selector(textHandle), textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))textHandle {
    return objc_getAssociatedObject(self, @selector(textHandle));
}

- (void)setLastTextStr:(NSString *)lastTextStr {
    objc_setAssociatedObject(self, @selector(lastTextStr), lastTextStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastTextStr {
    return [NSString yi_emptyStr:objc_getAssociatedObject(self, _cmd)];
}

/**
 *  监听文字改变
 */
- (void)textDidChange {
    [self characterTruncation];
}

- (void)yi_textDidChange:(void (^)(NSString * _Nonnull))handle {
    self.textHandle = handle;
    [self addTextChangeNoti];
}

/**
*  处理系统输入法导致的乱码,如果调用了maximumLimit属性，内部会默认处理乱码
*/
- (void)yi_fixMessyDisplay {
    if(self.yi_maximumLimit <= 0) {self.yi_maximumLimit = MAXFLOAT;}
    [self addTextChangeNoti];
}

- (void)addTextChangeNoti {
    if(self.addNoti == NO) {
        // 当UITextField的文字发生改变时，UITextField自己会发出一个UITextFieldTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    }
    self.addNoti = YES;
}

- (NSString *)characterTruncation {
    //字符截取
    if(self.yi_maximumLimit) {
        
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制,如果有高亮待选择的字，则暂不对文字进行统计和限制
        if ((position == nil) && (self.text.length > self.yi_maximumLimit)) {
            const char *res = [self.text substringToIndex:self.yi_maximumLimit].UTF8String;
            if (res == NULL) {
                self.text = [self.text substringToIndex:self.yi_maximumLimit - 1];
            }else{
                self.text = [self.text substringToIndex:self.yi_maximumLimit];
            }
        }
    }
    if((self.textHandle) && (![self.text isEqualToString:self.lastTextStr])) {
        
        self.textHandle(self.text);
    }
    self.lastTextStr = self.text;
    
    return self.text;
}

- (void)dealloc {
    if(self.addNoti == YES) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }
}


@end
