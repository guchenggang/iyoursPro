//
//  RegionInfo.h
//  PhoneVerifyDemo
//
//  Created by bob on 14-12-9.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegionInfo : NSObject
@property (nonatomic) int keyId;
@property (nonatomic,retain) NSString *regid;//地区编码
@property (nonatomic,retain) NSString *regname;//地区名称
@property (nonatomic,retain) NSString *parent;//地区父节点
@property (nonatomic) int regtype;//类型（1：省2：市3：区县）


@end
