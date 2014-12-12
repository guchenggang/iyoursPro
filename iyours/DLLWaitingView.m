//
//  WaitingView.m
//  TestProject
//
//  Created by DLL on 14-6-9.
//  Copyright (c) 2014年 DLL. All rights reserved.
//

#import "DLLWaitingView.h"
#import "DLLMaskWindow.h"


@implementation DLLWaitingView


static DLLWaitingView *__waitingView;




+ (instancetype)sharedView
{
    if (__waitingView == nil) {
        __waitingView = [[self alloc] init];
    }
    return __waitingView;
}

- (id)init
{
    self = [self initWithFrame:CGRectMake(0, 0, 180, 65)];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.layer.cornerRadius = 5;
        self.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(-5, 5);
        self.layer.shadowOpacity = 0.5f;
        UIViewAutoresizing mask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.autoresizingMask = mask;
        
        _isShown = NO;
        
        _indicatorView = [[CustomProgress alloc] initWithImage:[UIImage imageNamed:@"progress_loading.png"]];
        [self addSubview:_indicatorView];
        [_indicatorView setInCenterVertical];
        [_indicatorView setToLeft:30];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(65, 25, 100, 15)];
        _label.text = @"正在加载...";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.autoresizingMask = mask;
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:14];
        [self addSubview:_label];
        
        UILabel *lblLoading = [[UILabel alloc] init];
        lblLoading.backgroundColor = [UIColor clearColor];
        lblLoading.textColor = [UIColor colorWithDecimalismRed:76 green:135 blue:187 alpha:1];
        lblLoading.font = [UIFont systemFontOfSize:5];
        lblLoading.text = @"LOADING";
        [lblLoading resizeWithMaxWidth:300];
        [self addSubview:lblLoading];
        lblLoading.center = _indicatorView.center;
    }
    return self;
}

+ (void)showWithAnimated:(BOOL)animated
{
    [[DLLWaitingView sharedView] showWithAnimated:animated];
}

+ (void)hideWithAnimated:(BOOL)animated
{
    [[DLLWaitingView sharedView] hideWithAnimated:animated];
}

- (void)showWithAnimated:(BOOL)animated
{
    if (_isShown) {
        return;
    }
    _isShown = YES;
    [[DLLMaskWindow defaultWindow] showModalView:self animated:animated finish:nil onTouchBegan:nil];
    [_indicatorView startAnimating];
}

- (void)hideWithAnimated:(BOOL)animated
{
    if (!_isShown) {
        return;
    }
    
    [[DLLMaskWindow defaultWindow] hideModalViewAnimated:animated finish:^{
        [_indicatorView stopAnimating];
        _isShown = NO;
    }];
}


- (void)dealloc
{
    [_indicatorView release];
    [_label release];
    [super dealloc];
}


@end
