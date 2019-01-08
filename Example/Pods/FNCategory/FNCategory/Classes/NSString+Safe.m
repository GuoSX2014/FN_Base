//
//  NSString+Safe.m
//  NSSafeString
//
//  Created by Adward on 2018/5/24.
//  Copyright © 2018年 FN. All rights reserved.
//

#import "NSString+Safe.h"
#import "NSObject+FNSwizzle.h"
#import <objc/runtime.h>

@implementation NSString (Safe)

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *tmpStr = @"substringWithRange:";
        NSString *tmpSafeStr = @"safe_substringWithRange:";


        [self exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFConstantString")
                                     originalSelector:NSSelectorFromString(tmpStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeStr)];
        [self exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFConstantString")
                                 originalSelector:NSSelectorFromString(@"substringFromIndex:")                                     swizzledSelector:NSSelectorFromString(@"safe_substringFromIndex:")];
        [self exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFConstantString")
                                 originalSelector:NSSelectorFromString(@"substringToIndex:")                                     swizzledSelector:NSSelectorFromString(@"safe_substringToIndex:")];
        
    });
    
}

- (NSString *)safe_substringWithRange:(NSRange)range;
{
    if (range.location + range.length > self.length) {
        return nil;
    }
    return [self safe_substringWithRange:range];
}

- (NSString *)safe_substringFromIndex:(NSUInteger)from;
{
    if (from >self.length) {
        return nil;
    }
    return [self safe_substringFromIndex:from];
}

- (NSString *)safe_substringToIndex:(NSUInteger)to;
{
    if (to > self.length) {
        return nil;
    }
    return [self safe_substringToIndex:to];
}

@end
