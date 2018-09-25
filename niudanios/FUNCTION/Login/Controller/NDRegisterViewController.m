//
//  NDRegisterViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDRegisterViewController.h"
#import "NDBindPhoneViewController.h"
@interface NDRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewInputBg;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMsg;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPwd;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPwdTow;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCode;
@property (weak, nonatomic) IBOutlet UILabel *labelRemind;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@end

@implementation NDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
    [self setNav];
    [self setUI];
}

-(void)setNav{
    UIButton * btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnLogin.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnLogin addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btnLogin];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)loginBtnClick{
    NDBindPhoneViewController * vc = [[NDBindPhoneViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setUI{
    self.viewInputBg.layer.cornerRadius = 4;
    self.viewInputBg.clipsToBounds = YES;
    
    
    self.btnRegister.layer.cornerRadius = 4;
    self.btnRegister.clipsToBounds = YES;
}

- (IBAction)registerClick:(id)sender {
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:@"18670373195" forKey:@"loginMobile"];
    [dictP setObject:@"123456" forKey:@"loginPwd"];
    [dictP setObject:@"123456" forKey:@"verificationCode"];
    
    [HLLHttpManager postWithURL:URL_Register params:dictP success:^(NSDictionary *responseObject) {
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        
    }];
}

- (IBAction)getCodeClick:(id)sender {
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:@"18670373195" forKey:@"loginMobile"];
    [dictP setObject:@"123456" forKey:@"loginPwd"];
    [dictP setObject:@"123456" forKey:@"verificationCode"];
    
    [HLLHttpManager postWithURL:URL_Register params:dictP success:^(NSDictionary *responseObject) {
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        
    }];
    
}
@end
