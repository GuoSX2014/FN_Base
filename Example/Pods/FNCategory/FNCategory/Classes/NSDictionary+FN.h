//
//  NSDictionary+FN.h
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FN)

/**
 json字符串转字典

 @param jsonString json字符串
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/** 返回string或nil */
- (NSString *)safe_stringForKey:(id)key;

/** 返回array或nil */
- (NSArray *)safe_arrayForKey:(id)key;

/** 返回dictionary或nil */
- (NSDictionary *)safe_dictionaryForKey:(id)key;

/** 返回number或nil */
- (NSNumber *)safe_numberForKey:(id)key;
@end
