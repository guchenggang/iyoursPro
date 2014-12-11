//
//  HomeViewController.m
//  iyours
//
//  Created by 王嵩 on 14/12/10.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import "HomeViewController.h"
#import "ASIFormDataRequest.h"
#import "NSString+Addtion.h"
#import "UIImageView+WebCache.h"
#import "UIColor+StringColor.h"
#import "Cell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    
    [_courseBtn.layer setMasksToBounds:YES];
    [_courseBtn.layer setCornerRadius:8.0]; //设置矩圆角半径
    [_courseBtn.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    [_courseBtn.layer setBorderColor:colorref];//边框颜色
    
    [_courseBtn addTarget:self action:@selector(courseChose) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_speedBtn.layer setCornerRadius:8.0];
    
    [_recordBtn.layer setCornerRadius:8.0];

    
    [_searchBtn.layer setCornerRadius:15];
    [self.searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
    //图片的宽
    CGFloat imageW = self.scrollview.frame.size.width;
    
    //图片高
    CGFloat imageH = self.scrollview.frame.size.height;
    
    //图片的Y
    CGFloat imageY = 0;

    
    NSArray *array = [NSArray arrayWithObjects:@"http://www.yejs.com.cn/admin/_ROOT/zhuantinew/background_pic/57/header.jpg",
                      @"http://www.iyours.com.cn/staticback/images/shop/1.jpg"
                      ,@"http://www.iyours.com.cn/staticback/images/shop/2.jpg"
                      ,@"http://www.iyours.com.cn/staticback/images/shop/3.jpg"
                      ,@"http://www.iyours.com.cn/staticback/images/shop/4.jpg", nil];
    
    //图片数
    NSInteger totalCount = array.count;
    
    for (int i = 0;  i < totalCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //图片X
        CGFloat imageX = i * imageW;
        
        //设置frame
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        
        //设置图片
        [imageView sd_setImageWithURL:array[i]];
        
        
        //隐藏指示条
        self.scrollview.showsHorizontalScrollIndicator = NO;
        [self.scrollview addSubview:imageView];
    }
    
    //设置scrollview的滚动范围
    CGFloat contentW = totalCount *imageW;
    
    //不允许在垂直方向上进行滚动
    self.scrollview.contentSize = CGSizeMake(contentW, 0);
    
    //设置分页
    self.scrollview.pagingEnabled = YES;
    
    self.pageControl.numberOfPages = totalCount;
    
    self.pageControl.currentPage = 0;
    
    //监听scrollview的滚动
    self.scrollview.delegate = self;
    
    [self addTimer];
    
    
}

-(void)courseChose
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"课程选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"东方之星思维课程" otherButtonTitles:@"全景数学", nil];
    [action showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [_courseBtn setTitle:@"思维课程" forState:UIControlStateNormal];
    }else{
        [_courseBtn setTitle:@"全景数学" forState:UIControlStateNormal];
    }
}


-(void)search
{
    NSLog(@"跳转到搜索");
}

#pragma mark 滚动的时候调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.pageControl.currentPage = page;
}

#pragma mark 开始拖拽的时候调用
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    //关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
    //[self.timer invalidate];
    [self removeTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //开启定时器
    [self addTimer];
}

#pragma mark 图片切换
- (void)nextImage
{
    int page = (int)self.pageControl.currentPage;
    if (page == 4) {
        page = 0;
    }else{
        page++;
    }

    //  滚动scrollview
    CGFloat x = page * self.scrollview.frame.size.width;
    self.scrollview.contentOffset = CGPointMake(x, 0);
}


#pragma mark 开启定时器
 - (void)addTimer
{
     self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
     [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


#pragma mark 关闭定时器
- (void)removeTimer
{
    [self.timer invalidate];
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


- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    
    // 获取文本数据时使用
    NSString *responseString = [request responseString];
    
    
    NSMutableDictionary *dict = [responseString JSONValue];
    NSNumber *state = [dict objectForKey:@"state"];
    
    NSArray *array = [dict allValues];
    NSLog(@"responseString = %@" , responseString);
    NSLog(@"dict = %@" , dict);
    NSLog(@"state = %@" , state);
    NSLog(@"array = %@" , array);
    
    
    // 在抓取时使用二进制数据
    //    NSData *responseData = [request responseData];
    //    NSLog(@"responseData = %@" , responseData);
    
}
- (IBAction)settingBtnClick:(UIButton *)sender {
    
    NSLog(@"跳转设置界面");
}

- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{

    return 120;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
    return 90;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
    return 3;
}


- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid

{
    return 7;
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
    Cell *cell = (Cell *)[grid dequeueReusableCell];
    
    if (cell == nil) {
        cell = [[Cell alloc] init];
    }
    
    cell.label.text = [NSString stringWithFormat:@"(%d,%d)", rowIndex, columnIndex];
    
    return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    NSLog(@"%d, %d clicked", rowIndex, colIndex);
}

@end
