//
//  ResourceCategory.m
//  iyours
//
//  Created by 王嵩 on 14/12/11.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import "ResourceCategory.h"

@implementation ResourceCategory

-(NSString *)description
{
    return [NSString stringWithFormat:@"resId = %@ , rescateId = %@ , rescateName = %@ , logoUrl = %@" , _resId , _rescateId , _rescateName , _logoUrl ];
}

@end
