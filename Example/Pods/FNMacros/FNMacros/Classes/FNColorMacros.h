//
//  FNColorMacros.h
//  FNYunWei
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#ifndef FNColorMacros_h
#define FNColorMacros_h

//颜色

/**
 十六进制颜色赋值

 @param rgbValue 色值
 @param al 透明度
 @return color
 */
#define HexRGBA(rgbValue,al) [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:al]
/**
 十六进制颜色赋值
 
 @param rgbValue 色值
 @return color
 */
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]
/**
 256颜色赋值
 
 @param vaule 色值
 @return color
 */
#define COLOR_VAULE(vaule)[UIColor colorWithRed:vaule/255.0 green:vaule/255.0 blue:vaule/255.0 alpha:1.0]
/**
 256进制颜色赋值
 
 @param vaule 色值
 @param al 透明度
 @return color
 */
#define COLOR_VAULEA(vaule,al)[UIColor colorWithRed:vaule/255.0 green:vaule/255.0 blue:vaule/255.0 alpha:al]
#define COLOR_DIFFERENT_VAULE(a,b,c)[UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0]

/**  随机颜色  */

#define COLOR_Random [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]

#endif /* FNColorMacros_h */


