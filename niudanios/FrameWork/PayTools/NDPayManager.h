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
+(void)aliPay;
+(void)wxPay;
@end
