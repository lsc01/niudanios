//
//  NDMineAddressViewController.h
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBaseViewController.h"
#import "NDSelectDefaultAddrModel.h"
@protocol NDMineAddressViewControllerDelegate <NSObject>

-(void)selectMineAddressWithModel:(NDSelectDefaultAddrModel *)model;

@end

@interface NDMineAddressViewController : NDBaseViewController

@property (nonatomic ,weak) id<NDMineAddressViewControllerDelegate> delegate;

@end
