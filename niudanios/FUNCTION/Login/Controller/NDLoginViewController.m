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
#import "ShareSdkHeader.h"
#import "NDUserInfoModel.h"
#import "SAMKeychain.h"
#import "NDBindPhoneViewController.h"
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
    
    
    if (![HLLVerifyTools hllVerifyMobile:self.textFieldPhone.text]) {
        [SVProgressHUD showToast:@"手机号不正确"];
        return;
    }
    
    if(self.textFieldPwd.text.length<1){
        [SVProgressHUD showToast:@"密码不能为空"];
        return;
    }
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.textFieldPhone.text forKey:@"loginMobile"];
    [dictP setObject:self.textFieldPwd.text forKey:@"loginPwd"];
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_LoginPwd params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dictT = arrRows.firstObject;
            NSInteger code = [dictT[@"code"] integerValue];
            if (code == 0) {
                [SVProgressHUD showToast:@"登录成功"];
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
                [SVProgressHUD showToast:dictT[@"msg"]];
            }
        }
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
    
}
- (IBAction)wechatLoginClick:(id)sender {
    if ([ShareSDK hasAuthorized:SSDKPlatformTypeWechat]) {
        [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
    }
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             [self loginWithOpenId:user.uid andStatus:@"2" andNickName:user.nickname andIcon:user.icon];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
    
}
- (IBAction)qqLoginClick:(id)sender {
    
    if ([ShareSDK hasAuthorized:SSDKPlatformTypeQQ]) {
        [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
    }
    
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             [self loginWithOpenId:user.uid andStatus:@"1" andNickName:user.nickname andIcon:user.icon];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}


-(void)loginWithOpenId:(NSString *)openId andStatus:(NSString *)status andNickName:(NSString *)nickName andIcon:(NSString *)icon{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:status forKey:@"status"];
    [dictP setObject:openId forKey:@"openid"];
    [SVProgressHUD show];
    
    [HLLHttpManager postWithURL:URL_thirdParty params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dictT = arrRows.firstObject;
            NSInteger code = [dictT[@"code"] integerValue];
            if (code == 0) {
                [SVProgressHUD showToast:@"登录成功"];
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
                [SVProgressHUD showToast:@"未绑定手机号，请进行手机号绑定"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NDBindPhoneViewController * vc = [NDBindPhoneViewController new];
                    vc.openId = openId;
                    vc.status = status;
                    vc.avatar = icon;
                    vc.name = nickName;
                    vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:YES];
                });
            }
        }
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
}

-(void)loginAccountSuccess{
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(loginAccountSuccess)]) {
        [self.delegate loginAccountSuccess];
    }
}

@end
