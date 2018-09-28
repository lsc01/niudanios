//
//  AppDelegate.m
//  niudanios
//
//  Created by lsc on 2018/8/22.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import <AFNetworking.h>
#import "NDBaseTabBarController.h"
#import "ShareSDKHeader.h"
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    [self IQKeyboardManagerInit];
    [self SVProgressHUDInit];
    [self AFNetWorkingInit];
    
    [NSURL URLWithString:@"www.baidu.com"];
    
    NDBaseTabBarController * tab = [[NDBaseTabBarController alloc] init];
    self.window.rootViewController = tab;


    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark  - KeyBoardInit
-(void)IQKeyboardManagerInit
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
}

#pragma mark  - SVProgressHUD
-(void)SVProgressHUDInit{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8f]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMaximumDismissTimeInterval:2.0f];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:15.0]];
}

#pragma mark  - AFNetWorkingInit
-(void)AFNetWorkingInit
{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    //网络状态监测
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [[HLLShareManager shareMannager] setNetworkStatus:status];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NETSTATUS_CHANGE object:nil userInfo:@{@"status":@(status)}];
       
    }];
}

#pragma mark  - ShareSDKInit
- (void)ADShareSDKInit {
        /**初始化ShareSDK应用
         
         @param activePlatforms
         使用的分享平台集合
         @param importHandler (onImport)
         导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
         @param configurationHandler (onConfiguration)
         配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
         */
        [ShareSDK registerActivePlatforms:@[
                                            @(SSDKPlatformTypeSinaWeibo),
                                            @(SSDKPlatformTypeWechat),
                                            @(SSDKPlatformTypeQQ)
                                            ]
                                 onImport:^(SSDKPlatformType platformType){
                                     switch (platformType)
                                     {
                                         case SSDKPlatformTypeWechat:
                                             [ShareSDKConnector connectWeChat:[WXApi class]];
                                             break;
                                         case SSDKPlatformTypeQQ:
                                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                             break;
                                         case SSDKPlatformTypeSinaWeibo:
                                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                             break;
                                         default:
                                             break;
                                     }
                                 }onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
             
                                     switch (platformType)
                                     {
                                         case SSDKPlatformTypeSinaWeibo:
                                             //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                             [appInfo SSDKSetupSinaWeiboByAppKey:@"3974139300"
                                                                       appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                                                     redirectUri:@"http://www.sharesdk.cn"
                                                                        authType:SSDKAuthTypeBoth];
                                             break;
                                         case SSDKPlatformTypeWechat:
                                             [appInfo SSDKSetupWeChatByAppId:@"wxe8bb4cd46e4b1142"
                                                                   appSecret:@"55c7fe18f6746b378e57b3d29e93fbed"];
                                             break;
                                         case SSDKPlatformTypeQQ:
                                             [appInfo SSDKSetupQQByAppId:@"1106085747"
                                                                  appKey:@"UxwQQvm3ynHG8o7v"
                                                                authType:SSDKAuthTypeBoth];
                                             break;
                                    
                                         default:
                                               break;
                                     }
                                    }];
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
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
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
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
    return YES;
}

@end
