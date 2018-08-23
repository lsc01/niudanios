//
//  HLLAlertCustomVC.m
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/21.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import "HLLAlertCustomVC.h"
typedef void(^SelectCompleted)(int index);
typedef void(^ClickOKCompleted)(void);

//按钮个数枚举
typedef NS_ENUM(NSInteger , AlertType){
    ONEBUTTON = 1,
    TWOBUTTON = 2
};

@interface HLLAlertCustomVC ()

@property (nonatomic ,copy) SelectCompleted selectCompleted;
@property (nonatomic ,copy) ClickOKCompleted clickOKCompleted;

@property (nonatomic ,copy) NSString * message;
@property (nonatomic ,copy) NSString * leftString;
@property (nonatomic ,copy) NSString * rightString;

@property (nonatomic ,copy) NSString * btnString;

/**
 *  透明层button
 */
@property (nonatomic ,strong) UIButton * btnTranslucent;

@property (nonatomic ,strong) UIView * alertBackgroundView;

@property (nonatomic ,strong) UILabel * labelMessage;

@property (nonatomic ,strong) UIButton * btnLeft;

@property (nonatomic ,strong) UIButton * btnRight;

@property (nonatomic ,strong) UIButton * btnOne;

@property (nonatomic ,strong) UIView * lineHorizontalView;//横线

@property (nonatomic ,strong) UIView * lineVerticalView;//竖线

@property (nonatomic ,assign) AlertType alertType;//按钮个数枚举

@end

@implementation HLLAlertCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

+(instancetype)alertWithMessage:(NSString *)message left:(NSString *)leftString right:(NSString *)rightString completed:(void(^)(int index))completed{
    return [[self alloc] initAlertWithMessage:message left:leftString right:rightString completed:completed];
}

-(instancetype)initAlertWithMessage:(NSString *)message left:(NSString *)leftString right:(NSString *)rightString completed:(void(^)(int index))completed{
    
    if (self = [super init]) {
        self.message = message;
        self.leftString = leftString;
        self.rightString = rightString;
        self.selectCompleted = [completed copy];
        self.alertType = TWOBUTTON;
        self.touchBgClose = NO;
        
    }
    return self;
}

+(instancetype)alertWithMessage:(NSString *)message button:(NSString *)btnString completed:(void(^)(void))completed{
    return [[self alloc] initAlertWithMessage:message button:btnString completed:completed];
}

-(instancetype)initAlertWithMessage:(NSString *)message button:(NSString *)btnString completed:(void(^)(void))completed{
    if (self = [super init]) {
        self.message = message;
        self.btnString = btnString;
        self.clickOKCompleted = [completed copy];
        self.alertType = ONEBUTTON;
        self.touchBgClose = NO;
        self.oneBtnClose = NO;
    }
    return self;
}

-(void)showAlert{
    
    self.btnTranslucent.alpha = 0.2;
    switch (self.alertType) {
        case ONEBUTTON:
            {
                 [self createUIOne];
            }
            break;
        case TWOBUTTON:
            {
                [self createUITwo];
            }
            break;
            
        default:
            break;
    }
    
    
   
}

/**
 *  取消按钮点击事件,弹出框进行隐藏
 */
-(void)clickBackgroundBtn{
    if (self.isTouchBgClose) {
         [self removeAllView];
    }

}

-(void)removeAllView{
    //移除透明层button
    self.btnTranslucent.alpha = 0;
    [self.btnTranslucent removeFromSuperview];
    //移除选择器
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
-(void)createUIOne{
    
    self.labelMessage.text = self.message;
    [self.btnOne setTitle:self.btnString forState:UIControlStateNormal];
    
    //把弹窗视图加到window上
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    //把控制器给跟控制器处理
    [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:self];
    
    self.view.layer.cornerRadius = 5.0;
    self.view.clipsToBounds = YES;
    
    [self.view addSubview:self.labelMessage];
    [self.view addSubview:self.lineHorizontalView];
    [self.view addSubview:self.btnOne];
    
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.width.mas_equalTo(MAX(kScreenWidth, kScreenHeight)/3.0);
        make.height.mas_equalTo(MIN(kScreenWidth, kScreenHeight)/(3.0));
    }];
    
    [self.labelMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(5);
        make.right.mas_equalTo(self.view).offset(-5);
        make.height.mas_equalTo(self.view).multipliedBy(2/3.0);
    }];
    
    [self.lineHorizontalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.labelMessage.mas_bottom);
    }];
    
    
    [self.btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.lineHorizontalView.mas_bottom);
    }];
}


-(void)createUITwo{
    
    self.labelMessage.text = self.message;
    [self.btnLeft setTitle:self.leftString forState:UIControlStateNormal];
    [self.btnRight setTitle:self.rightString forState:UIControlStateNormal];
    
    //把弹窗视图加到window上
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    //把控制器给跟控制器处理
    [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:self];
    
    self.view.layer.cornerRadius = 5.0;
    self.view.clipsToBounds = YES;
    
    [self.view addSubview:self.labelMessage];
    [self.view addSubview:self.lineHorizontalView];
    [self.view addSubview:self.lineVerticalView];
    [self.view addSubview:self.btnLeft];
    [self.view addSubview:self.btnRight];

    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.width.mas_equalTo(MAX(kScreenWidth, kScreenHeight)/3.0);
        make.height.mas_equalTo(MIN(kScreenWidth, kScreenHeight)/(3.0));
    }];
    
    [self.labelMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view).multipliedBy(2/3.0);
    }];
    
    [self.lineHorizontalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.labelMessage.mas_bottom);
    }];
    
    [self.lineVerticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineHorizontalView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(1);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.lineVerticalView.mas_left);
        make.top.mas_equalTo(self.lineHorizontalView.mas_bottom);
    }];
    
    [self.btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.lineVerticalView.mas_right);
        make.top.mas_equalTo(self.lineHorizontalView.mas_bottom);
    }];
}

-(UIButton *)btnTranslucent{
    if (_btnTranslucent == nil) {
        _btnTranslucent = [UIButton buttonWithType:UIButtonTypeSystem];

        [_btnTranslucent setBackgroundColor:[UIColor grayColor]];
        [_btnTranslucent addTarget:self action:@selector(clickBackgroundBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [[UIApplication sharedApplication].keyWindow addSubview:_btnTranslucent];
        [_btnTranslucent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
    }
    return _btnTranslucent;
}

-(UIView *)alertBackgroundView{
    if (_alertBackgroundView == nil) {
        _alertBackgroundView = [[UIView alloc] init];
        _alertBackgroundView.backgroundColor = [UIColor whiteColor];
        _alertBackgroundView.layer.cornerRadius = 5;
        _alertBackgroundView.clipsToBounds = YES;
    }
    return _alertBackgroundView;
}

-(UILabel *)labelMessage{
    if (_labelMessage == nil) {
        _labelMessage = [[UILabel alloc] init];
        _labelMessage.font = [UIFont systemFontOfSize:18];
        _labelMessage.textColor = HEXCOLOR(0x333333);
        _labelMessage.textAlignment = NSTextAlignmentCenter;
        _labelMessage.numberOfLines = 0;
    }
    return _labelMessage;
}

-(UIView *)lineHorizontalView{
    if (_lineHorizontalView == nil) {
        _lineHorizontalView = [[UIView alloc] init];
        _lineHorizontalView.backgroundColor = HEXCOLOR(0xb3b3b3);
        
    }
    return _lineHorizontalView;
}

-(UIView *)lineVerticalView{
    if (_lineVerticalView == nil) {
        _lineVerticalView = [[UIView alloc] init];
        _lineVerticalView.backgroundColor = HEXCOLOR(0xb3b3b3);
        
    }
    return _lineVerticalView;
}


-(UIButton *)btnLeft{
    if (_btnLeft == nil) {
        _btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnLeft.titleLabel.font = [UIFont systemFontOfSize:16];
        [_btnLeft setTitleColor:HEXCOLOR(0xb3b3b3) forState:UIControlStateNormal];
        [_btnLeft addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnLeft;
}

-(UIButton *)btnRight{
    if (_btnRight == nil) {
        _btnRight = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnRight.titleLabel.font = [UIFont systemFontOfSize:16];
        [_btnRight setTitleColor:HEXCOLOR(0xff7301) forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}

-(UIButton *)btnOne{
    if (_btnOne == nil) {
        _btnOne = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnOne.titleLabel.font = [UIFont systemFontOfSize:16];
        [_btnOne setTitleColor:HEXCOLOR(0xff7301) forState:UIControlStateNormal];
        [_btnOne addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnOne;
}

-(void)oneButtonClick{
    if(self.isOneBtnClose){
        [self removeAllView];
    }
    self.clickOKCompleted?self.clickOKCompleted():nil;
}

-(void)leftBtnClick{
    [self removeAllView];
    self.selectCompleted?self.selectCompleted(1):nil;
}

-(void)rightBtnClick{
    [self removeAllView];
    self.selectCompleted?self.selectCompleted(2):nil;
    
}

@end
