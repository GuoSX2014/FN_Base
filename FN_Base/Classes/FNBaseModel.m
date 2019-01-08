//
//  FNBaseModel.m
//  FNYunWei2
//
//  Created by Adward on 2018/7/31.
//  Copyright © 2018年 FN. All rights reserved.
//

#import "FNBaseModel.h"
#import <MJExtension/MJExtension.h>

@implementation FNBaseModel
//编码
- (void)encodeWithCoder:(NSCoder *)coder
{
    Class cls = [self class];
    while (cls != [NSObject class]) {
        BOOL isSelfClass = (cls == [self class]);
        unsigned int varCount = 0;
        unsigned int properCount = 0;
        Ivar *ivarList = isSelfClass ? class_copyIvarList([self class], &varCount) : NULL;
        objc_property_t *propertyList = isSelfClass ? NULL : class_copyPropertyList(cls, &properCount);
        
        unsigned int finalCount = isSelfClass ? varCount : properCount;
        for (int i = 0; i < finalCount; i++) {
            const char *varName = isSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propertyList + i));
            NSString *key = [NSString stringWithUTF8String:varName];
            id varValue = [self valueForKey:key];//使用KVC获取key对应的变量值
            NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"];
            if (varValue && [filters containsObject:key] == NO) {
                [coder encodeObject:varValue forKey:key];
            }
        }
        free(ivarList);
        free(propertyList);
        cls = class_getSuperclass(cls);
    }
    
}
//解码
- (id)initWithCoder:(NSCoder *)coder
{
    Class cls = [self class];
    while (cls != [NSObject class]) {
        BOOL isSelfClass = (cls == [self class]);
        unsigned int iVarCount = 0;
        unsigned int propertyCount = 0;
        
        objc_property_t *propertyList = isSelfClass ? NULL : class_copyPropertyList(cls, &propertyCount);
        Ivar *ivarList =  isSelfClass ? class_copyIvarList(cls, &iVarCount) :NULL;
        
        unsigned int finalCount = isSelfClass ? iVarCount : propertyCount;
        
        for (int i = 0; i < finalCount; i++) {
            const char * varName = isSelfClass ? ivar_getName(*(ivarList + i)) :property_getName(*(propertyList + i));//取得变量名字，将作为key
            NSString *key = [NSString stringWithUTF8String:varName];
            //decode
            id  value = [coder decodeObjectForKey:key];//解码
            NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"];
            if (value && [filters containsObject:key] == NO) {
                [self setValue:value forKey:key];//使用KVC强制写入到对象中
            }
        }
        free(ivarList);//记得释放内存
        free(propertyList);
        cls = class_getSuperclass(cls);
    }
    
    return self;
}
//过滤返回的数据为nil
-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
  
    if (!oldValue || [oldValue isKindOfClass:[NSNull class]]) {
        if (property.type.typeClass == [NSString class]) {
            return @"";
        }
    }
    return oldValue;
}

@end
