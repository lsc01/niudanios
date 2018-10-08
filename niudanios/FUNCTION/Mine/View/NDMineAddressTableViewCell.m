//
//  NDMineAddressTableViewCell.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineAddressTableViewCell.h"

@implementation NDMineAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)editAddressClick:(UIButton *)sender {
    _editAddressBlock?_editAddressBlock():nil;
}

- (IBAction)deleteAddressClick:(UIButton *)sender {
    _deleteAddressBlock?_deleteAddressBlock():nil;
}


-(void)setModel:(NDSelectDefaultAddrModel *)model{
    _model = model;
    self.labelPersonName.text = model.recipientName;
    self.labelPhone.text = model.moblie;
    self.labelAddress.text = [NSString stringWithFormat:@"%@%@%@%@",model.provinceName,model.cityName,model.areaName,model.detail];
    self.btnNormalAddr.selected = [model.type isEqualToString:@"1"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectNormalAddr:(UIButton *)sender {
    
    if (!sender.selected) {
        sender.selected = YES;
        _selectNormalAddressBlock?_selectNormalAddressBlock():nil;
    }
}
@end
