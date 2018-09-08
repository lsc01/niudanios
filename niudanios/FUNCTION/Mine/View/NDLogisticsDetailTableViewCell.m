//
//  NDLogisticsDetailTableViewCell.m
//  niudanios
//
//  Created by lsc on 2018/9/8.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDLogisticsDetailTableViewCell.h"

@implementation NDLogisticsDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.viewLineCenter.layer.cornerRadius = 4;
    self.viewLineCenter.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
