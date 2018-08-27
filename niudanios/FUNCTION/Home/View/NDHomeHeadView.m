
//
//  NDHomeHeadView.m
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDHomeHeadView.h"


@implementation NDHomeHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}


-(void)setUI{
    [self addSubview:self.cycleView];
    [self addSubview:self.viewBottomBg];
}
#pragma mark - SDCycleScrollViewDelegate 轮播器点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"轮播器点击 index = %d",index);
    
}

-(SDCycleScrollView *)cycleView{
    if(_cycleView == nil){
        
        _cycleView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, kScreenWidth, cycleView_H) delegate:self placeholderImage:[UIImage imageNamed:@"bg_a"]];
        _cycleView.autoScrollTimeInterval = 2;
        //显示分页，还有很多属性可以自定义
        _cycleView.showPageControl = YES;
        _cycleView.backgroundColor = [UIColor clearColor];
        _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleView.titleLabelBackgroundColor = [UIColor clearColor];
    }
    return _cycleView;
}

-(UIView *)viewBottomBg{
    if (_viewBottomBg == nil) {
        _viewBottomBg = [[UIView alloc] init];
        _viewBottomBg.backgroundColor = [UIColor whiteColor];
        _viewBottomBg.frame = CGRectMake(0, cycleView_H, kScreenWidth, 44);
    }
    return _viewBottomBg;
}

@end
