//
//  ViewController.h
//  UILableTest
//
//  Created by 王嵩 on 14/11/3.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController{
}

@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *pwd;
@property (strong, nonatomic) IBOutlet UIButton *regisBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)closeKeyboard:(id)sender;

-(IBAction)login;


@end

