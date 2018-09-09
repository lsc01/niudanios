//
//  NDSexSelectView.m
//  niudanios
//
//  Created by lsc on 2018/9/9.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDSexSelectView.h"


@interface NDSexSelectView ()
{
    NDSexResultBlock _resultBlock;
}

// 背景视图
@property (nonatomic, strong) UIView *backgroundView;
// 弹出视图
@property (nonatomic, strong) UIView *alertView;

@property (nonatomic ,strong) UIView * viewTopSelect;

@property (nonatomic ,strong) UIView * viewline;

@property (nonatomic ,strong) UIButton * btnMale;

@property (nonatomic ,strong) UIButton * btnFemale;

@property (nonatomic ,strong) UIButton * btnCancel;

@end

@implementation NDSexSelectView

#pragma mark - 显示时间选择器
+ (instancetype)showSexResultBlock:(NDSexResultBlock)resultBlock {
    return [[NDSexSelectView alloc]initShowSexResultBlock:resultBlock];
}

#pragma mark - 初始化时间选择器
- (instancetype)initShowSexResultBlock:(NDSexResultBlock)resultBlock {
    if (self = [super init]) {
       
        _resultBlock = resultBlock;
        
        [self initUI];
    }
    return self;
}

#pragma mark - 初始化子视图

- (void)initUI {
    self.frame = SCREEN_BOUNDS;
    // 背景遮罩图层
    [self addSubview:self.backgroundView];
    // 弹出视图
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.viewTopSelect];
    [self.alertView addSubview:self.btnCancel];
    // 设置弹出视图子视图
    [self showWithAnimation:YES];
}

#pragma mark - 背景遮罩图层
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.20];
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView:)];
        [_backgroundView addGestureRecognizer:myTap];
    }
    return _backgroundView;
}

#pragma mark - 弹出视图
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight  - kSexSelectHeight, kScreenWidth,  kSexSelectHeight)];
        _alertView.backgroundColor = [UIColor clearColor];
    }
    return _alertView;
}


#pragma mark - 点击背景遮罩图层事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    [self dismissWithAnimation:NO];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    //1. 获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        // 动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = kScreenHeight;
        self.alertView.frame = rect;
        
        // 浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= kSexSelectHeight;
            self.alertView.frame = rect;
        }];
    }
}
#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += kSexSelectHeight;
        self.alertView.frame = rect;
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.btnMale removeFromSuperview];
        [self.viewline removeFromSuperview];
        [self.btnFemale removeFromSuperview];
        [self.viewTopSelect removeFromSuperview];
        [self.btnCancel removeFromSuperview];
        [self.alertView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        self.btnMale = nil;
        self.viewline = nil;
        self.btnFemale = nil;
        self.viewTopSelect = nil;
        self.btnCancel = nil;
        self.alertView = nil;
        self.backgroundView = nil;
    }];
}


-(UIView *)viewTopSelect{
    if (_viewTopSelect == nil) {
        _viewTopSelect = [[UIView alloc] init];
        _viewTopSelect.frame = CGRectMake(12, 0, kScreenWidth-24, 89);
        _viewTopSelect.backgroundColor = [UIColor whiteColor];
        
        _viewTopSelect.layer.cornerRadius = 4;
        _viewTopSelect.clipsToBounds = YES;
        
        
        [_viewTopSelect addSubview:self.btnMale];
        [_viewTopSelect addSubview:self.viewline];
        [_viewTopSelect addSubview:self.btnFemale];
    }
    return _viewTopSelect;
}

-(UIButton *)btnMale{
    if (_btnMale == nil) {
        _btnMale = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnMale setTitle:@"男" forState:UIControlStateNormal];
        [_btnMale setBackgroundColor:[UIColor whiteColor]];
        [_btnMale setTitleColor:HEXCOLOR(0x222222) forState:UIControlStateNormal];
        _btnMale.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnMale.frame = CGRectMake(0, 0, kScreenWidth-24, 44);
        [_btnMale addTarget:self action:@selector(btnMaleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnMale;
}

-(UIView *)viewline{
    if (_viewline == nil) {
        _viewline = [[UIView alloc] init];
        _viewline.frame =CGRectMake(0, 44, kScreenWidth - 24, 1);
        _viewline.backgroundColor = HEXCOLOR(0xe5e5e5);
    }
    return _viewline;
}

-(UIButton *)btnFemale{
    if (_btnFemale == nil) {
        _btnFemale = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnFemale setTitle:@"女" forState:UIControlStateNormal];
        [_btnFemale setBackgroundColor:[UIColor whiteColor]];
        [_btnFemale setTitleColor:HEXCOLOR(0x222222) forState:UIControlStateNormal];
        _btnFemale.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnFemale.frame = CGRectMake(0, 45, kScreenWidth-24, 44);
        [_btnFemale addTarget:self action:@selector(btnFemaleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnFemale;
}

-(UIButton *)btnCancel{
    if (_btnCancel == nil) {
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancel setBackgroundColor:[UIColor whiteColor]];
        [_btnCancel setTitleColor:HEXCOLOR(0x1dcb7c) forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnCancel.frame = CGRectMake(12, 89+12, kScreenWidth-24, 44);
        _btnCancel.layer.cornerRadius = 4;
        _btnCancel.clipsToBounds = YES;
        [_btnCancel addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCancel;
}

-(void)btnMaleClick{
    [self dismissWithAnimation:YES];
    _resultBlock?_resultBlock(@"男"):nil;
}

-(void)btnFemaleClick{
    [self dismissWithAnimation:YES];
    _resultBlock?_resultBlock(@"女"):nil;
}

-(void)btnCancelClick{
    [self dismissWithAnimation:YES];
}


@end
