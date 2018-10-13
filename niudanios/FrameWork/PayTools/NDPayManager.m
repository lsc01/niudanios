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

@end
@implementation NDPayManager
// NOTE: 订单总金额，单位为元，精确到小数点后两位，取值范围[0.01,100000000]
+(void)aliPayWithMoney:(CGFloat)money{
    
    [SVProgressHUD show];
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
                
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:result fromScheme:@"ali2018090761292663" callback:^(NSDictionary *resultDic) {
                    NSLog(@"alipay reslut = %@",resultDic);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                }];
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

+(void)weixinPayWithMoney:(NSInteger)money
{
    
    [SVProgressHUD show];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:@(money) forKey:@"money"];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    [HLLHttpManager postWithURL:URL_wxpay params:dictP success:^(NSDictionary *responseObject) {
        NSArray * arrT = responseObject[@"rows"];
        if (arrT.count>0) {
            NSDictionary * dictT = arrT.firstObject;
            if ([dictT[@"code"] integerValue] == 0) {
                NSString * outTradeNo = dictT[@"outTradeNo"];
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
                
                [WXApi registerApp:[wxResultAPPDic objectForKey:@"appid"]];
                BOOL success = [WXApi sendReq:req];
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
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
    
        if (response.errCode == WXSuccess) {
            NSDictionary * response = @{@"result":@"微信支付成功!"};
            NSLog(@"微信支付成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
        }else{
            NSLog(@"微信支付失败，retcode=%d",resp.errCode);
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    }
}

@end


