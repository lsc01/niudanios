//
//  NDMIneDataViewController.h
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBaseViewController.h"
@protocol NDMIneDataViewControllerDelegate <NSObject>

-(void)updateDataInfoSuccess;

@end

@interface NDMIneDataViewController : NDBaseViewController

@property (nonatomic ,weak) id<NDMIneDataViewControllerDelegate> delegate;

@end
