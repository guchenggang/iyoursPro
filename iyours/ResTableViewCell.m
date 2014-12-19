//
//  WSTableViewCell.m
//  MyTableVIew
//
//  Created by 王嵩 on 14/11/28.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "ResTableViewCell.h"
#define  SCREENWIDTH [[UIScreen mainScreen] bounds].size.width

@implementation ResTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    frame.size.width = SCREENWIDTH - 20;
    frame.origin.x = 10;
    self.frame = frame;
    frame.origin.x = 0;
    frame.origin.y = 7;
    frame.size.height = 140;
    self.backgroundView.frame = frame;
    self.selectedBackgroundView.frame = frame;
    self.contentView.frame = frame;

}

- (IBAction)commBtnClick:(id)sender {
    
}

- (IBAction)downloadBtnClick:(id)sender {
}

- (IBAction)zhankaiBtnClick:(id)sender {
}

- (IBAction)shareBtnClick:(id)sender {
}
@end
