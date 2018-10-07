//
//  NDForgetPwdViewController.m
//  niudanios
//
//  Created by lsc on 2018/10/7.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDForgetPwdViewController.h"
#import "HLLVerifyTools.h"
@interface NDForgetPwdViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewInputBg1;
@property (weak, nonatomic) IBOutlet UIView *viewInputBg2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPwdOld;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMsg;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPwdNew;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPwdNew2;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCode;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@end

@implementation NDForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    
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
    
    if(self.textFieldPwdOld.text.length<1){
        [SVProgressHUD showToast:@"旧密码不能为空"];
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
    [dictP setObject:[HLLShareManager shareMannager].userModel.loginMobile forKey:@"loginMobile"];
    [dictP setObject:self.textFieldMsg.text forKey:@"confirmation"];
    [dictP setObject:self.textFieldPwdOld.text forKey:@"loginPwd"];
    [dictP setObject:self.textFieldPwdNew.text forKey:@"newPwd"];
    
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_updatePwd params:dictP success:^(NSDictionary *responseObject) {
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
   
    [SVProgressHUD show];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:[HLLShareManager shareMannager].userModel.loginMobile forKey:@"loginMobile"];
    
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
