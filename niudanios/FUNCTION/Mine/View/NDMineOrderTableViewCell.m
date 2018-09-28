//
//  NDMineOrderTableViewCell.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineOrderTableViewCell.h"

@implementation NDMineOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.btnOrder.layer.cornerRadius = 14;
    self.btnOrder.clipsToBounds = YES;
    self.btnOrder.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
    self.btnOrder.layer.borderWidth = 1;
    
    
    self.imageViewGoods.layer.cornerRadius = 4;
    self.imageViewGoods.clipsToBounds = YES;
    
}


-(void)setModel:(NDMineOrderInfoModel *)model{
    _model = model;
    [self.imageViewGoods sd_setImageWithURL:[NSURL URLWithString:HTTP(model.gashaponImg)] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"error:%@",error);
    }];
    self.labelOrderId.text= model.orderId;
    self.labelGoodsName.text = model.gashaponName;
    self.labelTime.text = model.createTime;
    
    if ([model.status isEqualToString:@"DF"]) {
        self.orderState = OrderState_1;
    }else if ([model.status isEqualToString:@"DS"]){
        self.orderState = OrderState_2;
    }else if ([model.status isEqualToString:@"YS"]){
        self.orderState = OrderState_3;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOrderState:(OrderState)orderState{
    _orderState = orderState;
    switch (orderState) {
        case OrderState_1:
        {
            self.labelOrderState.text = @"待发货";
            self.labelOrderState.textColor = HEXCOLOR(0x1dcb7c);
            [self.btnOrder setTitle:@"提醒发货" forState:UIControlStateNormal];
            self.constraintOrderBtn.constant = 80;
        }
            break;
        case OrderState_2:
        {
            self.labelOrderState.text = @"已发货";
            self.labelOrderState.textColor = HEXCOLOR(0x1dcb7c);
            [self.btnOrder setTitle:@"查看订单状态" forState:UIControlStateNormal];
            self.constraintOrderBtn.constant = 110;
        }
            break;
        case OrderState_3:
        {
            self.labelOrderState.text = @"已收货";
            self.labelOrderState.textColor = HEXCOLOR(0x999999);
            [self.btnOrder setTitle:@"删除订单" forState:UIControlStateNormal];
            self.constraintOrderBtn.constant = 80;
            
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)rightBtnClick:(UIButton *)sender {
}
@end
