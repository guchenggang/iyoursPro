//
//  ProvincesViewController.h
//  PhoneVerifyDemo
//
//  Created by bob on 14-12-9.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegisterViewController;
@class Provinces;
@protocol ProvincesDelegate <NSObject>

-(void)setProvinces:(Provinces *)provinces Flag:(int)flag;

@end

@interface ProvincesViewController : UIViewController
@property(nonatomic,retain)id<ProvincesDelegate>delegate;
//判断省市区
@property (nonatomic) int flag;
//查询时用的父ID
@property (nonatomic) NSString *parentId;
@property (nonatomic) NSString *sheng;
@property (nonatomic) NSString *shengId;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *cityId;

- (IBAction)back;

@end
