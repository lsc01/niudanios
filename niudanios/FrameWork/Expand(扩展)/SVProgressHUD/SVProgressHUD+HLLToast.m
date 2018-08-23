//
//  SVProgressHUD+HLLToast.m
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/28.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import "SVProgressHUD+HLLToast.h"

@implementation SVProgressHUD (HLLToast)
+(void)showToast:(NSString *)stringInfo{
    [SVProgressHUD showImage:nil status:stringInfo];
}
@end
