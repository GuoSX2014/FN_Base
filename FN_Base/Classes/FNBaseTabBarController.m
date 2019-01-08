//
//  FNBaseTabBarController.m
//  FNGuangFu
//
//  Created by Adward on 2018/5/23.
//  Copyright © 2018年 ENN. All rights reserved.
//

#import "FNBaseTabBarController.h"
#import "FNBaseNavigationController.h"
//#import "FNFanNengViewController.h"
//#import "FNMessageViewController.h"
//#import "FNToolViewController.h"
//#import "FNMineViewController.h"

@interface FNBaseTabBarController ()

@end

@implementation FNBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
//    self.view.backgroundColor = kTabBarTintColor;
    self.tabBar.translucent = NO;
    //隐藏tabbar上面的线
//    self.tabBar.shadowImage = [UIImage new];
//    self.tabBar.backgroundImage = [UIImage new];
//    self.tabBar.barTintColor = kTabBarTintColor;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
//    FNFanNengViewController *fanNengVC = [[FNFanNengViewController alloc] init];
//    [self setupChildViewController:fanNengVC
//                             title:@"泛能"
//                         imageName:@"\U0000e669" selectedImageName:@"\U0000e669"];
//
//    FNMessageViewController *messageVC = [[FNMessageViewController alloc] init];
//    [self setupChildViewController:messageVC
//                             title:@"消息"
//                         imageName:@"\U0000e668" selectedImageName:@"\U0000e668"];
//
//    FNToolViewController *toolVC = [[FNToolViewController alloc] init];
//    [self setupChildViewController:toolVC
//                             title:@"工具"
//                         imageName:@"\U0000e66b" selectedImageName:@"\U0000e66b"];
//
//    FNMineViewController *mineVC = [[FNMineViewController alloc] init];
//    [self setupChildViewController:mineVC
//                             title:@"我的"
//                         imageName:@"\U0000e66a" selectedImageName:@"\U0000e66a"];
//    [self addRedPoints];
}

// 做小红点
//- (void)addRedPoints {
//    float avgWidth = self.view.frame.size.width / 4.0;
//    float pointWidth = 8.0;
//    NSInteger i = 2;
//    CGRect frame = CGRectMake(i * avgWidth - kRealWidth(35), 5, pointWidth, pointWidth);
//    UIView *view = [[UIView alloc] initWithFrame:frame];
//    view.backgroundColor = [UIColor redColor];
//    view.layer.cornerRadius = pointWidth / 2.0;
//    view.hidden = YES;
//    self.messageRedPoint = view;
//    [self.tabBar addSubview:view];
//}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
//    childVc.title = title;
//    childVc.tabBarItem.title = title;
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = kTextTabbarNormalTitileColor;
//    selectTextAttrs[NSForegroundColorAttributeName] = kTextTabbarSelectTitileColor;
//    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
//    // 设置图标
//    UIImage *image = [UIImage iconWithInfo:FNIconInfoMake(imageName, 22, HexRGB(0x999999))];
//    childVc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    // 设置选中的图标
//    UIImage *selectedImage = [UIImage iconWithInfo:FNIconInfoMake(selectedImageName, 22, HexRGB(0x0780ED))];
//    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childVc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);

    // 2.包装一个导航控制器
//    FNBaseNavigationController *nav = [[FNBaseNavigationController alloc] initWithRootViewController:childVc];
//    [self addChildViewController:nav];
}

@end
