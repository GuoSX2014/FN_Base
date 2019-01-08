//
//  FNMethodMacros.h
//  FNYunWei
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#ifndef FNMethodMacros_h
#define FNMethodMacros_h

/**
 *  去除调试状态的跟踪信息
 */
#ifdef DEBUG
#define NSLog(FORMAT, ...) do{fprintf(stderr, "<%s %s:%d>-:%s\n\n", [[[[NSDate date] dateByAddingTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate date]]].description substringWithRange:NSMakeRange(11, 8)] UTF8String],[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);}while(0)
#else
#define NSLog(...) {}
#endif

/**
 *  图片的宏定义
 */
#define loadImageByFileNameAndType(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@",file,iPhone6Plus ? @"@3x" : @"@2x"] ofType:ext]]

#define loadImageByFileName(file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@",file,iPhone6Plus ? @"@3x" : @"@2x"] ofType:@"png"]]

#define loadImageByName(imgName)  [UIImage imageNamed:imgName] //加载图片
/**
 *  加载网络图片
 */
#define loadImageByUrl(imageUrl)  [NSURL URLWithString:imageUrl]

/**
 *  view圆角
 */
#define viewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]



/**
 *  强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 *  调用方式: `@weakify_self`实现弱引用转换，`@strongify_self`实现强引用转换
 *
 *  示例：
 *  @weakify_self
 *  [obj block:^{
 *  @strongify_self
 *      self.property = something;
 *  }];
 */
#ifndef    weakify_self
#if __has_feature(objc_arc)
#define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif
#ifndef    strongify_self
#if __has_feature(objc_arc)
#define strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif
#endif

/**
 *  强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 *  调用方式: `@weakify(object)`实现弱引用转换，`@strongify(object)`实现强引用转换
 *
 *  示例：
 *  @weakify(object)
 *  [obj block:^{
 *      @strongify(object)
 *      strong_object = something;
 *  }];
 */
#ifndef    weakify
#if __has_feature(objc_arc)
#define weakify(object)    autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object)    autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#endif
#ifndef    strongify
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = block##_##object;
#endif

#endif /* FNMethodMacros_h */
