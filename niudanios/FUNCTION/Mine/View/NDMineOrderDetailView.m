//
//  NDMineOrderDetailView.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineOrderDetailView.h"

@implementation NDMineOrderDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)OrderDetailClick:(UIButton *)sender {
    _lookOrderLogisticsDetailBlock?_lookOrderLogisticsDetailBlock():nil;
}


-(void)setModel:(NDOrderDetailInfoModel *)model{
    _model= model;
    if ([model.status isEqualToString:@"DF"]) {
        self.labelOrderState.text = @"待发货";
    }else if ([model.status isEqualToString:@"DS"]) {
        self.labelOrderState.text = @"待收货";
    }else if ([model.status isEqualToString:@"YS"]) {
        self.labelOrderState.text = @"已收货";
    }
    if (model.logisticsDataArray.count>0) {
        NDLogisticsInfoModel * logiModel = model.logisticsDataArray.lastObject;
        self.labelogInfo.text = logiModel.context;
    }
    
    self.labelTime.text = model.createTime;
    self.labelName.text = model.name;
    self.labelPhone.text = model.phone;
    self.labelAddr.text = model.addressData;
    
}

@end
