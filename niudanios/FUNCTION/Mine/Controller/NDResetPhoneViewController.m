//
//  NDResetPhoneViewController.m
//  niudanios
//
//  Created by lsc on 2018/10/9.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDResetPhoneViewController.h"
#import "SAMKeychain.h"

@interface NDResetPhoneViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewBg1;


@property (weak, nonatomic) IBOutlet UITextField *textFieldCode;
@property (weak, nonatomic) IBOutlet UIButton *btnCode;


@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (nonatomic ,strong) NSTimer * timer;
@property (nonatomic ,assign) NSInteger secondsCoundDown;
@end

@implementation NDResetPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改手机号";
    
    [self setUI];
}

-(void)setUI{
    self.viewBg1.layer.cornerRadius = 4;
    self.viewBg1.layer.masksToBounds = YES;
    
    
    self.btnSubmit.layer.cornerRadius = 4;
    self.btnSubmit.layer.masksToBounds = YES;
    
    
}
- (IBAction)getCodeBtnClick:(UIButton *)sender {
    [SVProgressHUD show];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.phone forKey:@"loginMobile"];
    
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
- (IBAction)submitClick:(UIButton *)sender {
    
    if (![HLLVerifyTools hllIsNum:self.textFieldCode.text]) {
        [SVProgressHUD showToast:@"验证码格式错误"];
        return;
    }
    
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.textFieldCode.text forKey:@"confirmation"];
    [dictP setObject:self.phone forKey:@"newMobile"];
    [dictP setObject:[HLLShareManager shareMannager].userModel.loginMobile forKey:@"loginMobile"];
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_resetMobile params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dictT = arrRows.firstObject;
            NSInteger code = [dictT[@"code"] integerValue];
            if (code == 0) {
                [SVProgressHUD showToast:@"修改成功"];
                [HLLShareManager shareMannager].userModel.loginMobile = self.phone;
                NSDictionary * dic = [[HLLShareManager shareMannager].userModel mj_keyValues];
                NSData * data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
                [SAMKeychain setPasswordData:data forService:sevodadacnuizcnas account:acdadaddacnuizcnas];
                if ([self.delegate respondsToSelector:@selector(updatePhoneSuccess)]) {
                    [self.delegate updatePhoneSuccess];
                }
                [self.navigationController popViewControllerAnimated:YES];
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
