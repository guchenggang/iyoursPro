//
//  UIView+Addtion.h
//  PigPigLeague
//
//  Created by DLL on 14-6-24.
//  Copyright (c) 2014年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addtion)

/**
 设置frame.origin.y
 **/
- (void)setToTop:(CGFloat)top;

/**
 设置frame.origin.x
 **/
- (void)setToLeft:(CGFloat)left;

/**
 设置X轴平移
 **/
- (void)setMoveX:(CGFloat)x;

/**
 设置Y轴平移
 **/
- (void)setMoveY:(CGFloat)y;

/**
 设置右边距
 **/
- (void)setToRight:(CGFloat)right;

/**
 设置底边距
 **/
- (void)setToBottom:(CGFloat)bottom;

/**
 设置居中
 **/
- (void)setInCenter;

/**
 设置水平居中
 **/
- (void)setInCenterHorizontal;

/**
 设置垂直居中
 **/
- (void)setInCenterVertical;

/**
 设置高度
 **/
- (void)setHeight:(CGFloat)height;

/**
 设置宽度
 **/
- (void)setWidth:(CGFloat)width;

- (void)setHeightDelta:(CGFloat)delta;

- (void)setWidthDelta:(CGFloat)delta;

@end
