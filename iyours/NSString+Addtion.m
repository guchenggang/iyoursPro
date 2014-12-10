//
//  NSString+Addtion.m
//  PigPigLeague
//
//  Created by DLL on 14-6-24.
//  Copyright (c) 2014年 monster. All rights reserved.
//

#import "NSString+Addtion.h"

@implementation NSString (Addtion)

+ (NSString *)stringWithInt:(int)number
{
    return [NSString stringWithFormat:@"%d", number];
}

+ (NSString *)stringWithInteger:(NSInteger)number
{
    return [NSString stringWithLong:(long)number];
}

+ (NSString *)stringWithLong:(long)number
{
    return [NSString stringWithFormat:@"%ld", number];
}

+ (NSString *)stringWithLongLong:(long long)number
{
    return [NSString stringWithFormat:@"%lld", number];
}

+ (NSString *)stringWithDouble:(double)number
{
    return [NSString stringWithFormat:@"%f", number];
}

+ (NSString *)stringWithFloat:(float)number
{
    return [NSString stringWithFormat:@"%f", number];
}

- (id)JSONValue
{
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:[self  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    if (error && jsonObj == nil) {
        NSLog(@"JSON parse error: %@", error);
        return nil;
    }
    return jsonObj;
}

- (NSUInteger)byteLength
{
    NSUInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

+ (NSString *)JSONStringWithObject:(id)object
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
    if (error) {
        NSLog(@"JSON generate error: %@", error);
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
