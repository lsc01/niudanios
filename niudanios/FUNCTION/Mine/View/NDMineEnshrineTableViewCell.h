//
//  NDMineEnshrineTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDMineEnshrineInfoModel.h"
@interface NDMineEnshrineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewGoods;

@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property (weak, nonatomic) IBOutlet UILabel *labelPrice;


@property (nonatomic ,strong) NDMineEnshrineInfoModel * model;


@property (nonatomic ,copy) void (^deleteEnshrinGoodsBlock)(NSString * Id);
@end
