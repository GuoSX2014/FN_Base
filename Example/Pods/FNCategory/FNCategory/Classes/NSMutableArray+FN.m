//
//  NSMutableArray+safe.m
//  safeYunYing
//
//  Created by Adward on 2018/5/11.
//  Copyright © 2018年 bijietao. All rights reserved.
//

#import "NSMutableArray+FN.h"
#import <objc/runtime.h>
@implementation NSMutableArray (FN)

+(void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self SwizzlingMethod:@"addObject:" systemClassString:@"__NSArrayM" toSafeMethodString:@"safe_addObject:" targetClassString:@"NSMutableArray"];
        
        [self SwizzlingMethod:@"addObjectsFromArray:" systemClassString:@"__NSArrayM" toSafeMethodString:@"safe_addObjectsFromArray:" targetClassString:@"NSMutableArray"];
        
        [self SwizzlingMethod:@"insertObject:atIndex:" systemClassString:@"__NSArrayM" toSafeMethodString:@"safe_insertObject:atIndex:" targetClassString:@"NSMutableArray"];
        
        [self SwizzlingMethod:@"removeObjectAtIndex:" systemClassString:@"__NSArrayM" toSafeMethodString:@"safe_removeObjectAtIndex:" targetClassString:@"NSMutableArray"];
        
        [self SwizzlingMethod:@"replaceObjectAtIndex:withObject:" systemClassString:@"__NSArrayM" toSafeMethodString:@"safe_safe_replaceObjectAtIndex:withObject:" targetClassString:@"NSMutableArray"];
        
        [self SwizzlingMethod:@"removeObjectsAtIndexes:" systemClassString:@"NSMutableArray" toSafeMethodString:@"safe_removeObjectsAtIndexes:" targetClassString:@"NSMutableArray"];
        
        [self SwizzlingMethod:@"removeObjectsInRange:" systemClassString:@"NSMutableArray" toSafeMethodString:@"safe_removeObjectsInRange:" targetClassString:@"NSMutableArray"];
        
        [self SwizzlingMethod:@"objectAtIndex:" systemClassString:@"__NSArrayM" toSafeMethodString:@"safe_objectAtIndex:" targetClassString:@"NSMutableArray"];
        
    });
    
}

#pragma mark - index
- (id)safe_objectAtIndex:(NSUInteger)index{
    //判断数组是否越界
    if (index >= [self count]) {
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

#pragma mark - add methods
- (void)safe_addObject:(id)anObject{
    if (!anObject) {
        return;
    }
    [self safe_addObject:anObject];
}

- (void)safe_addObjectsFromArray:(NSArray *)array{
    if (!array || array.count <= 0) {
        return;
    }
    [self safe_addObjectsFromArray:array];
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > [self count]) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self safe_insertObject:anObject atIndex:index];
}

#pragma mark - remove methods
- (void)safe_removeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return;
    }
    
    return [self safe_removeObjectAtIndex:index];
}

- (void)safe_removeObjectsAtIndexes:(NSIndexSet *)indexes{
    NSMutableIndexSet * mutableSet = [NSMutableIndexSet indexSet];
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < [self count ]) {
            [mutableSet addIndex:idx];
        }
    }];
    [self safe_removeObjectsAtIndexes:mutableSet];
}
- (void)safe_removeObjectsInRange:(NSRange)range{
    //获取最大索引
    if (range.location + range.length - 1 < [self count]) {
        [self safe_removeObjectsInRange:range];
        return;
    }
    if (range.location >= [self count]) {
        return;
    }
    NSInteger tempInteger = range.location + range.length - 1;
    while (tempInteger >= [self count]) {
        tempInteger -= 1;
    }
    NSRange tempRange = NSMakeRange(range.location, tempInteger + 1 -range.location);
    [self safe_removeObjectsInRange:tempRange];
}

#pragma mark - replace methods
- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= [self count]) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self safe_replaceObjectAtIndex:index withObject:anObject];
}

#pragma mark - 方法交换
+ (void)SwizzlingMethod:(NSString *)systemMethodString systemClassString:(NSString *)systemClassString toSafeMethodString:(NSString *)safeMethodString targetClassString:(NSString *)targetClassString;{
    //获取系统方法IMP
    Method sysMethod = class_getInstanceMethod(NSClassFromString(systemClassString), NSSelectorFromString(systemMethodString));
    //自定义方法的IMP
    Method safeMethod = class_getInstanceMethod(NSClassFromString(targetClassString), NSSelectorFromString(safeMethodString));
    //IMP相互交换，方法的实现也就互相交换了
    method_exchangeImplementations(safeMethod,sysMethod);
}

@end
