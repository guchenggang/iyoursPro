//
//  UIColor+Addtion.m
//  UIBuilder
//
//  Created by ifuninfo on 13-1-5.
//  Copyright (c) 2013年 ifuninfo. All rights reserved.
//

#import "UIColor+Addtion.h"

@implementation UIColor (Addtion)
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
