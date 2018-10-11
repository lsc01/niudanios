//
//  NDBindPhoneViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBindPhoneViewController.h"
#import "SAMKeychain.h"
@interface NDBindPhoneViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewInputBg;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMsg;

@property (weak, nonatomic) IBOutlet UIButton *btnGetCode;


@property (weak, nonatomic) IBOutlet UIButton *btnBindPhone;

@property (nonatomic ,strong) NSTimer * timer;
@property (nonatomic ,assign) NSInteger secondsCoundDown;
@end

@implementation NDBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


    self.title = @"绑定手机";
    
    [self setUI];
}

-(void)setUI{
    self.viewInputBg.layer.cornerRadius = 4;
    self.viewInputBg.clipsToBounds = YES;
    
    
    self.btnBindPhone.layer.cornerRadius = 4;
    self.btnBindPhone.clipsToBounds = YES;
}

- (IBAction)bindPhoneClick:(id)sender {
    
    if (![HLLVerifyTools hllVerifyMobile:self.textFieldPhone.text]) {
        [SVProgressHUD showToast:@"手机号不正确"];
        return;
    }
    
    if (![HLLVerifyTools hllIsNum:self.textFieldMsg.text]) {
        [SVProgressHUD showToast:@"验证码格式错误"];
        return;
    }
    
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.status forKey:@"status"];
    [dictP setObject:self.openId forKey:@"openid"];
    [dictP setObject:self.name forKey:@"name"];
    [dictP setObject:self.avatar forKey:@"avatar"];
    [dictP setObject:self.textFieldPhone.text forKey:@"loginMobile"];
    [dictP setObject:self.textFieldMsg.text forKey:@"confirmation"];

    [SVProgressHUD show];
    
    [HLLHttpManager postWithURL:URL_bundlingPhone params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dictT = arrRows.firstObject;
            NSInteger code = [dictT[@"code"] integerValue];
            if (code == 0) {
                [SVProgressHUD showToast:@"绑定成功"];
                NDUserInfoModel * userModel = [NDUserInfoModel mj_objectWithKeyValues:dictT[@"tbCustomer"]];
                NSData * data = [NSJSONSerialization dataWithJSONObject:dictT options:0 error:nil];
                [SAMKeychain setPasswordData:data forService:sevodadacnuizcnas account:acdadaddacnuizcnas];
                [HLLShareManager shareMannager].userModel = userModel;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                    if ([self.delegate respondsToSelector:@selector(loginAccountSuccess)]) {
                        [self.delegate loginAccountSuccess];
                    }
                });
            }else{
                
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
