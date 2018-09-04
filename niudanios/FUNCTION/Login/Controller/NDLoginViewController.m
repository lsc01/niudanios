//
//  NDLoginViewController.m
//  niudanios
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDLoginViewController.h"
#import "NDRegisterViewController.h"
#import "UIViewController+toast.h"

@interface NDLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewInputBg;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation NDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    [self setNav];
    [self setUI];
}

-(void)setNav{
    UIButton * btnRegist = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRegist setTitle:@"注册" forState:UIControlStateNormal];
    [btnRegist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnRegist.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnRegist addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btnRegist];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)registerBtnClick{
    NDRegisterViewController * registerVC = [[NDRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)setUI{
    self.viewInputBg.layer.cornerRadius = 4;
    self.viewInputBg.clipsToBounds = YES;
    
    
    self.btnLogin.layer.cornerRadius = 4;
    self.btnLogin.clipsToBounds = YES;
}

- (IBAction)loginClick:(id)sender {
    [self toastTip:@"密码不能为空哦"];
    
}
- (IBAction)wechatLoginClick:(id)sender {
}
- (IBAction)qqLoginClick:(id)sender {
}

@end
