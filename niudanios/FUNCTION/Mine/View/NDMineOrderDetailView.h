//
//  NDMineOrderDetailView.h
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDMineOrderDetailView : UIView


@property (nonatomic ,copy) void(^lookOrderLogisticsDetailBlock)(void);
-(void)setLookOrderLogisticsDetailBlock:(void (^)(void))lookOrderLogisticsDetailBlock;

@end
