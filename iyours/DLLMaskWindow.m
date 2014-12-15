//
//  ModalWindow.m
//  PigPigLeague
//
//  Created by DLL on 14-6-25.
//  Copyright (c) 2014年 monster. All rights reserved.
//

#import "DLLMaskWindow.h"


@implementation DLLMaskWindow
#define ANIMATION_DURATION 0.25
#define ACTION_SHEET_BOTTOM_MARGIN 0

static DLLMaskWindow *__mainWindow;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelStatusBar + 10.0f;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (id)init
{
    self = [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self) {

    }
    return self;
}

+ (instancetype)defaultWindow
{
    if (__mainWindow == nil) {
        __mainWindow = [[self alloc] init];
    }
    return __mainWindow;
}

+ (instancetype)defaultWindowAsBottom
{
    if (__mainWindow == nil) {
        __mainWindow = [[self alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*1.6)];
    }
    return __mainWindow;
}


- (void)showWindow
{
    [self makeKeyAndVisible];
    
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
}

- (void)showModalView:(UIView *)view animated:(BOOL)animated finish:(void (^)(void))finish onTouchBegan:(void (^)(void))onTouchBegan
{
    if (_isShowModalView) {
        return;
    }
    _isShowModalView = YES;
    [_showFinish release];
    _showFinish = [finish copy];
    self.userInteractionEnabled = YES;
    view.center = self.center;
    _modalView = view;
    [self addSubview:_modalView];
    [self makeKeyAndVisible];
    _onTouchBegan = [onTouchBegan copy];
    
    if (animated) {
        _modalView.alpha = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(showModalViewFinish)];
        _modalView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _modalView.transform = CGAffineTransformMakeScale(1, 1);
        _modalView.alpha = 1;
        
        [UIView commitAnimations];
    } else {
        [self showModalViewFinish];
    }
}

- (void)hideModalViewAnimated:(BOOL)animated finish:(void (^)(void))finish
{
    if (!_isShowModalView) {
        return;
    }
    [_onTouchBegan release];
    _onTouchBegan = nil;
    [_hideFinish release];
    _hideFinish = [finish copy];
    _modalView.transform = CGAffineTransformMakeScale(1, 1);
    if (animated) {
        _modalView.alpha = 1;
        [UIView setAnimationBeginsFromCurrentState:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(hideModalViewFinish)];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        _modalView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        _modalView.alpha = 0;
        [UIView commitAnimations];
    } else {
        _modalView.alpha = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [self hideModalViewFinish];
    }
    
}

- (void)showModalViewFinish
{
    _modalView.alpha = 1;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    if (_showFinish) {
        _showFinish();
        [_showFinish release];
        _showFinish = nil;
    }
}

- (void)hideModalViewFinish
{
    self.userInteractionEnabled = NO;
    [_modalView removeFromSuperview];
    _modalView = nil;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
    _isShowModalView = NO;
    if (_hideFinish) {
        _hideFinish();
        [_hideFinish release];
        _hideFinish = nil;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (_onTouchBegan != nil) {
        _onTouchBegan();
    }
}



@end
