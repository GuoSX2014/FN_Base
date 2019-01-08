//
//  UIImage+FN.h
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FNImageGradientPosition) {
    FNImageGradientPositionLandscape    = 0,   // 横向渐变
    FNImageGradientPositionPortrait    = 1,   // 纵向渐变
};

@interface FNIconInfo : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) UIColor *color;

- (instancetype)initWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color;
+ (instancetype)iconInfoWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color;

@end

#define FNIconInfoMake(text, imageSize, imageColor) [FNIconInfo iconInfoWithText:text size:imageSize color:imageColor]

@interface FNIconFont : NSObject

+ (UIFont *)fontWithSize: (CGFloat)size;
+ (void)setFontName:(NSString *)fontName;

@end

@interface UIImage (FN)
/**
 *  iconfont扩展方法
 */
+ (UIImage *)iconWithInfo:(FNIconInfo *)info;

/**
 获取图片主题色
 
 @return 主题色
 */
- (UIColor *)mainColor;

/**
 *  返回一张拉伸不变形的图片
 *
 *  @param name 图片名称 
 */
+ (UIImage *_Nullable)resizableImage:(NSString *)name;

/**
 *  在一个View上截图
 *
 *  @param view 目标View
 *  @param rect 需要截取的范围
 */
+ (UIImage *)imageByScreenshotsWithView:(UIView *)view andRect:(CGRect)rect;

/**
 *  保持原来的长宽比，生成一个缩略图
 *  @param asize 需要的长、宽
 *
 */
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;



/**
 * 给图片设置圆角，比直接设置UIImageView圆角效率高
 */
- (UIImage *)hyb_imageWithCornerRadius:(CGFloat)radius;


/**
 * 图片旋转
 * @param aImage 旋转前图片
 * @return 旋转后的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;


/**
 *  color  : 获取用颜色生成的image
 *  size   : 指定的宽／高
 *  return : 生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (nullable UIImage *)borderColorWithColor:(UIColor *_Nullable)color;

+ (nullable UIImage *)borderColorWithColor:(UIColor *_Nullable)color size:(CGSize)size;
/**
 生成一张渐变色的图片
 @param colors 颜色数组
 @param rect 图片大小
 @param gradientPosition 图片渐变方向
 @return 返回渐变图片
 */
+ (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect gradientPosition:(FNImageGradientPosition)gradientPosition;

@end
NS_ASSUME_NONNULL_END
