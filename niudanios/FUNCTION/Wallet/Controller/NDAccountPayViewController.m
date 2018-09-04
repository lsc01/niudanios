//
//  NDAccountPayViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/3.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDAccountPayViewController.h"
#import "UIButton+BackgroundColor.h"
@interface NDAccountPayViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnPay1;
@property (weak, nonatomic) IBOutlet UIButton *btnPay2;
@property (weak, nonatomic) IBOutlet UIButton *btnPay3;
@property (weak, nonatomic) IBOutlet UIButton *btnPay4;
@property (weak, nonatomic) IBOutlet UIButton *btnPay5;
@property (weak, nonatomic) IBOutlet UIButton *btnPay6;

@property (weak, nonatomic) IBOutlet UITextField *textFieldPay;
@property (weak, nonatomic) IBOutlet UIView *viewTextFeildBg;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectPayAli;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectPayWechat;
@property (weak, nonatomic) IBOutlet UIView *viewAliPayBg;
@property (weak, nonatomic) IBOutlet UIView *viewWechatPay;

@property (nonatomic ,strong) UIButton * btnCurrPay;
@property (nonatomic ,strong) UIButton * btnCurrPayType;

@end

@implementation NDAccountPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"账号充值";
    
    [self setUI];
}


-(void)setUI{
    
    self.btnCurrPayType = self.btnSelectPayAli;
    self.btnSelectPayAli.enabled = NO;
    
    self.btnCurrPay = self.btnPay1;
    self.btnPay1.enabled = NO;
    self.btnPay1.layer.cornerRadius = 4;
    self.btnPay1.clipsToBounds = YES;
    self.btnPay1.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
    self.btnPay1.layer.borderWidth = 0;
    [self.btnPay1 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnPay1 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnPay1 setBackgroundColor:HEXCOLOR(0x1dcb7c) forState:UIControlStateDisabled];
    
    self.btnPay2.layer.cornerRadius = 4;
    self.btnPay2.clipsToBounds = YES;
    self.btnPay2.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
    self.btnPay2.layer.borderWidth = 1;
    [self.btnPay2 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnPay2 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnPay2 setBackgroundColor:HEXCOLOR(0x1dcb7c) forState:UIControlStateDisabled];
    
    self.btnPay3.layer.cornerRadius = 4;
    self.btnPay3.clipsToBounds = YES;
    self.btnPay3.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
    self.btnPay3.layer.borderWidth = 1;
    [self.btnPay3 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnPay3 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnPay3 setBackgroundColor:HEXCOLOR(0x1dcb7c) forState:UIControlStateDisabled];
    
    self.btnPay4.layer.cornerRadius = 4;
    self.btnPay4.clipsToBounds = YES;
    self.btnPay4.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
    self.btnPay4.layer.borderWidth = 1;
    [self.btnPay4 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnPay4 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnPay4 setBackgroundColor:HEXCOLOR(0x1dcb7c) forState:UIControlStateDisabled];
    
    self.btnPay5.layer.cornerRadius = 4;
    self.btnPay5.clipsToBounds = YES;
    self.btnPay5.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
    self.btnPay5.layer.borderWidth = 1;
    [self.btnPay5 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnPay5 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnPay5 setBackgroundColor:HEXCOLOR(0x1dcb7c) forState:UIControlStateDisabled];
    
    self.btnPay6.layer.cornerRadius = 4;
    self.btnPay6.clipsToBounds = YES;
    self.btnPay6.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
    self.btnPay6.layer.borderWidth = 1;
    [self.btnPay6 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnPay6 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnPay6 setBackgroundColor:HEXCOLOR(0x1dcb7c) forState:UIControlStateDisabled];
    
    self.viewTextFeildBg.layer.cornerRadius = 4;
    self.viewTextFeildBg.clipsToBounds = YES;
    self.viewTextFeildBg.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
    self.viewTextFeildBg.layer.borderWidth = 1;
    
    self.viewAliPayBg.layer.cornerRadius = 4;
    self.viewAliPayBg.clipsToBounds = YES;
    self.viewAliPayBg.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
    self.viewAliPayBg.layer.borderWidth = 1;
    
    self.viewWechatPay.layer.cornerRadius = 4;
    self.viewWechatPay.clipsToBounds = YES;
    self.viewWechatPay.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
    self.viewWechatPay.layer.borderWidth = 1;
    
}


- (IBAction)payBtnClick:(UIButton *)sender {
    if (sender == self.btnCurrPay) {
        return;
    }
    self.btnCurrPay.enabled = YES;
    self.btnCurrPay.layer.borderWidth = 1;
    self.btnCurrPay = sender;
    self.btnCurrPay.enabled = NO;
    self.btnCurrPay.layer.borderWidth = 0;
    
}

- (IBAction)selectAliPayClick:(UIButton *)sender {
    if (sender == self.btnCurrPayType) {
        return;
    }
    self.btnCurrPayType.enabled = YES;
    self.btnCurrPayType = sender;
    self.btnCurrPayType.enabled = NO;
}

- (IBAction)selectWeChatPayClick:(UIButton *)sender {
    if (sender == self.btnCurrPayType) {
        return;
    }
    self.btnCurrPayType.enabled = YES;
    self.btnCurrPayType = sender;
    self.btnCurrPayType.enabled = NO;
}

- (IBAction)submitPayClick:(UIButton *)sender {
}


@end
