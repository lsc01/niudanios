//
//  NDResetPwdViewController.m
//  niudanios
//
//  Created by lsc on 2018/12/16.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDResetPwdViewController.h"

@interface NDResetPwdViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewInputBg1;
@property (weak, nonatomic) IBOutlet UIView *viewInputBg2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMsg;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPwdNew;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPwdNew2;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCode;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (nonatomic ,strong) NSTimer * timer;
@property (nonatomic ,assign) NSInteger secondsCoundDown;
@end

@implementation NDResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setUI];
}

-(void)setUI{
    self.viewInputBg1.layer.cornerRadius = 4;
    self.viewInputBg1.clipsToBounds = YES;
    
    self.viewInputBg2.layer.cornerRadius = 4;
    self.viewInputBg2.clipsToBounds = YES;
    
    self.btnSubmit.layer.cornerRadius = 4;
    self.btnSubmit.clipsToBounds = YES;
}

- (IBAction)submitClick:(id)sender {
    
    if(self.textFieldPhone.text.length<1){
        [SVProgressHUD showToast:@"手机号不能为空"];
        return;
    }
    
    if (![HLLVerifyTools hllIsNum:self.textFieldMsg.text]) {
        [SVProgressHUD showToast:@"验证码格式错误"];
        return;
    }
    
    if(self.textFieldPwdNew.text.length<1||self.textFieldPwdNew2.text.length<1){
        [SVProgressHUD showToast:@"新密码不能为空"];
        return;
    }
    if(![self.textFieldPwdNew.text isEqualToString:self.textFieldPwdNew2.text]){
        [SVProgressHUD showToast:@"两次密码不一致"];
        return;
    }
    
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.textFieldMsg.text forKey:@"confirmation"];
    [dictP setObject:self.textFieldPhone.text forKey:@"loginMobile"];
    [dictP setObject:self.textFieldPwdNew.text forKey:@"loginPwd"];
    
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_resetPwd params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dictT = arrRows.firstObject;
            NSInteger code = [dictT[@"code"] integerValue];
            if (code == 0) {
                [SVProgressHUD showToast:@"修改成功"];
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
    if(self.textFieldPhone.text.length<1){
        [SVProgressHUD showToast:@"手机号不能为空"];
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
                if (self.timer == nil) {
                    self.btnGetCode.enabled = NO;
                    self.secondsCoundDown = 60;
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(msmCodeGet) userInfo:nil repeats:YES];
                }
            }else{
                [SVProgressHUD showToast:dictT[@"msg"]];
            }
        }
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
    
}
-(void)msmCodeGet{
    self.secondsCoundDown --;
}

-(void)setSecondsCoundDown:(NSInteger)secondsCoundDown{
    _secondsCoundDown = secondsCoundDown;
    if (_secondsCoundDown == 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.btnGetCode.enabled = YES;
    }else{
        [self.btnGetCode setTitle:[NSString stringWithFormat:@"%ds后重试",self.secondsCoundDown] forState:UIControlStateDisabled];
    }
}

-(void)dealloc{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
