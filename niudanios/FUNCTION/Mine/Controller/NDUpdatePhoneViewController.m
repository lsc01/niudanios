//
//  NDUpdatePhoneViewController.m
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDUpdatePhoneViewController.h"
#import "SAMKeychain.h"
#import "NDResetPhoneViewController.h"
@interface NDUpdatePhoneViewController ()<NDResetPhoneViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewBg1;
@property (weak, nonatomic) IBOutlet UIView *viewBg2;
@property (weak, nonatomic) IBOutlet UILabel *labelBindPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCode;
@property (weak, nonatomic) IBOutlet UIButton *btnCode;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNewPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelTips;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (nonatomic ,strong) NSTimer * timer;
@property (nonatomic ,assign) NSInteger secondsCoundDown;

@end

@implementation NDUpdatePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改手机号";
    
    [self setUI];
}

-(void)setUI{
    self.viewBg1.layer.cornerRadius = 4;
    self.viewBg1.layer.masksToBounds = YES;
    self.viewBg2.layer.cornerRadius = 4;
    self.viewBg2.layer.masksToBounds = YES;
    self.btnSubmit.layer.cornerRadius = 4;
    self.btnSubmit.layer.masksToBounds = YES;
    self.labelTips.hidden = YES;
    if ([HLLShareManager shareMannager].userModel.loginMobile.length!=11) {
        self.labelBindPhone.text = @"未绑定手机号";
    }else{
       self.labelBindPhone.text = [NSString stringWithFormat:@"已绑定手机号:%@****%@",[[HLLShareManager shareMannager].userModel.loginMobile substringToIndex:5],[[HLLShareManager shareMannager].userModel.loginMobile substringFromIndex:9]];
    }
    
}
- (IBAction)getCodeBtnClick:(UIButton *)sender {
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
                if (self.timer == nil) {
                    self.btnCode.enabled = NO;
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
- (IBAction)submitClick:(UIButton *)sender {
    self.labelTips.hidden = YES;
    if (![HLLVerifyTools hllVerifyMobile:self.textFieldNewPhone.text]) {
        [SVProgressHUD showToast:@"手机号不正确"];
        return;
    }
    
    if ([self.textFieldNewPhone.text isEqualToString:[HLLShareManager shareMannager].userModel.loginMobile]) {
        self.labelTips.hidden = NO;
        return;
    }
    
    if (![HLLVerifyTools hllIsNum:self.textFieldCode.text]) {
        [SVProgressHUD showToast:@"验证码格式错误"];
        return;
    }
    
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.textFieldCode.text forKey:@"confirmation"];
    [dictP setObject:[HLLShareManager shareMannager].userModel.loginMobile forKey:@"loginMobile"];
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_confirmMobile params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dictT = arrRows.firstObject;
            NSInteger code = [dictT[@"code"] integerValue];
            if (code == 0) {
                NDResetPhoneViewController * vc = [[NDResetPhoneViewController alloc] init];
                vc.delegate = self;
                vc.phone = self.textFieldNewPhone.text;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [SVProgressHUD showToast:dictT[@"msg"]];
            }
        }
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
    
}

-(void)updatePhoneSuccess{
    if ([self.delegate respondsToSelector:@selector(updatePhoneSuccess)]) {
        [self.delegate updatePhoneSuccess];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)msmCodeGet{
    self.secondsCoundDown --;
}

-(void)setSecondsCoundDown:(NSInteger)secondsCoundDown{
    _secondsCoundDown = secondsCoundDown;
    if (_secondsCoundDown == 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.btnCode.enabled = YES;
    }else{
        [self.btnCode setTitle:[NSString stringWithFormat:@"%ds后重试",self.secondsCoundDown] forState:UIControlStateDisabled];
    }
}

-(void)dealloc{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end
