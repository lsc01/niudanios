//
//  NDPayManager.m
//  niudanios
//
//  Created by lsc on 2018/9/16.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDPayManager.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"



@interface NDPayManager ()
///支付宝订单
@property (nonatomic ,copy)NSString * randomNo;
///微信支付订单
@property (nonatomic ,copy)NSString * outTradeNo;

@end
@implementation NDPayManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static NDPayManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[NDPayManager alloc] init];
        instance.payStatus = pay_status_none;
        
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ndNotification_DidBecomeActive) name:@"NOTIFICATION_DidBecomeActive" object:nil];
    }
    return self;
}


// NOTE: 订单总金额，单位为元，精确到小数点后两位，取值范围[0.01,100000000]
-(void)aliPayWithMoney:(NSInteger)money{
    [SVProgressHUD showWithStatus:@"正在支付宝支付中"];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:@(money) forKey:@"money"];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    [HLLHttpManager postWithURL:URL_alipay params:dictP success:^(NSDictionary *responseObject) {
        NSArray * arrT = responseObject[@"rows"];
        if (arrT.count>0) {
            NSDictionary * dictT = arrT.firstObject;
            if ([dictT[@"code"] integerValue] == 0) {
                
                NSString *result = dictT[@"result"];
                NSString * randomNo = dictT[@"randomNo"];
                self.randomNo = randomNo;
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:result fromScheme:Alipay_scheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"alipay reslut = %@",resultDic);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                }];
                self.payStatus = pay_status_alipay;
            }else{
                [SVProgressHUD dismiss];
                [SVProgressHUD showToast:@"操作失败"];
            }
        }
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"操作失败"];
    }];
    
}


-(void)processOrderWithPaymentResult:(NSURL *)url{
    self.payStatus = pay_status_none;
    // 支付跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result1 = %@",resultDic);
        [self verifyAliPay];
    }];

    // 授权跳转支付宝钱包进行支付，处理支付结果,程序被杀死时调用
    [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result2 = %@",resultDic);
        // 解析 auth code
        NSString *result = resultDic[@"result"];
        NSString *authCode = nil;
        if (result.length>0) {
            NSArray *resultArr = [result componentsSeparatedByString:@"&"];
            for (NSString *subResult in resultArr) {
                if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                    authCode = [subResult substringFromIndex:10];
                    break;
                }
            }
        }
        NSLog(@"授权结果 authCode = %@", authCode?:@"");
    }];

}
+(void)registerWXAppid{
    [WXApi registerApp:WXAPPID];
}

-(void)weixinPayWithMoney:(NSInteger)money
{
    [SVProgressHUD showWithStatus:@"正在微信支付中"];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:@(money) forKey:@"money"];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    [HLLHttpManager postWithURL:URL_wxpay params:dictP success:^(NSDictionary *responseObject) {
        NSArray * arrT = responseObject[@"rows"];
        if (arrT.count>0) {
            NSDictionary * dictT = arrT.firstObject;
            if ([dictT[@"code"] integerValue] == 0) {
                NSString * outTradeNo = dictT[@"outTradeNo"];
                self.outTradeNo = outTradeNo;
                
                NSDictionary *wxResultAPPDic = dictT[@"wxResultAPP"];
                NSMutableString *stamp  = [wxResultAPPDic objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [wxResultAPPDic objectForKey:@"partnerid"];
                req.prepayId            = [wxResultAPPDic objectForKey:@"prepayid"];
                req.nonceStr            = [wxResultAPPDic objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [wxResultAPPDic objectForKey:@"package"];
                req.sign                = [wxResultAPPDic objectForKey:@"sign"];
                
                BOOL success = [WXApi sendReq:req];
                self.payStatus = pay_status_weixin;
                if(!success){
                    NSLog(@"调微信失败");
                    [SVProgressHUD dismiss];
                }
            }else{
                [SVProgressHUD dismiss];
                [SVProgressHUD showToast:@"操作失败"];
            }
        }
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"操作失败"];
    }];
}

-(void)onResp:(BaseResp*)resp{
    self.payStatus = pay_status_none;
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
    
        if (response.errCode == WXSuccess) {
            NSDictionary * response = @{@"result":@"微信支付成功!"};
            NSLog(@"微信支付成功");
            [self verifyWXPay];
         
            
        }else{
            NSLog(@"微信支付失败，retcode=%d",resp.errCode);
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    }
}


-(void)verifyWXPay{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.outTradeNo forKey:@"outTradeNo"];
    [HLLHttpManager postWithURL:URL_payQuerywx params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrT = responseObject[@"rows"];
        if (arrT.count>0) {
            NSDictionary * dictT = arrT.firstObject;
            if ([dictT[@"code"] integerValue] == 0) {
                [SVProgressHUD showToast:@"支付成功"];
            }else{
                [SVProgressHUD showToast:dictT[@"msg"]];
            }
        }
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"网络异常，如若支付请勿重复支付"];
    }];
}

-(void)verifyAliPay{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.randomNo forKey:@"outTradeNo"];
    [HLLHttpManager postWithURL:URL_payQueryzfb params:dictP success:^(NSDictionary *responseObject) {
        
        [SVProgressHUD dismiss];
        NSArray * arrT = responseObject[@"rows"];
        if (arrT.count>0) {
            NSDictionary * dictT = arrT.firstObject;
            if ([dictT[@"code"] integerValue] == 0) {
                [SVProgressHUD showToast:@"支付成功"];
            }else{
                [SVProgressHUD showToast:dictT[@"msg"]];
            }
        }
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"网络异常，如若支付请勿重复支付"];
    }];
}


///重新返回页面时
-(void)ndNotification_DidBecomeActive{
    switch (self.payStatus) {
        case pay_status_none:
        {
            
        }
            break;
        case pay_status_weixin:
        {
            
        }
            break;
        case pay_status_alipay:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end


