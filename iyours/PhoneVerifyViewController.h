//
//  PhoneVerifyViewController.h
//  PhoneVerify
//
//  Created by bob on 14-11-30.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneVerifyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *authCodeBt;

@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

@property (weak, nonatomic) IBOutlet UITextField *authCode;

@property (weak, nonatomic) IBOutlet UIImageView *iv_icon;
- (IBAction)back;
- (IBAction)next;
- (IBAction)verify;

@end
