//
//  NSArray+FN.h
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FN)
/********直接对NSArray操作，移除其中的元素*********/


/**
 NSArray移除某个元素

 @param object 要移除的对象
 @return ret
 */
- (NSArray *)arrayBySafeRemoveObject:(id)object;


/**
 NSArray移除某些元素

 @param removeArray 要移除的数组元素
 @return ret
 */
- (NSArray *)arrayBySafeRemoveObjectsFromArray:(NSArray *)removeArray;

@end
