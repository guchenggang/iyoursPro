//
//  RegisterViewController.m
//  PhoneVerify
//
//  Created by bob on 14-12-8.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterItem.h"
#import "Provinces.h"
#import "ProvincesViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _provinces = [Provinces new];
    NSLog(@"phoneNum = %@",_registerItem.mobile);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back {
    NSLog(@"back");
}

- (IBAction)submit {
    NSLog(@"submit");
    //判空
    if (_nickName.text.length == 0) {
        _nickName.backgroundColor = [UIColor redColor];
        _registerItem.nickName = nil;
        NSLog(@"昵称不能为空");
    }else{
        _nickName.backgroundColor = [UIColor whiteColor];
        _registerItem.nickName = _nickName.text;
    }
    
    if (_password.text.length == 0) {
        _password.backgroundColor = [UIColor redColor];
        _registerItem.password = nil;
         NSLog(@"密码不能为空");
    }else{
        _password.backgroundColor = [UIColor whiteColor];
        _registerItem.password = _password.text;
    }
    
    if (_repassword.text.length == 0) {
        _repassword.backgroundColor = [UIColor redColor];
         NSLog(@"确认密码不能为空");
    }else{
        _repassword.backgroundColor = [UIColor whiteColor];
    }
    
    if (_lastName.text.length == 0) {
        _lastName.backgroundColor = [UIColor redColor];
        _registerItem.lastName = nil;
         NSLog(@"姓不能为空");
    }else{
        _lastName.backgroundColor = [UIColor whiteColor];
        _registerItem.lastName = _lastName.text;
    }
    
    if (_firstName.text.length == 0) {
        _firstName.backgroundColor = [UIColor redColor];
        _registerItem.firstName = nil;
         NSLog(@"名不能为空");
    }else{
        _firstName.backgroundColor = [UIColor whiteColor];
        _registerItem.firstName = _firstName.text;
    }
    
    if (_email.text.length == 0) {
        _email.backgroundColor = [UIColor redColor];
        _registerItem.email = nil;
         NSLog(@"邮箱不能为空");
    }else{
        _email.backgroundColor = [UIColor whiteColor];
        _registerItem.email = _email.text;
    }
    
    if (![_password.text isEqualToString:_repassword.text ]) {
        _repassword.backgroundColor = [UIColor redColor];
         NSLog(@"密码与确认密码不一致");
        

    }
    _registerItem.schoolName = _school.text;
    
    NSLog(@"姓名：%@ 密码： %@ 确认密码： %@ 电话： %@  姓： %@ 名： %@ email： %@ 省 ：%@ 市 ： %@ 县区 ：%@ 幼儿园： %@",_registerItem.nickName,_registerItem.password,_registerItem.password,_registerItem.mobile,_registerItem.lastName,_registerItem.firstName,_registerItem.email,_registerItem.shengId,_registerItem.cityId,_registerItem.countyId,_registerItem.schoolName);
    //请求网络
    [self registerInfo];
}

-(void)registerInfo{
    NSString *urlPath = [NSString stringWithFormat:@"http://www.iyours.com.cn/mobile/index/register?nickName=%@&password=%@&mobile=%@&lastName=%@&fristName=%@&email=%@&shengId=%@&cityId=%@&countyId=%@&schoolName=%@",_registerItem.nickName,_registerItem.password,_registerItem.mobile,_registerItem.lastName,_registerItem.firstName,_registerItem.email,_registerItem.shengId,_registerItem.cityId,_registerItem.countyId,_registerItem.schoolName];
    
    NSError *error;
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

    
    NSLog(@"state = %@  message = %@  ",state,message);


}
- (IBAction)getProvince{
    NSLog(@"getProvince");
    
    ProvincesViewController *provincesViewController = [[ProvincesViewController alloc] initWithNibName:@"ProvincesViewController" bundle:nil];
    
    provincesViewController.flag = 1;
    provincesViewController.delegate=self;
    [self presentViewController:provincesViewController animated:YES completion:nil];
    
    
}

- (IBAction)getCity {
    NSLog(@"getCity");
    
    ProvincesViewController *provincesViewController = [[ProvincesViewController alloc] initWithNibName:@"ProvincesViewController" bundle:nil];
    
    provincesViewController.flag = 2;
    provincesViewController.parentId =_provinces.shengId;
//    provincesViewController.sheng =_provinces.sheng;
//    provincesViewController.shengId =_provinces.shengId;
    provincesViewController.delegate=self;
    [self presentViewController:provincesViewController animated:YES completion:nil];
    
}

- (IBAction)getCounty {
    NSLog(@"getCounty");
    
    ProvincesViewController *provincesViewController = [[ProvincesViewController alloc] initWithNibName:@"ProvincesViewController" bundle:nil];
    
    provincesViewController.flag = 3;
    provincesViewController.parentId =_provinces.cityId;
//    provincesViewController.city =_provinces.city;
//    provincesViewController.cityId =_provinces.cityId;
    provincesViewController.delegate=self;
    [self presentViewController:provincesViewController animated:YES completion:nil];
    
}
//-(void)setProvinces:(Provinces *)provinces
//{
//
//    
//
//}
-(void)setProvinces:(Provinces *)provinces Flag:(int)flag
{
    NSLog(@"setProvinces:  shengid=%@ sheng=%@ cityid=%@ city=%@ countryid=%@ country=%@",provinces.shengId,provinces.sheng,provinces.cityId,provinces.city,provinces.countyId,provinces.county);
    NSLog(@"flag = %d",flag);
    switch (flag) {
        case 1:
            NSLog(@"provinces.shengId = %@",provinces.shengId);
            _provinces.shengId =provinces.shengId;
            _provinces.sheng =provinces.sheng;
            _provinces.cityId =provinces.cityId;
            _provinces.city = provinces.city;
            _provinces.countyId = provinces.countyId;
            _provinces.county = provinces.county;
            
            //放在注册发送数据用的bean
            _registerItem.shengId =provinces.shengId;
            _registerItem.cityId =provinces.cityId;
            _registerItem.countyId =provinces.countyId;
            break;
            
        case 2:
            _provinces.cityId =provinces.cityId;
            _provinces.city =provinces.city;
            _provinces.countyId = provinces.countyId;
            _provinces.county = provinces.county;
            //
            _registerItem.cityId =provinces.cityId;
            _registerItem.countyId =provinces.countyId;
            break;
        case 3:
            _provinces.countyId =provinces.countyId;
            _provinces.county =provinces.county;
            
            _registerItem.countyId = provinces.countyId;
            break;
    }
//    _provinces = provinces;
    
    NSLog(@"sheng = %@",_provinces.sheng);
    [_province setTitle:_provinces.sheng forState:UIControlStateNormal];
    [_city setTitle:_provinces.city forState:UIControlStateNormal];
    [_county setTitle:_provinces.county forState:UIControlStateNormal];
}
@end
