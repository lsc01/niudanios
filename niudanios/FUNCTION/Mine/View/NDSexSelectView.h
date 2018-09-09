//
//  NDSexSelectView.h
//  niudanios
//
//  Created by lsc on 2018/9/9.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kSexSelectHeight 159

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

typedef void(^NDSexResultBlock)(NSString *selectValue);

@interface NDSexSelectView : UIView
+ (instancetype)showSexResultBlock:(NDSexResultBlock)resultBlock;

/** 初始化子视图 */
- (void)initUI;

/** 点击背景遮罩图层事件 */
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender;

@end
