//
//  FNBaseNavigationController.m
//  FNGuangFu
//
//  Created by Adward on 2018/5/23.
//  Copyright © 2018年 ENN. All rights reserved.
//

#import "FNBaseNavigationController.h"
#import <FNMacros/FNAppMacros.h>
#import <FNHUD/FNProgressHUD.h>
#import <FNNetwork/FNNetworkingRequest.h>
#import <FN_Macros/FNProjectColorMacros.h>
#import <FNCategory/UIImage+FN.h>

@interface FNBaseNavigationController ()

@end

@implementation FNBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *attri = @{NSForegroundColorAttributeName:kTextWhiteDominantColor,
                            NSFontAttributeName:PingFangMediumFontSize(20)};
    [self.navigationBar setTitleTextAttributes: attri];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:kBackgroundBlackDominantColor size:CGSizeMake(kScreenWidth,kStatusAndNavigationHeight)] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0 )
    {
        // 判断当前导航控制器的栈中是否有数据
        if (!self.childViewControllers.count) return;
        // 隐藏选项卡
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *leftBtn = [[UIButton alloc] init];
        leftBtn.bounds = CGRectMake(0, 0, kRealWidth(44), kRealWidth(44));
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIImage *img = [UIImage iconWithInfo:FNIconInfoMake(@"\U0000e65d", 18, HexRGB(0x999999))];
        [leftBtn setImage:img forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(pressBackButton:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    }
    [super pushViewController:viewController animated:animated];
}

// 关联导航栏返回按钮事件
- (void)pressBackButton:(UIBarButtonItem *)button
{
//    [FNProgressHUD hideHUDForView:[FNJumpUtil getCurrentVC].view animated:YES];
    [FNProgressHUD hideHUDForView:kAppWindow animated:YES];
    [FNNetworkingRequest cancelAllRequest];

    [self popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
