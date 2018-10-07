//
//  NDMineAddressTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDSelectDefaultAddrModel.h"
@interface NDMineAddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelPersonName;

@property (weak, nonatomic) IBOutlet UILabel *labelPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;


@property (nonatomic,strong) NDSelectDefaultAddrModel * model;


@property (nonatomic ,copy) void(^editAddressBlock)(void);
@property (nonatomic ,copy) void(^deleteAddressBlock)(void);
@end
