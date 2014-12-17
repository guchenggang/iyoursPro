//
//  InitCourse.h
//  iyours
//
//  Created by gcg on 14-12-17.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InitCourse : NSObject

+ (BOOL)initWithParameters:(NSString *)nUserName
                  andToken:(NSString *)token;
- (BOOL) saveCourseInfo:(NSArray *) infoArray;
- (BOOL) saveCategory:(NSArray *) cateArray;
- (BOOL) saveProperty:(NSArray *) propArray;




@end
