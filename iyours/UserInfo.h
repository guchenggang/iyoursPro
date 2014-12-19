//
//  UserInfo.h
//  iyours
//
//  Created by 王嵩 on 14/12/19.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (strong , nonatomic) NSString *userID;

@property (strong , nonatomic) NSString *token;

@property (strong , nonatomic) NSString *username;

@property (strong , nonatomic) NSString *email;

@property (strong , nonatomic) NSString *shengId;

@property (strong , nonatomic) NSString *shengName;

@property (strong , nonatomic) NSString *cityId;

@property (strong , nonatomic) NSString *cityName;

@property (strong , nonatomic) NSString *countyId;

@property (strong , nonatomic) NSString *countyName;

@property (strong , nonatomic) NSString *schoolId;

@property (strong , nonatomic) NSString *schoolName;

@property (assign , nonatomic) int loginState;

@end
