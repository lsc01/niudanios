
//
//  NDPostOtherRequestManager.m
//  niudanios
//
//  Created by lsc on 2018/12/10.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDPostOtherRequestManager.h"

@implementation NDPostOtherRequestManager
+(void)recordAPPLaunchCount{
    NSString * stringId = @"-1";
    if ([HLLShareManager shareMannager].userModel) {
        stringId = [HLLShareManager shareMannager].userModel.Id;
    }
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:stringId forKey:@"custId"];
    
    [HLLHttpManager postWithURL:URL_loginRecordAppend params:dictP success:^(NSDictionary *responseObject) {
        NSLog(@"启动次数记录成功");
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        NSLog(@"启动次数记录失败");
    }];
    
}


+(void)recordBrowseCountWithGashaponId:(NSString *)gashaponId{
    NSString * stringId = @"-1";
    if ([HLLShareManager shareMannager].userModel) {
        stringId = [HLLShareManager shareMannager].userModel.Id;
    }
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:stringId forKey:@"custId"];
    [dictP setObject:gashaponId forKey:@"gashaponId"];
    
    [HLLHttpManager postWithURL:URL_browseRecord params:dictP success:^(NSDictionary *responseObject) {
        NSLog(@"浏览次数记录成功");
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        NSLog(@"浏览次数记录失败");
    }];
}
@end
