//
//  NDVerifyOrderViewController.h
//  niudanios
//
//  Created by lsc on 2018/9/6.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBaseViewController.h"
#import "NDSelectDefaultAddrModel.h"
#import "NDPackageGoodsModel.h"

@protocol NDVerifyOrderViewControllerDelegate<NSObject>
-(void)submitOrderSucceed;

@end

@interface NDVerifyOrderViewController : NDBaseViewController

@property (nonatomic ,strong) NDSelectDefaultAddrModel * defaultAddrModel;

@property (nonatomic ,strong) NSArray <NDPackageGoodsModel *> * arrGoodsModel;

@property (nonatomic ,weak) id<NDVerifyOrderViewControllerDelegate> delegate;

@end
