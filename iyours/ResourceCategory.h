//
//  ResourceCategory.h
//  iyours
//
//  Created by 王嵩 on 14/12/11.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResourceCategory : NSObject

//课程编号
@property (strong , nonatomic) NSString *resId;

//类别编号
@property (strong , nonatomic) NSString *rescateId;

//类别名称
@property (strong , nonatomic) NSString *rescateName;

//课程图标
@property (strong , nonatomic) NSString *logoUrl;


@end
