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
    _deleteEnshrinGoodsBlock?_deleteEnshrinGoodsBlock(self.model.Id):nil;
}

-(void)setModel:(NDMineEnshrineInfoModel *)model{
    _model = model;
 
    [self.imageViewGoods sd_setImageWithURL:[NSURL URLWithString:ImageUrl(model.machineImg)] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"error:%@",error);
    }];

    self.labelName.text = model.machineName;
    self.labelPrice.text = [NSString stringWithFormat:@"%@",model.machinePrice];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
