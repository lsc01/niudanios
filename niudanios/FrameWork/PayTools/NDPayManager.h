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

@interface NDPayManager : NSObject
// NOTE: 订单总金额，单位为元，精确到小数点后两位，取值范围[0.01,100000000]
+(void)aliPayWithMoney:(CGFloat)money;
+(void)weixinPayWithMoney:(NSInteger)money;
@end
