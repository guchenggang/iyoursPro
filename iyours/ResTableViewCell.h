//
//  WSTableViewCell.h
//  MyTableVIew
//
//  Created by 王嵩 on 14/11/28.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceCategory.h"

@interface ResTableViewCell : UITableViewCell


@property (strong , nonatomic) ResourceCategory *item;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *resName;
@property (strong, nonatomic) IBOutlet UILabel *desc;
@property (strong, nonatomic) IBOutlet UIImageView *type;
@property (strong, nonatomic) IBOutlet UILabel *className;
@property (strong, nonatomic) IBOutlet UILabel *term;

- (IBAction)commBtnClick:(id)sender;
- (IBAction)downloadBtnClick:(id)sender;
- (IBAction)zhankaiBtnClick:(id)sender;
- (IBAction)shareBtnClick:(id)sender;

@end
