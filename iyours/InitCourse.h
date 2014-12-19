//
//  InitCourse.h
//  iyours
//
//  Created by gcg on 14-12-17.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InitCourse : NSObject

@property BOOL result;
@property NSString *userId;


- (BOOL)initWithParameters:(NSString *)nUserId
                  andToken:(NSString *)token;
- (BOOL) saveCourseInfoToLocal:(NSArray *) courseArray;
- (BOOL) saveCategoryToLocal:(NSArray *) cateArray;
- (BOOL) savePropertyToLocal:(NSArray *) propArray;




@end
