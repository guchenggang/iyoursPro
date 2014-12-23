//
//  课程信息实体类
//  
//
//  Created by  gcg on 14-12-17.
//  Copyright (c) 2014年 o-star. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface CourseInfo : NSObject

@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *courseId;
@property (nonatomic,copy) NSString *courseName;
@property (nonatomic,copy) NSString *logoUrl;

- (id)initWithParameters:(NSString *)nUserId
                andCourseId:(NSString *)nCourseId
                  andCourseName:(NSString *)nCourseName
              andLogoUrl:(NSString *)nLogoUrl;


@end
