//
//  MainTabBarController.m
//  iyours
//
//  Created by 王嵩 on 14/12/10.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import "MainTabBarController.h"
#import "UIColor+StringColor.h"
#import "HomeViewController.h"
#import "DownLoadViewController.h"
#import "PlayViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置底部bar的背景颜色
    UIColor *strColor = [UIColor colorWithHexString:@"#565656"];
    self.tabBar.barTintColor = strColor;

    //设置默认字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    //设置选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    
    //第一个界面
    HomeViewController *home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    //设置默认图片
    UIImage *image1 = [[UIImage imageNamed:@"home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置选中图片
    UIImage *selectedImage1 = [[UIImage imageNamed:@"home_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置标题和图片
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"首页" image:image1 selectedImage:selectedImage1];
    //设置该属性可以在其右上角显示一个小的角标
    //item1.badgeValue = @"2";
    //设置第一个界面的tabBarItem
    home.tabBarItem = item1;
    
    //第二个界面
    DownLoadViewController *download = [[DownLoadViewController alloc] initWithNibName:@"DownLoadViewController" bundle:nil];
    UIImage *image2 = [[UIImage imageNamed:@"download_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage2 = [[UIImage imageNamed:@"download_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"下载" image:image2 selectedImage:selectedImage2];
    download.tabBarItem = item2;
    
    //第三个界面
    PlayViewController *play = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
    UIImage *image3 = [[UIImage imageNamed:@"play_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage3 = [[UIImage imageNamed:@"play_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"播放" image:image3 selectedImage:selectedImage3];
    play.tabBarItem = item3;
    
    //设置标签栏显示的界面数组
    NSArray *array = [NSArray arrayWithObjects:home , download , play, nil];
    [self setViewControllers:array animated:YES];
    self.delegate = self;
    
    //当前显示的viewController
    self.selectedIndex = 0;


    
}

#pragma mark 点击tab回调
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
