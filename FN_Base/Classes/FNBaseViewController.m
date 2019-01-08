//
//  FNBaseViewController.m
//  FNGuangFu
//
//  Created by Adward on 2018/5/23.
//  Copyright © 2018年 ENN. All rights reserved.
//

#import "FNBaseViewController.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import <FN_Macros/FNProjectColorMacros.h>
#import <FNMacros/FNAppMacros.h>

static const float   BarButtonFontSize   =  16.0;

/**
 *  *****************************  新增  *****************************
 */

@implementation UINavigationItem (margin)
//设置标题
- (void)setTitleViewWithTitleName:(nullable NSString *)name withTarget:(id _Nullable)target selector:(nullable SEL)clickEvent {
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton addTarget:target action:clickEvent forControlEvents:UIControlEventTouchUpInside];
    titleButton.tintColor = [UIColor blackColor];
    [titleButton setTitle:name forState:UIControlStateNormal];
    titleButton.titleLabel.text = name;
    titleButton.titleLabel.textColor = [UIColor whiteColor];
    self.titleView = titleButton;
}

//设置左按钮
- (void)setLeftItemWithImageName:(nullable NSString*)imgName highlightedImageName:(nullable NSString*)highLightImageName  withTarget:(id _Nullable)target selector:(nullable SEL)clickEvent
{
    UIButton* backButton= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kRealWidth(44), kRealWidth(44))];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:highLightImageName] forState:UIControlStateHighlighted];
    [backButton addTarget:target action:clickEvent forControlEvents:UIControlEventTouchUpInside];
    self.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:backButton]];
}


//设置右按钮
- (void)setRightItemWithImageName:(nullable NSString *)imgName highLightedImageName:(nullable NSString *)highLightImageName withTarget:(id _Nullable )target selector:(nullable SEL)clickEvent {
    UIImage *image= [UIImage imageNamed:imgName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* rightButton= [[UIButton alloc] initWithFrame:frame_1];
    [rightButton setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:highLightImageName] forState:UIControlStateHighlighted];
    [rightButton addTarget:target action:clickEvent forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self setRightBarButtonItem:rightBarItem];
}

- (void)setRightItemWithImage:(nullable UIImage *)img highLightedImage:(nullable UIImage *)highLightImage withTarget:(id _Nullable )target selector:(nullable SEL)clickEvent {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    CGRect frame_1= CGRectMake(0, 0, kRealWidth(40), img.size.height);
    imageView.frame = frame_1;
    UIButton* rightButton= [[UIButton alloc] initWithFrame:frame_1];
    [rightButton setImage:img forState:UIControlStateNormal];
    [rightButton addTarget:target action:clickEvent forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self setRightBarButtonItem:rightBarItem];
}

- (void)setleftBarItemWithTitle:(nullable NSString *)titleName withTarget:(id _Nullable )target selector:(nullable SEL)clickEvent {
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 40, 30);
    [leftButton setTitle:titleName forState:UIControlStateNormal];
    [leftButton setTitleColor:kTextBlackDominantColor forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:BarButtonFontSize];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [leftButton addTarget:target action:clickEvent forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.leftBarButtonItem = leftButtonItem;
}


@end

@interface FNBaseViewController ()

@end

@implementation FNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundBlackDominantColor;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //默认隐藏导航栏 用自定义大标题显示
    self.fd_prefersNavigationBarHidden = YES;

}

#pragma mark - 隐藏/显示导航栏下的分割线
- (void)hiddenNavLine:(BOOL)hiddenNavLine;
{
    if (hiddenNavLine) {
        //隐藏黑线
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }else{
        //显示黑线
        [self.navigationController.navigationBar setShadowImage:nil];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



@end
