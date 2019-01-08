//
//  FNBaseViewController.h
//  FNGuangFu
//
//  Created by Adward on 2018/5/23.
//  Copyright © 2018年 ENN. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UINavigationItem (margin)

//设置标题
- (void)setTitleViewWithTitleName:(nullable NSString *)name withTarget:(id _Nullable)target selector:(nullable SEL)clickEvent;

//设置左按钮
- (void)setLeftItemWithImageName:(nullable NSString*)imgName highlightedImageName:(nullable NSString*)highLightImageName  withTarget:(id _Nullable)target selector:(nullable SEL)clickEvent;

//设置右按钮
- (void)setRightItemWithImageName:(nullable NSString *)imgName highLightedImageName:(nullable NSString *)highLightImageName withTarget:(id _Nullable )target selector:(nullable SEL)clickEvent;
- (void)setRightItemWithImage:(nullable UIImage *)img highLightedImage:(nullable UIImage *)highLightImage withTarget:(id _Nullable )target selector:(nullable SEL)clickEvent;
//设置左按钮
- (void)setleftBarItemWithTitle:(nullable NSString *)titleName
                     withTarget:(id _Nullable )target selector:(nullable SEL)clickEvent;

@end

@interface FNBaseViewController : UIViewController

@property (nonatomic, assign) NSUInteger pageIndex;
@property (nonatomic, assign) NSUInteger pageSize;


/**
 隐藏/显示导航栏下的分割线
 
 @param hiddenNavLine 隐藏(YES)/显示(NO)
 */
- (void)hiddenNavLine:(BOOL)hiddenNavLine;

@end
