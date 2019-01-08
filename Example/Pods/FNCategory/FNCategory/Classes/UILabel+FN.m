//
//  UILabel+FN.m
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/5/8.
//  Copyright © 2018年 bijietao. All rights reserved.
//

#import "UILabel+FN.h"
#import "NSObject+FNSwizzle.h"
#import <objc/runtime.h>

static const char *UIEdgeInsets_testInsets = "UIEdgeInsets_testInsets";

@implementation UILabel (FN)

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 替换 objectAtIndexedSubscript
        NSString *tmpRemoveStr = @"setText:";
        NSString *tmpSafeRemoveStr = @"safe_SetText:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:[self class]  originalSelector:NSSelectorFromString(tmpRemoveStr)                                   swizzledSelector:NSSelectorFromString(tmpSafeRemoveStr)];
    });
    
}
#pragma mark --- implement method

-(void)safe_SetText:(NSString *)text{
    if ([text isKindOfClass:[NSNull class]]) {
        return;
    }else{
        [self safe_SetText:text];
    }
}


// runtime 动态绑定 属性
- (void)setTextInsets:(UIEdgeInsets)textInsets
{
    NSValue *value = [NSValue value:&textInsets withObjCType:@encode(UIEdgeInsets)];

    objc_setAssociatedObject(self, UIEdgeInsets_testInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)textInsets
{
    NSValue *value = objc_getAssociatedObject(self, UIEdgeInsets_testInsets);
    if(value) {
        UIEdgeInsets insets;
        [value getValue:&insets];
        return insets;
    }else {
        return UIEdgeInsetsZero;
    }
}

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
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.text = text;
        self.textAlignment = textAlignment;
        self.font = font;
        self.textColor = textColor;
        self.backgroundColor = backgroundColor;
    }
    return self;
}



/**
 创建TRLabel
 
 @param text 内容
 @param textAlignment 对其方式
 @param font 字体大小
 @param textColor 字体颜色
 @param backgroundColor 背景颜色
 @return TRLabel
 */
- (instancetype)initWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor {
    self = [super init];
    if (self) {
        // Initialization code
        self.text = text;
        self.textAlignment = textAlignment;
        self.font = font;
        self.textColor = textColor;
        self.backgroundColor = backgroundColor;
    }
    return self;
}


@end
