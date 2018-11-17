//
//  NDHomeGoodsCollectionViewCell.m
//  niudanios
//
//  Created by lsc on 2018/8/28.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDHomeGoodsCollectionViewCell.h"

@implementation NDHomeGoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(NDGoodsInfoModel *)model{
    _model = model;
    
    [self.imageViewGoods sd_setImageWithURL:[NSURL URLWithString:ImageUrl(model.machineImg?:@"")] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"error:%@",error);
    }];
    self.labelNum.text = [NSString stringWithFormat:@"%d",model.machinePrice];
    self.labelName.text = model.machineName;
    self.labelOther.text = model.classifyName;
}
    
@end
