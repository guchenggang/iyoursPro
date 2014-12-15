//
//  UILabel+Addtion.m
//  QiangDan
//
//  Created by DLL on 14-7-10.
//  Copyright (c) 2014年 dll. All rights reserved.
//

#import "UILabel+Addtion.h"

@implementation UILabel (Addtion)

- (CGSize)resizeHeight
{
    CGFloat height = ceil([self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.bounds.size.width, 2000) lineBreakMode:NSLineBreakByWordWrapping].height);

    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    return frame.size;
}

- (CGSize)resizeWithMaxWidth:(CGFloat)maxWidth
{
    CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(maxWidth, 2000) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect frame = self.frame;
    frame.size.width = ceilf(size.width);
    frame.size.height = ceilf(size.height);
    self.frame = frame;
    return frame.size;
}

@end
