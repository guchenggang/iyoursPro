//
//  ViewController.m
//  UILableTest
//
//  Created by 王嵩 on 14/11/3.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+StringColor.h"
#import "MBProgressHUD+Toast.h"
#import "ASIFormDataRequest.h"
#import "NSString+Addtion.h"
#import "DLLWaitingView.h"
#import "MainTabBarController.h"
#import "PhoneVerifyViewController.h"
#import "MBProgressHUD+Toast.h"
#import "UserInfo.h"
#import "AppDelegate.h"
#import "InitCourse.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    label.textColor = [UIColor whiteColor];
    label.text = @"登录";
    //设置对齐方式
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    
    [_loginBtn.layer setCornerRadius:8.0];
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#FFA63D"];
    [_regisBtn.layer setCornerRadius:8.0];
    _regisBtn.backgroundColor = [UIColor colorWithHexString:@"#FFA63D"];
    
    [self.regisBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    _username.text = @"王嵩";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)login{
    [self.username resignFirstResponder];
    [self.pwd resignFirstResponder];
    
    NSString *userName = _username.text;
    
    if (userName == nil || userName.length == 0) {
        [MBProgressHUD toastText:@"请输入用户名"];
        return;
    }
    NSString *pwd = _pwd.text;
    if (pwd == nil || pwd.length == 0) {
        [MBProgressHUD toastText:@"请输入密码"];
        return;
    }
    
    NSURL *url = [NSURL URLWithString:@"http://www.iyours.com.cn/mobile/index/login/"];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:userName  forKey:@"userName"];
    [request setPostValue:pwd forKey:@"password"];
    [request setDelegate:self];
    [request startAsynchronous];
    [DLLWaitingView showWithAnimated:YES];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [DLLWaitingView hideWithAnimated:YES];
    
    // 获取文本数据时使用
    NSString *responseString = [request responseString];
    NSLog(@"responseString = %@" , responseString);
    
    NSMutableDictionary *dict = [responseString JSONValue];
    NSNumber *state = [dict objectForKey:@"state"];
    NSInteger flag = [state integerValue];
    
    if(flag == 1){
        [MBProgressHUD toastText:@"登录成功"];
        dict = [dict objectForKey:@"userInfo"];
        
        UserInfo *user = [[UserInfo alloc] init];
        user.userID = [dict objectForKey:@"userid"];
        user.token = [dict objectForKey:@"token"];
        user.username = [dict objectForKey:@"username"];
        user.email = [dict objectForKey:@"email"];
        user.shengId = [dict objectForKey:@"shengId"];
        user.shengName = [dict objectForKey:@"shengName"];
        user.cityId = [dict objectForKey:@"cityid"];
        user.cityName = [dict objectForKey:@"cityName"];
        user.countyId = [dict objectForKey:@"countyid"];
        user.countyName = [dict objectForKey:@"countyname"];
        user.schoolId = [dict objectForKey:@"schoolid"];
        user.schoolName = [dict objectForKey:@"schoolName"];
        
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        delegate.user = user;

        
        MainTabBarController *main = [[MainTabBarController alloc] init];
        //设定转场动画 4种样式
        [main setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:main animated:YES completion:nil];
        
        InitCourse *initCourse = [[InitCourse alloc] init];
        [initCourse initWithParameters:@"27" andToken:@"111111"];

    }else{
        NSString *message = [dict objectForKey:@"message"];
        [MBProgressHUD toastText:message];
    }
    
   
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"error = %@" , error);
    [DLLWaitingView hideWithAnimated:YES];
    [MBProgressHUD toastText:@"登录失败"];
}

- (void)toRegister{
    [self.username resignFirstResponder];
    [self.pwd resignFirstResponder];
    
    PhoneVerifyViewController *viewController = [[PhoneVerifyViewController alloc] initWithNibName:@"PhoneVerifyViewController" bundle:nil];
    
    
    [self presentViewController:viewController animated:YES completion:nil];
    
    NSLog(@"register");
    
}

- (IBAction)closeKeyboard:(id)sender {
    [self.username resignFirstResponder];
    [self.pwd resignFirstResponder];
}

@end
