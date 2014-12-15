//
//  WaitingView.h
//  PigPigLeague
//
//  Created by DLL on 14-6-9.
//  Copyright (c) 2014年 DLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomProgress.h"
#import "DLLMaskWindow.h"

/**
 等待窗
 **/
@interface DLLWaitingView : UIView {
    CustomProgress *_indicatorView;
    BOOL _isShown;
}


@property (nonatomic, readonly) UILabel *label;

+ (instancetype)sharedView;

- (void)showWithAnimated:(BOOL)animated;

- (void)hideWithAnimated:(BOOL)animated;

+ (void)showWithAnimated:(BOOL)animated;

+ (void)hideWithAnimated:(BOOL)animated;

@end
