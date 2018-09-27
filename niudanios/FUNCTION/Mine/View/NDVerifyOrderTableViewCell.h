//
//  NDVerifyOrderTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/9/6.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDPackageGoodsModel.h"
@interface NDVerifyOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewGoods;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelSpecification;

@property (nonatomic ,strong) NDPackageGoodsModel * model;
@end
