//
//  NDPayManager.h
//  niudanios
//
//  Created by lsc on 2018/9/16.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

#define WXAPPID @"wx100ef5fc5d46c202"
#define Alipay_scheme @"ali2018090761292663"


typedef NS_ENUM(NSInteger,PAY_STATUS) {
    pay_status_none = 0,
    pay_status_alipay = 1,
    pay_status_weixin = 2,
};

@interface NDPayManager : NSObject<WXApiDelegate>
+ (instancetype)sharedManager;
+(void)registerWXAppid;
// NOTE: 订单总金额，单位为元，精确到小数点后两位，取值范围[0.01,100000000]
-(void)aliPayWithMoney:(NSInteger)money;
-(void)weixinPayWithMoney:(NSInteger)money;

-(void)processOrderWithPaymentResult:(NSURL *)url;

@property (nonatomic , assign ) PAY_STATUS payStatus;
@end
