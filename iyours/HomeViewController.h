//
//  HomeViewController.h
//  iyours
//
//  Created by 王嵩 on 14/12/10.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"
#import "UIGridViewDelegate.h"

@interface HomeViewController : UIViewController<UIScrollViewDelegate , UIActionSheetDelegate , UIGridViewDelegate>


@property (strong, nonatomic) IBOutlet UIButton *courseBtn;
- (IBAction)settingBtnClick:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, nonatomic) IBOutlet UIGridView *table;
@property (strong, nonatomic) IBOutlet UIButton *recordBtn;

@property (strong, nonatomic) IBOutlet UIButton *speedBtn;
@end
