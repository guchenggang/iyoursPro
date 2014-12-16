//
//  PhoneVerifyViewController.m
//  PhoneVerify
//
//  Created by bob on 14-11-30.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "PhoneVerifyViewController.h"
#import "RegisterViewController.h"
#import "RegisterItem.h"
#import "MBProgressHUD+Toast.h"
#import "DLLWaitingView.h"
@interface PhoneVerifyViewController ()<UITextFieldDelegate>
{
    //计时器
    NSTimer *timer;
    //倒计时秒
    int second;
    //验证码
    NSString *code;
    //是否验证成功
    BOOL isVerifySuccess;
}
@end

@implementation PhoneVerifyViewController

- (IBAction)back {
    NSLog(@"back");
}

- (IBAction)next {
    NSLog(@"next");
    if (isVerifySuccess) {
        NSLog(@"验证成功");
        RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
        
        RegisterItem *bean = [RegisterItem new];
        bean.mobile = _phoneNum.text;
        registerViewController.registerItem = bean;
        
        [self presentViewController:registerViewController animated:YES completion:nil];
    }else{
        [MBProgressHUD toastText:@"请填写正确的验证码"];
    }
}

- (void)verify{
//1.验证输入电话正确性
    BOOL isOk = [self validateMobile:_phoneNum.text];
    if (isOk) {
//2.获取验证码并倒计时
        [DLLWaitingView showWithAnimated:YES];
        [self doingVerify];
    }else{
        NSLog(@"请输入正确的手机号");
        // 1.创建弹框
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入正确的手机号" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//        
//        // 设置样式（一个明文文本框）
//        alert.alertViewStyle = UIAlertViewStyleDefault;
//        // 2.2显示弹框
//        [alert show];
         [MBProgressHUD toastText:@"请输入正确的手机号"];
    }

    

}
#pragma mark get请求
-(void)doingVerify{
    NSLog(@"请求网络");

    
    NSString *urlPath = [NSString stringWithFormat:@"http://www.iyours.com.cn/mobile/index/checkPhone?mobile=%@",_phoneNum.text];
    NSError *error;
    //开始倒计时
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:urlPath];
    NSLog(@"urlpath = %@",urlPath);
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *verify =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
    NSString *state = [verify objectForKey:@"state"];
    NSString *message = [verify objectForKey:@"message"];
    NSString *verifyCode=  [verify objectForKey:@"verifyCode"];
    
    NSNumberFormatter *num = [[NSNumberFormatter alloc]init];
    
    code = [num stringFromNumber:verifyCode];
    
    NSLog(@"state = %@  message = %@  verifyCoce = %@",state,message,verifyCode);
    NSLog(@"code = %@",code);
     [DLLWaitingView hideWithAnimated:YES];
    //  开始计时
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFiredMethod:) userInfo:nil repeats:YES];
    //
}
-(void)timerFiredMethod:(NSTimer *)theTimer{

    if (second == 1) {
        [theTimer invalidate];
        
        second = 60;
        
        [_authCodeBt setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_authCodeBt setEnabled:YES];
        
    }else{
    
        second--;
        
        NSString *title = [NSString stringWithFormat:@"%i秒",second];
        [_authCodeBt setTitle:title forState:UIControlStateNormal];
        [_authCodeBt setEnabled:NO];
    
    
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    code = [[NSString alloc]init];
    second = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 监听验证码输入
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int code_len = textField.text.length;
    NSString *code_inp = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"输入内容的长度%d",code_len);
    NSLog(@"code = %@  code_inp = %@",code,code_inp);
    if (code_len >=3) {
        if ([code isEqualToString:code_inp]) {
            _iv_icon.image = [UIImage imageNamed:@"icon_correct.png"];
            isVerifySuccess = true;
            NSLog(@"成功");
        }else{
            _iv_icon.image = [UIImage imageNamed:@"icon_error.png"];
            isVerifySuccess = false;
            NSLog(@"失败");
        }
        
        
    }else{
        _iv_icon.image = nil;
        isVerifySuccess = false;
    }


    return YES;
}

#pragma mark 正则验证手机号码
- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
