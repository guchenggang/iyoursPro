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
    // Dispose of any resources that can be recreated.
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
    
    NSLog(@"username = %@ pwd = %@" , userName , pwd);
    
//     NSURL *url = [NSURL URLWithString:@"http://www.iyours.com.cn/mobile/index/login/"];
//    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
//    [request setPostValue:userName  forKey:@"userName"];
//    [request setPostValue:pwd forKey:@"password"];
//    [request setDelegate:self];
//    [request startAsynchronous];
//    [DLLWaitingView showWithAnimated:YES];
    
    
    MainTabBarController *main = [[MainTabBarController alloc] init];
    //设定转场动画 4种样式
    [main setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:main animated:YES completion:nil];

    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [DLLWaitingView hideWithAnimated:YES];
    
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
    
    
    MainTabBarController *main = [[MainTabBarController alloc] init];
    //设定转场动画 4种样式
    [main setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:main animated:YES completion:nil];

    
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
