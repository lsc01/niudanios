//
//  NDHomeHeadView.h
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "ELCycleVerticalView.h"
#import "CycleVerticalModel.h"
#define cycleView_H (kScreenWidth*(380.0/750))

@interface NDHomeHeadView : UIView<SDCycleScrollViewDelegate,ELCycleVerticalViewDelegate>
@property (nonatomic ,strong) SDCycleScrollView *cycleView;//轮播图

@property (nonatomic ,strong) UIView * viewBottomBg;

@property (nonatomic ,strong) ELCycleVerticalView *cycVerticalView;


-(void)setClcleViewUrlImageArray:(NSArray *)array;
-(void)setcycVerticalArray:(NSArray *)array;
// 开启动画 (主要用于进入其他页面返回时开启)
- (void)startAnimation;

// 关闭动画 (进入其他页面时调用)
- (void)stopAnimation;
@end
