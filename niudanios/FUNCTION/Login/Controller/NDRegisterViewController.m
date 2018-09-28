//
//  NDRegisterViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDRegisterViewController.h"
#import "NDBindPhoneViewController.h"
#import "HLLVerifyTools.h"
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
    if (![HLLVerifyTools hllVerifyMobile:self.textFieldPhone.text]) {
        [SVProgressHUD showToast:@"手机号不正确"];
        return;
    }
    
    if (![HLLVerifyTools hllIsNum:self.textFieldMsg.text]) {
        [SVProgressHUD showToast:@"验证码格式错误"];
        return;
    }
    
    if(self.textFieldPwd.text.length<1||self.textFieldPwdTow.text.length<1){
        [SVProgressHUD showToast:@"密码不能为空"];
        return;
    }
    if(![self.textFieldPwd.text isEqualToString:self.textFieldPwdTow.text]){
        [SVProgressHUD showToast:@"两次密码不一致"];
        return;
    }
    
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.textFieldPhone.text forKey:@"loginMobile"];
    [dictP setObject:self.textFieldPwd.text forKey:@"loginPwd"];
    [dictP setObject:self.textFieldPwd.text forKey:@"verificationCode"];
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_Register params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dictT = arrRows.firstObject;
            NSInteger code = [dictT[@"code"] integerValue];
            if (code == 0) {
                [SVProgressHUD showToast:@"注册成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showToast:dictT[@"msg"]];
            }
        }
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
}

- (IBAction)getCodeClick:(id)sender {
    if (![HLLVerifyTools hllVerifyMobile:self.textFieldPhone.text]) {
        [SVProgressHUD showToast:@"手机号不正确"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.textFieldPhone.text forKey:@"loginMobile"];
    
    [HLLHttpManager postWithURL:URL_identifyingCode params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dictT = arrRows.firstObject;
            NSInteger code = [dictT[@"code"] integerValue];
            if (code == 0) {
                [SVProgressHUD showToast:@"验证码发送成功"];
            }else{
                [SVProgressHUD showToast:dictT[@"msg"]];
            }
        }
    
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
    
}
@end
