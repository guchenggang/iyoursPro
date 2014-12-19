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

@implementation InitCourse



- (BOOL)initWithParameters:(NSString *)nUserId
                  andToken:(NSString *)token
{
    self.result = NO;
    self.userId = nUserId;
    
    
    
//    NSString *str=[baseUrl stringByAppendingString:nUserName];

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
        BOOL flag = [self saveCourseInfoToLocal:courseArray];
        
        self.result = YES;
        NSLog(@"获取到的数据为：%@",dict);
        NSLog(@"获取到的state为：%@",state);
        NSLog(@"获取到的courseList为：%@",courseArray);
        
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
    
    for (NSDictionary *dic in courseArray) {
            CourseInfo *info = [[CourseInfo alloc] init];
             //读出字段
             info.courseId = [dic objectForKey:@"courseId"];
             info.courseName = [dic objectForKey:@"courseName"];
             info.logoUrl = [dic objectForKey:@"logoUrl"];
             NSLog(@"获取到的course为：%@",info);
        
        
    }
    return flag;
};
- (BOOL) saveCategoryToLocal:(NSArray *) cateArray
{
    return NO;
};
- (BOOL) savePropertyToLocal:(NSArray *) propArray
{
    return NO;
    
};


@end
