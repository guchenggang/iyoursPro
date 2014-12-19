//
//  WSTableViewController.h
//  MyTableVIew
//
//  Created by 王嵩 on 14/11/28.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceCategory.h"
#import "NIDropDown.h"
#import "PWLoadMoreTableFooterView.h"

@interface ResTableViewController : UIViewController<UITableViewDataSource , UITableViewDelegate , NIDropDownDelegate, PWLoadMoreTableFooterDelegate>{
    NIDropDown *dropDown;
    PWLoadMoreTableFooterView *_loadMoreFooterView;
    BOOL _datasourceIsLoading;
    bool _allLoaded;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong , nonatomic) ResourceCategory *item;

@property (strong, nonatomic) IBOutlet UIButton *classBtn;

- (IBAction)click:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *termBtn;
@property (strong, nonatomic) IBOutlet UIButton *queryBtn;

@property (strong , nonatomic) NSMutableArray *array;



@end
