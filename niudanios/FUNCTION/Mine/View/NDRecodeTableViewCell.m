//
//  NDRecodeTableViewCell.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDRecodeTableViewCell.h"
#import "NSDate+Formatter.h"
@implementation NDRecodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageViewGoods.layer.cornerRadius = 4;
    self.imageViewGoods.clipsToBounds = YES;
}

-(void)setModel:(NDNuidanRecordModel *)model{
    _model = model;
    
    [self.imageViewGoods sd_setImageWithURL:[NSURL URLWithString:ImageUrl(model.gashaponImg)] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"error:%@",error);
    }];
    
    self.labelName.text = model.gashaponName;
    self.labelTime.text = model.timeFormat;
    self.labelPrice.text = [NSString stringWithFormat:@"%@",model.machinePrice];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
