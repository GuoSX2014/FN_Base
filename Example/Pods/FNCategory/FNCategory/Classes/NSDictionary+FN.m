
//
//  NSDictionary+FN.m
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#import "NSDictionary+FN.h"
#import "NSObject+FNSwizzle.h"

@implementation NSDictionary (FN)
#if DEBUG
- (NSString *)descriptionWithLocale:(id)locale{
    
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"\t}\n"];
    
    return strM;
}

#endif

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


#pragma mark - safe method

- (NSString *)safe_stringForKey:(id)key;{
    if (!key) return nil;
    id ret = [self objectForKey:key];
    if ([ret isKindOfClass:[NSString class]]){
        return ((NSString *)ret);
    }
    return (nil);
}
- (NSArray *)safe_arrayForKey:(id)key;{
    if (!key) return nil;
    id ret = [self objectForKey:key];
    if ([ret isKindOfClass:[NSArray class]]){
        return ((NSArray *)ret);
    }
    return (nil);
}

- (NSDictionary *)safe_dictionaryForKey:(id)key;{
    if (!key) return nil;
    id ret = [self objectForKey:key];
    if ([ret isKindOfClass:[NSDictionary class]]){
        return ((NSDictionary *)ret);
    }
    return (nil);
}

- (NSNumber *)safe_numberForKey:(id)key;{
    if (!key) return nil;
    id ret = [self objectForKey:key];
    if ([ret isKindOfClass:[NSNumber class]]){
        return ((NSNumber *)ret);
    }
    return (nil);
}

@end
