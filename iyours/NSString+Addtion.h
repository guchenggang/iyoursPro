//
//  NSString+Addtion.h
//  PigPigLeague
//
//  Created by DLL on 14-6-24.
//  Copyright (c) 2014年 monster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addtion)

+ (NSString *)stringWithInt:(int)number;

+ (NSString *)stringWithInteger:(NSInteger)number;

+ (NSString *)stringWithLong:(long)number;

+ (NSString *)stringWithLongLong:(long long)number;

+ (NSString *)stringWithDouble:(double)number;

+ (NSString *)stringWithFloat:(float)number;

- (id)JSONValue;

+ (NSString *)JSONStringWithObject:(id)object;

- (NSUInteger)byteLength;

@end
