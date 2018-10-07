//
//  NDAboutTableViewCell.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDAboutTableViewCell.h"

@implementation NDAboutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(NDAboutInfoModel *)model{
    _model = model;
    self.labeltitle.text = model.title;
    self.labelDes.text = model.context;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
