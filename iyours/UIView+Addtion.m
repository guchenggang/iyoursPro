//
//  UIView+Addtion.m
//  PigPigLeague
//
//  Created by DLL on 14-6-24.
//  Copyright (c) 2014年 monster. All rights reserved.
//

#import "UIView+Addtion.h"

@implementation UIView (Addtion)

- (void)setToTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setToLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setMoveX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x += x;
    self.frame = frame;
}

- (void)setMoveY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y += y;
    self.frame = frame;
}

- (void)setToRight:(CGFloat)right
{
    [self setToLeft:self.superview.frame.size.width - right - self.frame.size.width];
}

- (void)setToBottom:(CGFloat)bottom
{
    [self setToTop:self.superview.frame.size.height - bottom - self.frame.size.height];
}

- (void)setInCenter
{
    CGPoint center = CGPointMake(self.superview.bounds.size.width / 2, self.superview.bounds.size.height / 2);
    self.center = center;
}

- (void)setInCenterHorizontal
{
    CGPoint center = self.center;
    center.x = self.superview.bounds.size.width / 2;
    self.center = center;
}

- (void)setInCenterVertical
{
    CGPoint center = self.center;
    center.y = self.superview.bounds.size.height / 2;
    self.center = center;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeightDelta:(CGFloat)delta
{
    [self setHeight:self.bounds.size.height + delta];
}

- (void)setWidthDelta:(CGFloat)delta
{
    [self setWidth:self.bounds.size.width + delta];
}

@end
