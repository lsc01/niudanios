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

-(void)setModel:(NDPackageGoodsModel *)model{
    _model = model;
    [self.imageViewGoods sd_setImageWithURL:[NSURL URLWithString:model.gashaponImg] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"error:%@",error);
    }];
    self.labelName.text = model.gashaponName;
    long long interval = [model.createMaturity longLongValue]/1000 - [model.currentTime longLongValue];
    NSInteger day = interval/(24*60*60);
    NSInteger hour = interval%(24*60*60)/(60*60);
    NSInteger min = interval%(24*60*60)%(60*60)/60;
    self.labelTime.text = [NSString stringWithFormat:@"%d天%d时%d分",day,hour,min];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    _SelectGoodsBlock?_SelectGoodsBlock(sender.selected,self.model):nil;
}
@end
