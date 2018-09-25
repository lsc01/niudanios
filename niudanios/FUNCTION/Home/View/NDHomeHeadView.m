
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
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}


-(void)setUI{
    [self addSubview:self.cycleView];
    [self addSubview:self.viewBottomBg];
    self.cycVerticalView = [[ELCycleVerticalView alloc] initWithFrame:CGRectMake(40, 0, self.viewBottomBg.bounds.size.width-50, self.viewBottomBg.bounds.size.height)];
    self.cycVerticalView.delegate = self;
    [self.viewBottomBg addSubview:self.cycVerticalView];
    
    [self.cycVerticalView configureShowTime:2.5 animationTime:1
                             direction:ELCycleVerticalViewScrollDirectionUp
                       backgroundColor:[UIColor clearColor]
                             textColor:[UIColor darkGrayColor]
                                  font:[UIFont systemFontOfSize:14]
                         textAlignment:NSTextAlignmentCenter];
    
    
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
        
        UIImageView * imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_horn"]];
        imageview.frame = CGRectMake(12, 12, 20, 20 );
        [_viewBottomBg addSubview:imageview];
        
    }
    return _viewBottomBg;
}

- (void)elCycleVerticalView:(ELCycleVerticalView *)view didClickItemIndex:(NSInteger)index{
    NSLog(@"%ld", index);
}

// 开启动画 (主要用于进入其他页面返回时开启)
- (void)startAnimation{
    if (self.cycVerticalView) {
       [self.cycVerticalView startAnimation];
    }
}

// 关闭动画 (进入其他页面时调用)
- (void)stopAnimation{
    [self.cycVerticalView stopAnimation];
}
-(void)setClcleViewUrlImageArray:(NSArray *)array{
    [self.cycleView setImageURLStringsGroup:array];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
-(void)setcycVerticalArray:(NSArray *)array{
    CycleVerticalModel * model = [[CycleVerticalModel alloc] init];
    model.personName = @"model";
    model.goodsName = @"大家都";
    
    CycleVerticalModel * model2 = [[CycleVerticalModel alloc] init];
    model2.personName = @"model2";
    model2.goodsName = @"大大师傅离开";
    CycleVerticalModel * model3 = [[CycleVerticalModel alloc] init];
    model3.personName = @"model2";
    model3.goodsName = @"阿道夫敢问";
    CycleVerticalModel * model4 = [[CycleVerticalModel alloc] init];
    model4.personName = @"model4";
    model4.goodsName = @"鬼地方个";
    
    self.cycVerticalView.dataSource = @[
                                        model,model2,model3,model4
                                        ];
}

@end
