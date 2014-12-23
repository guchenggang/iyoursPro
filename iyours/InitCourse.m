//
//  InitCourse.m
//  iyours
//
//  Created by bob on 14-12-17.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import "InitCourse.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"
#import "CourseInfo.h"
#import "CourseDBUtils.h"
#import "ResourceCategory.h"

@implementation InitCourse



- (BOOL)initWithParameters:(NSString *)nUserId
                  andToken:(NSString *)token
{
    self.result = NO;
    self.userId = nUserId;
    
    
    
//    NSString *str=[baseUrl stringByAppendingString:nUserName];
    
    //初始化本地库，将来移到appdelegate.m
    [CourseDBUtils initDatabase];

    NSString *str=[NSString stringWithFormat:@"http://www.iyours.com.cn/mobile/index/initCourse?userId=%@&token=%@",nUserId,token];

    NSLog(@"获取到的url：%@",str);

    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       
        
        NSString *html = operation.responseString;
        
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSString *state = [dict objectForKey:@"state"];
        NSArray *courseArray = [dict objectForKey:@"courseList"];
        NSArray *cateArray = [dict objectForKey:@"cateList"];
        NSArray *propArray = [dict objectForKey:@"propList"];
        if (state.intValue==1 && courseArray != nil && ([courseArray count] >0)){
            [self saveCourseInfoToLocal:courseArray];
            [self saveCategoryToLocal:cateArray];
            [self savePropertyToLocal:propArray];
            
            //从本地库获取数据。
          //  NSArray *newArray = [CourseDBUtils getCourseInfo:self.userId];
          //  NSArray *newArray1 = [CourseDBUtils getCategory:@"8001"];
          //  NSArray *newArray2 = [CourseDBUtils getResProperty:@"8001"];
          //  NSLog(@"获取到的本地数据为：%@",newArray);
          //  NSLog(@"获取到的本地数据1为：%@",newArray1);
          //  NSLog(@"获取到的本地数据2为：%@",newArray2);
        }
        
        self.result = YES;
//        NSLog(@"获取到的数据为：%@",dict);
  //      NSLog(@"获取到的courseList为：%@",courseArray);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"发生错误！%@",error);
        
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:operation];
    
    return self.result;
};
- (BOOL) saveCourseInfoToLocal:(NSArray *) courseArray
{
    BOOL flag = YES;
    
    if (courseArray!=nil && ([courseArray count] > 0)){
        
        //删除原始数据
        [CourseDBUtils delAllCourseInfo:self.userId];
        
    }
    
    for (NSDictionary *dic in courseArray) {
            CourseInfo *info = [[CourseInfo alloc] init];
             //读出字段
             info.courseId = [dic objectForKey:@"courseId"];
             info.courseName = [dic objectForKey:@"courseName"];
             info.logoUrl = [dic objectForKey:@"logoUrl"];
             info.userId = self.userId;
            // NSLog(@"获取到的course为：%@",info);

            //添加课程数据
            [CourseDBUtils addCourseInfo:info];
 
        
    }
    return flag;
    
};
- (BOOL) saveCategoryToLocal:(NSArray *) cateArray
{
    BOOL flag = YES;
    
    
   //删除原始数据
   [CourseDBUtils delAllCategory];
        
    
    for (NSDictionary *dic in cateArray) {
        ResourceCategory *category = [[ResourceCategory alloc] init];
        //读出字段
        category.resId = [dic objectForKey:@"courseId"];
        category.rescateName = [dic objectForKey:@"cateName"];
        category.logoUrl = [dic objectForKey:@"logoUrl"];
        category.rescateId = [dic objectForKey:@"cateId"];
        // NSLog(@"获取到的course为：%@",info);
        
        //添加课程数据
        [CourseDBUtils addCategory:category];
        
        
    }
    return flag;

    
};
- (BOOL) savePropertyToLocal:(NSArray *) propArray
{

    BOOL flag = YES;
    
    
    //删除原始数据
    [CourseDBUtils delAllResProperty];
    
    
    for (NSDictionary *dic in propArray) {
        ResProperty *resProperty = [[ResProperty alloc] init];
        //读出字段
        resProperty.propId = [dic objectForKey:@"propId"];
        resProperty.propName = [dic objectForKey:@"propName"];
        resProperty.parentId = [dic objectForKey:@"parentId"];
        resProperty.courseId = [dic objectForKey:@"courseId"];
        resProperty.orderNum = [dic objectForKey:@"orderNum"];
        // NSLog(@"获取到的course为：%@",info);
        
        //添加课程属性数据
        [CourseDBUtils addResProperty:resProperty];
        
        
    }
    return flag;
    
};


@end
