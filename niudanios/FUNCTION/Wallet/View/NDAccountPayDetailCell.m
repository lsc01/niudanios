//
//  NDAccountPayDetailCell.m
//  niudanios
//
//  Created by lsc on 2018/9/3.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDAccountPayDetailCell.h"

@implementation NDAccountPayDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NDMyWalletRecordModel *)model{
    _model = model;
    self.accountPayDetailType = [model.status integerValue]+1;
    
    if ([model.status integerValue] == 0) {
        self.labelDes.text = @"充值";
        
    }else if ([model.status integerValue] == 1){
        self.labelDes.text = @"任务奖励";
        
    }else if ([model.status integerValue] == 2){
        self.labelDes.text = @"扭蛋";
        
    }else if ([model.status integerValue] == 3){
        self.labelDes.text = @"订单";
        
    }
    self.labelAdd.text = model.version;
    self.labelDay.text = model.createTime;
    self.labelResidue.text = [NSString stringWithFormat:@"%@",model.balance];
}

-(void)setAccountPayDetailType:(AccountPayDetailType)accountPayDetailType{
    _accountPayDetailType = accountPayDetailType;
    switch (accountPayDetailType) {
        case AccountPayDetailType1:
        case AccountPayDetailType3:
        {
            self.labelDes.textColor = HEXCOLOR(0x1dcb7c);
            self.labelAdd.textColor = HEXCOLOR(0x1dcb7c);
            
        }
            break;
        case AccountPayDetailType2:
        case AccountPayDetailType4:
        {
            self.labelDes.textColor = HEXCOLOR(0xfc6d35);
            self.labelAdd.textColor = HEXCOLOR(0xfc6d35);
        }
            break;
            
        default:
            break;
    }
}

@end
