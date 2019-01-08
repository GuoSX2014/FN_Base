//
//  UIButton+FN.h
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FN)
typedef NS_ENUM(NSInteger, FNImagePosition) {
    FNImagePositionNone    = 0,   // 无效果
    FNImagePositionLeft    = 1,   // 图片在左，文字在右，默认
    FNImagePositionRight   = 2,   // 图片在右，文字在左
    FNImagePositionTop     = 3,   // 图片在上，文字在下
    FNImagePositionBottom  = 4,   // 图片在下，文字在上
};
/**
 *  @brief  设置按钮额外热区
 */
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;
/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(FNImagePosition)postion spacing:(CGFloat)spacing;


- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 This method will show the activity indicator in place of the button text.
 */
- (void) showIndicator;

/**
 This method will remove the indicator and put thebutton text back in place.
 */
- (void) hideIndicator;
@end
