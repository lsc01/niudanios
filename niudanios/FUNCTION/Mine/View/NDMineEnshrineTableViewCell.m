//
//  NDMineEnshrineTableViewCell.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineEnshrineTableViewCell.h"

@implementation NDMineEnshrineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageViewGoods.layer.cornerRadius = 4;
    self.imageViewGoods.clipsToBounds = YES;
}
- (IBAction)deleteBtnClick:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
