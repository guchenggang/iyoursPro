//
//  UIColor+StringColor.m
//  标签栏视图
//
//  Created by 王嵩 on 14/12/10.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "UIColor+StringColor.h"

@implementation UIColor (StringColor)

#pragma mark 将16进制颜色如#FF0000，转换为UIColor
#define DEFAULT_VOID_COLOR [UIColor whiteColor]
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor  *)colorWithHex:(NSString *)hexColor
{
    unsigned int red, green, blue;
    float alpha = 1.0f;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    if (hexColor.length == 8) {
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexFloat:&alpha];
        range.location += 2;
    }
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location += 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location += 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

+ (UIColor *)colorWithDecimalismRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha];
}

+ (UIColor *)colorWithDecimalismRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue
{
    return [self colorWithDecimalismRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWithDecimalismWhite:(NSUInteger)white
{
    return [self colorWithDecimalismWhite:white alpha:1.0f];
}

+ (UIColor *)colorWithDecimalismWhite:(NSUInteger)white alpha:(CGFloat)alpha
{
    return [self colorWithWhite:white / 255.0f alpha:white];
}




@end
