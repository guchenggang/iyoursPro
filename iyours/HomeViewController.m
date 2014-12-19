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
#import "DLLWaitingView.h"
#import "MBProgressHUD+Toast.h"
#import "ResourceCategory.h"
#import "ResTableViewController.h"

//手机屏幕的宽
#define  SCREENWIDTH [[UIScreen mainScreen] bounds].size.width

//手机屏幕的高
#define  SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ResourceCategory *res1 = [[ResourceCategory alloc] init];
    res1.rescateId = @"549";
    res1.rescateName = @"二级培训";
    res1.resId = @"8001";
    res1.logoUrl = @"http://www.iyours.com.cn/staticback/resource/c_267.png";
    
    ResourceCategory *res2 = [[ResourceCategory alloc] init];
    res2.rescateId = @"114";
    res2.rescateName = @"游戏分析";
    res2.resId = @"8001";
    res2.logoUrl = @"http://www.iyours.com.cn/staticback/resource/c_105.png";
    
    ResourceCategory *res3 = [[ResourceCategory alloc] init];
    res3.rescateId = @"417";
    res3.rescateName = @"游戏教案";
    res3.resId = @"8001";
    res3.logoUrl = @"http://www.iyours.com.cn/staticback/resource/c_104.png";
    
    ResourceCategory *res4 = [[ResourceCategory alloc] init];
    res4.rescateId = @"112";
    res4.rescateName = @"游戏课件";
    res4.resId = @"8001";
    res4.logoUrl = @"http://www.iyours.com.cn/staticback/resource/c_103.png";
    
    ResourceCategory *res5 = [[ResourceCategory alloc] init];
    res5.rescateId = @"267";
    res5.rescateName = @"游戏资源";
    res5.resId = @"8001";
    res5.logoUrl = @"http://www.iyours.com.cn/staticback/resource/c_267.png";
    
    ResourceCategory *res6 = [[ResourceCategory alloc] init];
    res6.rescateId = @"514";
    res6.rescateName = @"课程实录";
    res6.resId = @"8001";
    res6.logoUrl = @"http://www.iyours.com.cn/staticback/resource/c_215.png";
    
    ResourceCategory *res7 = [[ResourceCategory alloc] init];
    res7.rescateId = @"0";
    res7.rescateName = @"公共资源";
    res7.resId = @"8001";
    res7.logoUrl = @"http://www.iyours.com.cn/staticback/resource/c_370.png";
    
    

    
    
    self.array = [NSMutableArray arrayWithObjects:res1 ,res2 ,res3 ,res4 ,res5 ,res6 ,res7 ,  nil];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    
    [_courseBtn.layer setMasksToBounds:YES];
    [_courseBtn.layer setCornerRadius:8.0]; //设置矩圆角半径
    [_courseBtn.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    [_courseBtn.layer setBorderColor:colorref];//边框颜色
    
    [_courseBtn addTarget:self action:@selector(courseChose) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_speedBtn.layer setCornerRadius:8.0];
    [_speedBtn addTarget:self action:@selector(speed) forControlEvents:UIControlEventTouchUpInside];
    
    [_recordBtn.layer setCornerRadius:8.0];
    [_recordBtn addTarget:self action:@selector(record) forControlEvents:UIControlEventTouchUpInside];
    
    [_searchBtn.layer setCornerRadius:15];
    [self.searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
    //图片的宽
    CGFloat imageW = SCREENWIDTH;
    
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
        self.scrollview.showsHorizontalScrollIndicator = YES;
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
    
    [self.view addSubview:self.pageControl];
    
    
    //监听scrollview的滚动
    self.scrollview.delegate = self;
    
    [self addTimer];
    
    
}

-(void)speed
{
    NSLog(@"speed");
    [DLLWaitingView showWithAnimated:YES];
}

-(void)record
{
    
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

    return [UIScreen mainScreen].bounds.size.width / 4.3;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
    return [UIScreen mainScreen].bounds.size.height / 7;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
    return 4;
}


- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid

{
    return self.array.count;
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
    Cell *cell = (Cell *)[grid dequeueReusableCell];
    
    if (cell == nil) {
        cell = [[Cell alloc] init];
    }

    ResourceCategory *rc =  self.array[rowIndex * 4 + columnIndex];
    cell.label.text = rc.rescateName;
    UIImageView *image = cell.thumbnail;
    [image sd_setImageWithURL:rc.logoUrl];
    
    return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    NSLog(@"%d, %d clicked", rowIndex, colIndex);
    NSLog(@"%@" , self.array[rowIndex * 4 + colIndex]);
    
    ResTableViewController *resTabView = [[ResTableViewController alloc] initWithNibName:@"ResTableViewController" bundle:nil];
    resTabView.item = self.array[rowIndex * 4 + colIndex];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:resTabView];
    [nav setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:nav animated:YES completion:nil];
    
    
}

@end
