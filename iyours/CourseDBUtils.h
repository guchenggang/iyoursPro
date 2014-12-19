//
//  CourseDBUtils.h
//  iyours
//
//  Created by gcg on 14-12-19.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseInfo.h"
#import "FMDB.h"

@interface CourseDBUtils : NSObject

@property FMDatabase *db;

+ (id) openDatabase;
+ (BOOL) initDatabase ;
+ (BOOL) addCourseInfo : (CourseInfo *) info ;
+ (BOOL) delAllCourseInfo : (NSString *) userId ;


@end
