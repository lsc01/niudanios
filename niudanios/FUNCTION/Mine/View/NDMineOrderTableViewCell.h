//
//  NDMineOrderTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDMineOrderInfoModel.h"
typedef NS_ENUM(NSInteger,OrderState) {
    OrderState_1 = 1,
    OrderState_2 = 2,
    OrderState_3 = 3
};

@interface NDMineOrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelOrderId;
@property (weak, nonatomic) IBOutlet UILabel *labelOrderState;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewGoods;

@property (weak, nonatomic) IBOutlet UILabel *labelGoodsName;

@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@property (weak, nonatomic) IBOutlet UIButton *btnOrder;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOrderBtn;

- (IBAction)rightBtnClick:(UIButton *)sender;

@property (nonatomic ,assign) OrderState orderState;

@property (nonatomic ,strong) NDMineOrderInfoModel * model;


@property (nonatomic ,copy) void(^rigthBtnActionBlock)(NSString * Id, OrderState orderState);

@end
