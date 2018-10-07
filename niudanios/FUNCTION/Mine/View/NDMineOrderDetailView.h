//
//  NDMineOrderDetailView.h
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDOrderDetailInfoModel.h"
@interface NDMineOrderDetailView : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelOrderState;

@property (weak, nonatomic) IBOutlet UILabel *labelogInfo;

@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelAddr;


@property (nonatomic ,copy) void(^lookOrderLogisticsDetailBlock)(void);
-(void)setLookOrderLogisticsDetailBlock:(void (^)(void))lookOrderLogisticsDetailBlock;

@property (nonatomic ,strong ) NDOrderDetailInfoModel * model;

@end
