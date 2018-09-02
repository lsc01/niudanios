//
//  NDHomeHeadView.h
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "HRAdView.h"
#define cycleView_H (kScreenWidth*(380.0/750))

@interface NDHomeHeadView : UIView<SDCycleScrollViewDelegate>
@property (nonatomic ,strong) SDCycleScrollView *cycleView;//轮播图

@property (nonatomic ,strong) UIView * viewBottomBg;
@property (nonatomic, strong) HRAdView *adView;

@property (nonatomic ,strong) NSArray * arrayMsgData;
@end
