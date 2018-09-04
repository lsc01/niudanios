//
//  NDGoodsPayViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/4.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDGoodsPayViewController.h"
#import "UIViewController+toast.h"
@interface NDGoodsPayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (weak, nonatomic) IBOutlet UILabel *labelResidue;
@property (weak, nonatomic) IBOutlet UIButton *btnAlipay;
@property (weak, nonatomic) IBOutlet UIButton *btnWechat;
@property (weak, nonatomic) IBOutlet UIButton *btnResidue;

@property (nonatomic ,strong) UIButton * btnCurr;

@end

@implementation NDGoodsPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"选择支付方式";
    self.btnAlipay.enabled = NO;
    self.btnCurr = self.btnAlipay;
    self.btnPay.layer.cornerRadius = 4;
    self.btnPay.clipsToBounds = YES;
    
}

- (IBAction)payBtnClick:(UIButton *)sender {
    [self toastTip:@"余额不足哦，请选择其他支付方式"];
    
}
- (IBAction)selectPayType:(UIButton *)sender {
    if (sender == self.btnCurr) {
        return;
    }
    self.btnCurr.enabled = YES;
    self.btnCurr = sender;
    self.btnCurr.enabled = NO;
    
}

@end
