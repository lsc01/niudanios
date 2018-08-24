//
//  NDMineFunctionCell.m
//  niudanios
//
//  Created by lsc on 2018/8/24.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineFunctionCell.h"

@implementation NDMineFunctionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)functionBtnClick:(UIButton *)sender {
    _functionSelectedBlock?_functionSelectedBlock(sender.tag-10000):nil;
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
