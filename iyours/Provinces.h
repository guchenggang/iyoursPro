//
//  Provinces.h
//  PhoneVerifyDemo
//
//  Created by bob on 14-12-10.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Provinces : NSObject
//省
@property (nonatomic,retain) NSString *shengId;
@property (nonatomic,retain) NSString *sheng;
//市
@property (nonatomic,retain) NSString *cityId;
@property (nonatomic,retain) NSString *city;
//区
@property (nonatomic,retain) NSString *countyId;
@property (nonatomic,retain) NSString *county;
@end
