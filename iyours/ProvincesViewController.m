//
//  ProvincesViewController.m
//  PhoneVerifyDemo
//
//  Created by bob on 14-12-9.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "ProvincesViewController.h"
#import "RegionInfo.h"
#import "Provinces.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"
@interface ProvincesViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //查询的数据
    NSMutableArray *data;
    __weak IBOutlet UITableView *InfoTableView;

}
@end

@implementation ProvincesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建数组
    data = [NSMutableArray array];
    InfoTableView.dataSource = self;
    InfoTableView.delegate = self;
    switch (_flag) {
        case 1:
            NSLog(@"显示省信息");
            [self getProvincesData];
            
            
            break;
            
        case 2:
            NSLog(@"显示市信息");
            [self getCityData:@"2"];
            
            break;
        case 3:
            NSLog(@"显示区县信息");
            [self getCityData:@"3"];
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getProvincesData{
    NSString *doc = [[NSBundle mainBundle]pathForResource:@"iyours_cache" ofType:@"db"];
    
    FMDatabase* database=[FMDatabase databaseWithPath:doc];
    if (![database open]) {
        return;
    }
    //sql
    NSString *sql = @"select* from region where regtype=1";
    FMResultSet *resultSet = [database executeQuery:sql];
    while ([resultSet next]) {
        RegionInfo *item = [RegionInfo new];
        item.keyId = [resultSet intForColumn:@"id"];
        item.regid = [resultSet stringForColumn:@"regid"];
        item.regname =[resultSet stringForColumn:@"regname"];
        item.parent = [resultSet stringForColumn:@"parent"];
        item.regtype = [resultSet intForColumn:@"regtype"];
        [data addObject:item];
//        NSLog(@"keyid=%d  regid=%@  regname=%@  parent=%@  regtype=%d",item.keyId,item.regid,item.regname,item.parent,item.regtype);
    }

}
-(void)getCityData:(NSString *)regtype{

    NSString *doc = [[NSBundle mainBundle]pathForResource:@"iyours_cache" ofType:@"db"];
    
    FMDatabase* database=[FMDatabase databaseWithPath:doc];
    if (![database open]) {
        return;
    }
    //sql
    NSString *sql = [NSString stringWithFormat:@"select* from region where regtype=%@ and parent=%@",regtype,_parentId];
    NSLog(@"%@",sql);
    FMResultSet *resultSet = [database executeQuery:sql];
    while ([resultSet next]) {
        RegionInfo *item = [RegionInfo new];
        item.keyId = [resultSet intForColumn:@"id"];
        item.regid = [resultSet stringForColumn:@"regid"];
        item.regname =[resultSet stringForColumn:@"regname"];
        item.parent = [resultSet stringForColumn:@"parent"];
        item.regtype = [resultSet intForColumn:@"regtype"];
        [data addObject:item];
//        NSLog(@"keyid=%d  regid=%@  regname=%@  parent=%@  regtype=%d",item.keyId,item.regid,item.regname,item.parent,item.regtype);
    }
}
//查询市  县  第一条记录
-(RegionInfo *)getCityDataOneBean:(NSString *)regtype ParentId:(NSString *)parentId{
    NSString *doc = [[NSBundle mainBundle]pathForResource:@"iyours_cache" ofType:@"db"];
    
    FMDatabase* database=[FMDatabase databaseWithPath:doc];
    if (![database open]) {
        return nil;
    }
    //sql
    NSString *sql = [NSString stringWithFormat:@"select* from region where regtype=%@ and parent=%@",regtype,parentId];
    NSLog(@"%@",sql);
    FMResultSet *resultSet = [database executeQuery:sql];
    RegionInfo *item = [RegionInfo new];
    while ([resultSet next]) {
 
        item.keyId = [resultSet intForColumn:@"id"];
        item.regid = [resultSet stringForColumn:@"regid"];
        item.regname =[resultSet stringForColumn:@"regname"];
        item.parent = [resultSet stringForColumn:@"parent"];
        item.regtype = [resultSet intForColumn:@"regtype"];
        [data addObject:item];
                NSLog(@"keyid=%d  regid=%@  regname=%@  parent=%@  regtype=%d",item.keyId,item.regid,item.regname,item.parent,item.regtype);
        break;
    }
     return item;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"count = %d",data.count);
    return data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    NSLog(@"cell ==  %@",[data[indexPath.row] regname]);
    cell.textLabel.text = [data[indexPath.row] regname];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *text = [data[indexPath.row] regname];
     Provinces *provinces = [Provinces new];
    if (_flag == 1) {
        provinces.shengId = [data[indexPath.row] regid];
        provinces.sheng = [data[indexPath.row] regname];
        //查市
        RegionInfo *city = [self getCityDataOneBean:@"2" ParentId:provinces.shengId];
        provinces.cityId =city.regid;
        provinces.city = city.regname;
        
        
        //查区县
        RegionInfo *county =[self getCityDataOneBean:@"3" ParentId:provinces.cityId];
        provinces.countyId =county.regid;
        provinces.county =county.regname;
        
    }else if (_flag == 2){
        provinces.cityId=[data[indexPath.row] regid];
        provinces.city=[data[indexPath.row] regname];
        
        //查县
        RegionInfo *county =[self getCityDataOneBean:@"3" ParentId:provinces.cityId];
        provinces.countyId =county.regid;
        provinces.county =county.regname;
        
    }else{
        provinces.countyId =[data[indexPath.row] regid];
        provinces.county=[data[indexPath.row] regname];
    }
    [_delegate setProvinces:provinces Flag:_flag];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"regname = %@",text);
}
- (IBAction)back {
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
