//
//  NDMineDownTableViewCell.m
//  niudanios
//
//  Created by lsc on 2018/9/4.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineDownTableViewCell.h"

@implementation NDMineDownTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setUI];
}

-(void)setModel:(NDMineDownInfoModel *)model{
    _model = model;
    [self.imageviewHead sd_setImageWithURL:[NSURL URLWithString:HTTP(model.headPortrait)] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"error:%@",error);
    }];
    self.labelDate.text = model.createTime;
    self.userName.text = model.nickName;
    self.labelCount.text = [NSString stringWithFormat:@"%@",model.count];
}

-(void)setUI{
    self.imageviewHead.layer.cornerRadius = 22;
    self.imageviewHead.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
