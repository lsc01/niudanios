//
//  NDNiudanGoodsCell.m
//  niudanios
//
//  Created by lsc on 2018/8/30.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDNiudanGoodsCell.h"
#import <UIImageView+WebCache.h>
@implementation NDNiudanGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(NDGoodsInfoModel *)model{
    _model = model;
    
    [self.imageViewGoods sd_setImageWithURL:[NSURL URLWithString:ImageUrl(model.machineImg)] placeholderImage:[UIImage imageNamed:@"placehold_xx"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"error:%@",error);
    }];
    self.labelGoodsName.text = model.machineName;
    self.labelPrice.text = [NSString stringWithFormat:@"%d",model.machinePrice];
    self.labelGoodsNum.text =[NSString stringWithFormat:@"%d",model.salesVolume];
    self.btnCollect.selected = model.status == 1;
}

- (IBAction)collectBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    _collectGoodsBlock?_collectGoodsBlock(self.model.Id,sender.selected):nil;
    
}
@end
