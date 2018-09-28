//
//  NDTaskBonusTableViewCell.m
//  niudanios
//
//  Created by lsc on 2018/9/4.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDTaskBonusTableViewCell.h"
#import "UIButton+BackgroundColor.h"
@implementation NDTaskBonusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    
    [self setUI];
    
}

-(void)setModel:(NDTaskBonusModel *)model{
    _model = model;
    self.labelTitle.text = [NSString stringWithFormat:@"下线累计完成%@次扭蛋",model.number];
    self.labelNum.text = [NSString stringWithFormat:@"%@",model.money];
//    0未完成，1未领取，2已完成
    if ([model.status integerValue] == 0) {
        
    }else if ([model.status integerValue] == 1){
        
    }else if ([model.status integerValue] == 2){
        
    }
    
    
}
-(void)setUI{
    
    self.labelNum.adjustsFontSizeToFitWidth = YES;
    
    if (kScreenWidth<370) {
        self.constraintLabel1.constant = 40;
        self.constraint2.constant = 8;
        self.constraintBtnRight.constant = 12;
        self.ConstraintBgLeft.constant = KScale_C*20;
        self.ConstraintBgRight.constant = KScale_C*20;
    }
    
    self.viewBg.layer.cornerRadius = 12;
    self.viewBg.layer.masksToBounds = YES;
    self.imageViewBg.layer.cornerRadius = 12;
    self.imageViewBg.layer.masksToBounds = YES;
    
    self.btnGet.layer.cornerRadius = 20;
    self.btnGet.layer.masksToBounds = YES;
    [self.btnGet setBackgroundColor:HEXCOLOR(0xcccccc) forState:UIControlStateDisabled];
    [self.btnGet setBackgroundColor:HEXCOLOR(0x1dcb77) forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)getBtnClick:(UIButton *)sender {
    _getTaskBonusBlock?_getTaskBonusBlock(self.model):nil;
}
@end
