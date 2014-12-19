//
//  WSTableViewController.m
//  MyTableVIew
//
//  Created by 王嵩 on 14/11/28.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "ResTableViewController.h"
#import "ResTableViewCell.h"
#import "UIColor+StringColor.h"

//手机屏幕的宽
#define  SCREENWIDTH [[UIScreen mainScreen] bounds].size.width

//手机屏幕的高
#define  SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ResTableViewController ()

@end

@implementation ResTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载item的xib到内存
    UINib *nib = [UINib nibWithNibName:@"ResTableViewCell" bundle:nil];
    
    //注册xib到表视图
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    UIImage* img=[UIImage imageNamed:@"back.png"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame =CGRectMake(0, 0, 32, 32);
    
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(back) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem = item;
    
    CGFloat width = SCREENWIDTH - btn.frame.size.width *2;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    label.text = self.item.rescateName;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [_classBtn.layer setCornerRadius:3];
    [_termBtn.layer setCornerRadius:3];
    [_queryBtn.layer setCornerRadius:3];
    
    if (_loadMoreFooterView == nil) {
        
        PWLoadMoreTableFooterView *view = [[PWLoadMoreTableFooterView alloc] init];
        view.delegate = self;
        _loadMoreFooterView = view;
        
    }
    self.tableView.tableFooterView = _loadMoreFooterView;
    
    
    
    
    
}


-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

}



- (IBAction)click:(id)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"全部", @"托班", @"小班", @"中班", @"大班", @"学前班",nil];
    if(dropDown == nil) {
        dropDown.userInteractionEnabled = YES;
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        dropDown = nil;
    }
}
@end
