/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ 
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


#import <UIKit/UIKit.h>

typedef enum  {
    GradientTypeTopToBottom ,       //从上到小
    GradientTypeLeftToRight ,       //从左到右
    GradientTypeUpLeftToBottomRight ,   //左上到右下
    GradientTypeUpRightToBottomLeft    //右上到左下
} GradientType;

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YJAdd)
/** image conversion base64 */
@property (nonatomic, copy, readonly)NSString * yi_base64String;



/**
 渐变色

 @param size size
 @param colors color array
 @param gradientType direction
 @return image
 */
+ (UIImage *)yi_imageFromSize:(CGSize)size Colors:(NSArray*)colors byGradientType:(GradientType)gradientType;

@end

NS_ASSUME_NONNULL_END
