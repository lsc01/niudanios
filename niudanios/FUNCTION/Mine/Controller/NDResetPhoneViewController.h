//
//  NDResetPhoneViewController.h
//  niudanios
//
//  Created by lsc on 2018/10/9.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBaseViewController.h"

@protocol NDResetPhoneViewControllerDelegate <NSObject>

-(void)updatePhoneSuccess;

@end

@interface NDResetPhoneViewController : NDBaseViewController

@property (nonatomic ,copy) NSString * phone;


@property (nonatomic ,weak) id<NDResetPhoneViewControllerDelegate> delegate;

@end
