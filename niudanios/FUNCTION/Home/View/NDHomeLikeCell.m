//
//  NDHomeLikeCell.m
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDHomeLikeCell.h"

@implementation NDHomeLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setUI];
}

-(void)setUI{
    self.cellViewBg.layer.cornerRadius = 4;
    self.cellViewBg.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
