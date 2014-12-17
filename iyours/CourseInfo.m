//
//  CourseInfo.m
//  iyours
//
//  Created by gcg on 14-12-17.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import "CourseInfo.h"

@implementation CourseInfo

- (id)initWithParameters:(NSString *)nUserId
             andCourseId:(NSString *)nCourseId
           andCourseName:(NSString *)nCourseName
              andLogoUrl:(NSString *)nLogoUrl
{
    CourseInfo *n = [[CourseInfo alloc] init];
    n.userId = nUserId;
    n.courseId = nCourseId;
    n.courseName = nCourseName;
    n.logoUrl = nLogoUrl;
    return n;
    
    
}


@end
