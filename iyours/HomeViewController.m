//
//  HomeViewController.m
//  iyours
//
//  Created by 王嵩 on 14/12/10.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import "HomeViewController.h"
#import "ASIFormDataRequest.h"
#import "NSString+Addtion.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)onClick:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.iyours.com.cn/mobile/index/login/"];
    //    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    //    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"王嵩"  forKey:@"userName"];
    [request setPostValue:@"123456" forKey:@"password"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    
    // 获取文本数据时使用
    NSString *responseString = [request responseString];
    
    
    NSMutableDictionary *dict = [responseString JSONValue];
    NSNumber *state = [dict objectForKey:@"state"];
    
    NSArray *array = [dict allValues];
    NSLog(@"responseString = %@" , responseString);
    NSLog(@"dict = %@" , dict);
    NSLog(@"state = %@" , state);
    NSLog(@"array = %@" , array);
    
    
    // 在抓取时使用二进制数据
    //    NSData *responseData = [request responseData];
    //    NSLog(@"responseData = %@" , responseData);
    
}
@end
