//
//  NDSettingTableViewCell.m
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDSettingTableViewCell.h"

@implementation NDSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (IBAction)switchVoiceChange:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setObject:sender.isOn?@"Y":@"N" forKey:kVoiceSwitch];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
