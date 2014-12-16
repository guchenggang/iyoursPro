//
//  RegisterViewController.h
//  PhoneVerify
//
//  Created by bob on 14-12-8.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProvincesDelegate;
@class RegisterItem;
@class Provinces;
@interface RegisterViewController : UIViewController<ProvincesDelegate>
@property (nonatomic,retain) RegisterItem *registerItem;
@property (nonatomic,retain) Provinces *provinces;
//----------控件引用
@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repassword;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIButton *province;
@property (weak, nonatomic) IBOutlet UIButton *city;
@property (weak, nonatomic) IBOutlet UIButton *county;
@property (weak, nonatomic) IBOutlet UITextField *school;

//----------按钮方法
//返回
- (IBAction)back;
//完成按钮
- (IBAction)submit;
//获得省信息按钮
- (IBAction)getProvince;
- (IBAction)getCity;
- (IBAction)getCounty;

@end
