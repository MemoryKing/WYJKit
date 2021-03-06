/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ 
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (YJAdd)
@property (nonatomic, assign) BOOL yi_addNoti;

@property (nonatomic, copy) NSString * yi_lastTextStr;

@property (nonatomic, copy) void(^yi_textHandle) (NSString *textStr);

/** 占位文字 */
@property (nonatomic, copy) NSString * yi_placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor * yi_placeholderColor;
/** 最大显示字符限制(会自动根据该属性截取文本字符长度) */
@property (nonatomic, assign) NSInteger yi_maximumLimit;
/** 右下角字符长度提示(需要设置maximumLimit属性)，与占位文本颜色、字号一致  默认NO */
@property (nonatomic, assign) BOOL yi_characterLengthPrompt;
/** 右下角字符提示字体大小 */
@property (nonatomic, strong) UIFont * yi_promptFont;
@end

NS_ASSUME_NONNULL_END
