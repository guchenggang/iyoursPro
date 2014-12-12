//
//  CustomProgress.m
//  ChinaBond
//
//  Created by DLL on 14/11/13.
//  Copyright (c) 2014年 chinabond. All rights reserved.
//

#import "CustomProgress.h"

NSString *const CustomProgressAnimationKey = @"CustomProgressAnimationKey";

@implementation CustomProgress


#pragma mark - Control animation

- (void)startAnimating {
    _animating = YES;
    
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spinAnimation.toValue        = @(1*2*M_PI);
    spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    spinAnimation.duration       = 1.0;
    spinAnimation.repeatCount    = INFINITY;
    [self.layer addAnimation:spinAnimation forKey:CustomProgressAnimationKey];
    
    if (self.hidesWhenStopped) {
        self.hidden = NO;
    }
}

- (void)stopAnimating {
    _animating = NO;
    
    [self.layer removeAnimationForKey:CustomProgressAnimationKey];
    
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
}

- (BOOL)isAnimating {
    return _animating;
}


@end
