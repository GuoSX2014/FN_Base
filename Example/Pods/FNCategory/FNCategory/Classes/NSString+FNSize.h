//
//  NSString+FNSize.h
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/4/16.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FNSize)
/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/*
 * 返回字符串高度
 */
+ (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont *)font string:(NSString *)string lineSpace:(CGFloat )lineSpace;
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)reverseString:(NSString *)strSrc;
/**
 *  文字的内容、字体大小 计算文字所占的尺寸
 *  @param font    文字字体
 *
 *  @return 文字所占的尺寸
 */
- (CGSize)sizeWithMyFont:(UIFont *)font;

/**
 计算label大小
 
 @param label 含有内容的label
 @return CGSize
 */
+ (CGSize)sizeWithLabel:(UILabel *)label;
/**
 *  根据文字的内容、字体大小、最大尺寸范围 计算文字所占的尺寸
 *
 *  @param text    文字内容
 *  @param font    文字字体
 *
 *  @return 文字所占的尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font;

/**
 *  根据文字的内容、字体大小、最大尺寸范围 计算文字所占的尺寸
 *
 *  @param text    文字内容
 *  @param font    文字字体
 *  @param maxSize 最大尺寸范围
 *
 *  @return 文字所占的尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

@end
