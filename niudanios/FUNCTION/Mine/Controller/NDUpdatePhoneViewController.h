//
//  NDUpdatePhoneViewController.h
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBaseViewController.h"
@protocol NDUpdatePhoneViewControllerDelegate<NSObject>
-(void)updatePhoneSuccess;

@end

@interface NDUpdatePhoneViewController : NDBaseViewController

@property (nonatomic ,weak) id<NDUpdatePhoneViewControllerDelegate> delegate;

@end
