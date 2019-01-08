//
//  UILabel+FN.h
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/5/8.
//  Copyright © 2018年 bijietao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FN)

/**
 创建TRLabel
 
 @param frame 控件大小
 @param text 内容
 @param textAlignment 对其方式
 @param font 字体大小
 @param textColor 字体颜色
 @param backgroundColor 背景颜色
 @return TRLabel
 */
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor;



/**
 创建TRLabel
 
 @param text 内容
 @param textAlignment 对其方式
 @param font 字体大小
 @param textColor 字体颜色
 @param backgroundColor 背景颜色
 @return TRLabel
 */
- (instancetype)initWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor;

@end
