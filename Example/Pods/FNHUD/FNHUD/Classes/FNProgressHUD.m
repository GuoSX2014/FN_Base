//
//  FNProgressHUD.m
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/5/10.
//  Copyright © 2018年 bijietao. All rights reserved.
//

#import "FNProgressHUD.h"
#import <SDWebImage/UIImage+GIF.h>

#define HexRGBA(rgbValue,al) [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:al]
@interface FNProgressHUD()

@end

@implementation FNProgressHUD


/**
 window菊花加载

 @param maskType 设置样式
 @return FNProgressHUD
 */
+ (instancetype)showLoadingWithMaskType:(HUDMaskType)maskType{
    return [FNProgressHUD showLoadingWithText:@"" toView:nil maskType:maskType];
}

/**
 固定视图提示加载
 @param view 所在视图
 @param maskType 样式
 @return FNProgressHUD
 */
+ (instancetype)showLoadingToView:(UIView *)view maskType:(HUDMaskType)maskType{
    return [FNProgressHUD showLoadingWithText:@"" toView:view maskType:maskType];
}

/**
 文字提示加载
 
 @param text 提示文字
 @param view 所在视图
 @param maskType 样式
 @return FNProgressHUD
 */
+ (instancetype)showLoadingWithText:(NSString *)text toView:(UIView *)view maskType:(HUDMaskType)maskType{
    view = view ? view : [UIApplication sharedApplication].keyWindow;
    FNProgressHUD *lastViewhud = [view viewWithTag:654321];
    if (lastViewhud) {
       [FNProgressHUD hideHUDForView:view animated:NO];
    }
    FNProgressHUD *hud = [FNProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.tag = 654321;
    hud.mode = MBProgressHUDModeCustomView;
    
    UIImageView *animatedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    animatedImageView.animationImages = [FNProgressHUD animationImages];
    animatedImageView.animationDuration = 0.5f;
    animatedImageView.animationRepeatCount = 0;
    hud.customView = animatedImageView;
    
    [animatedImageView startAnimating];
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = HexRGBA(0x000000, 0.8);

    hud.contentColor = [UIColor whiteColor];
    if (maskType == HUDMaskTypeNone) {
        hud.userInteractionEnabled = NO;
    }else{
        hud.userInteractionEnabled = YES;
    }
    return hud;
}

+ (NSArray *)animationImages {
    NSBundle *bundle =  [NSBundle bundleWithPath:[[NSBundle bundleForClass:[FNProgressHUD class]] pathForResource:@"FNProgressHUD" ofType:@"bundle"]];
    NSMutableArray *imagesArr = [NSMutableArray array];
    for (NSInteger i = 1; i <= 8; i++) {
         UIImage *image = [UIImage imageWithContentsOfFile:[[bundle resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"FNHUDLoading00%ld",i]]];
        if (image) {
            [imagesArr addObject:image];
        }
    }
    return imagesArr;
}


/**
 一句话文案提示，自动消失
 
 @param text 提示文字
 @param view 所在视图
 */
+ (void)showMessageWithText:(NSString *)text toView:(UIView *)view{
    view = view ? view : [UIApplication sharedApplication].keyWindow;
    FNProgressHUD *hud = [FNProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = HexRGBA(0x000000, 0.8);
    hud.label.text = text;
    hud.contentColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
    [hud hideAnimated:YES afterDelay:1.5];
}

/**
 info文案提示，自动消失
 
 @param text 文字内容
 @param view 所在视图
 */
+ (void)showInfoWithText:(NSString *)text toView:(UIView *)view{
    view = view ? view : [UIApplication sharedApplication].keyWindow;
    FNProgressHUD *hud = [FNProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;

    hud.label.text = text;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = HexRGBA(0x000000, 0.8);
    hud.contentColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
    NSBundle *bundle =  [NSBundle bundleWithPath:[[NSBundle bundleForClass:[FNProgressHUD class]] pathForResource:@"FNProgressHUD" ofType:@"bundle"]];
    UIImage *infoImage = [UIImage imageWithContentsOfFile:[[bundle resourcePath] stringByAppendingPathComponent:@"info.png"]];
    hud.customView = [[UIImageView alloc] initWithImage:infoImage];
    [hud hideAnimated:YES afterDelay:1.5];
}
/**
 成功文案提示，自动消失
 
 @param text 文字内容
 @param view 所在视图
 */
+ (void)showSuccessWithText:(NSString *)text toView:(UIView *)view{
    view = view ? view : [UIApplication sharedApplication].keyWindow;
    FNProgressHUD *hud = [FNProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = HexRGBA(0x000000, 0.8);
    hud.label.text = text;
    hud.contentColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
    NSBundle *bundle =  [NSBundle bundleWithPath:[[NSBundle bundleForClass:[FNProgressHUD class]] pathForResource:@"FNProgressHUD" ofType:@"bundle"]];
    UIImage *infoImage = [UIImage imageWithContentsOfFile:[[bundle resourcePath] stringByAppendingPathComponent:@"success.png"]];
    hud.customView = [[UIImageView alloc] initWithImage:infoImage];
    [hud hideAnimated:YES afterDelay:1.5];

}

/**
 失败文案提示，自动消失
 
 @param text 文字内容
 @param view 所在视图
 */
+ (void)showErrorWithText:(NSString *)text toView:(UIView *)view{
    view = view ? view : [UIApplication sharedApplication].keyWindow;
    FNProgressHUD *hud = [FNProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = HexRGBA(0x000000, 0.8);
    hud.label.text = text;
    hud.contentColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
    NSBundle *bundle =  [NSBundle bundleWithPath:[[NSBundle bundleForClass:[FNProgressHUD class]] pathForResource:@"FNProgressHUD" ofType:@"bundle"]];
    UIImage *infoImage = [UIImage imageWithContentsOfFile:[[bundle resourcePath] stringByAppendingPathComponent:@"error.png"]];
    hud.customView = [[UIImageView alloc] initWithImage:infoImage];
    [hud hideAnimated:YES afterDelay:1.5];
}


/**
 隐藏方法
 */
+ (void)dismiss{
    UIView *keyWindow = [UIApplication sharedApplication].keyWindow;
    [FNProgressHUD hideHUDForView:keyWindow animated:YES];
}

/**
 固定视图隐藏提示框
 
 @param view 所在视图
 */
+ (void)dismissForView:(UIView *)view{
    [FNProgressHUD hideHUDForView:view animated:YES];
}


@end
