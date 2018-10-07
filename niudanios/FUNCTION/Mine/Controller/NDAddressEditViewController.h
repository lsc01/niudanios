//
//  NDAddressEditViewController.h
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBaseViewController.h"
#import "NDSelectDefaultAddrModel.h"
@protocol NDAddressEditViewControllerDelegate<NSObject>
-(void)addNewAddrSuccess;
@end

@interface NDAddressEditViewController : NDBaseViewController

@property (nonatomic ,weak) id<NDAddressEditViewControllerDelegate> delegate;

@property (nonatomic ,strong) NDSelectDefaultAddrModel * modelAddress;
@end
