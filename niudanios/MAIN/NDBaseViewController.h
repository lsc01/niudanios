//
//  NDBaseViewController.h
//  niudanios
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDBaseViewController : UIViewController
#pragma 返回按钮点击以后调用此方法，可在此方法里做些什么
///控制器实现此方法，点击返回按钮会调用，返回值为NO:则不会返回到上一个页面，用来处理返回前的一些事件
-(BOOL)navigationShouldPopOnBackButtonClick;
@end
