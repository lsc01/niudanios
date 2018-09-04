//
//  NDPackageTableViewCell.m
//  niudanios
//
//  Created by lsc on 2018/9/4.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDPackageTableViewCell.h"

@implementation NDPackageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageViewGoods.layer.cornerRadius = 4;
    self.imageViewGoods.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}
@end
