//
//  UIColor+StringColor.h
//  标签栏视图
//
//  Created by 王嵩 on 14/12/10.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (StringColor)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/**
 十六进制色
 **/
+ (UIColor  *)colorWithHex:(NSString *)hexColor;

/**
 ARGB十进制
 **/
+ (UIColor *)colorWithDecimalismRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;

/**
 RGB十进制
 **/
+ (UIColor *)colorWithDecimalismRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;

/**
 灰色
 **/
+ (UIColor *)colorWithDecimalismWhite:(NSUInteger)white;

/**
 灰色+透明度
 **/
+ (UIColor *)colorWithDecimalismWhite:(NSUInteger)white alpha:(CGFloat)alpha;

@end
