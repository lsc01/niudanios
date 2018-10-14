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
#import "NDPayManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [NDPayManager registerWXAppid];
    
    [self IQKeyboardManagerInit];
    [self SVProgressHUDInit];
    [self AFNetWorkingInit];
    [self ADShareSDKInit];
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
                                         default:
                                             break;
                                     }
                                 }onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
             
                                     switch (platformType)
                                     {
                                         case SSDKPlatformTypeWechat:
                                             [appInfo SSDKSetupWeChatByAppId:@"wx100ef5fc5d46c202"
                                                                   appSecret:@"c917a079bfff60f28242c072639008f0"];
                                             break;
                                         case SSDKPlatformTypeQQ:
                                             [appInfo SSDKSetupQQByAppId:@"101505995"
                                                                  appKey:@"e0e16fc558026b8650a4f4927c36ef81"
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_DidBecomeActive" object:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[NDPayManager sharedManager] processOrderWithPaymentResult:url];

    }else if([url.absoluteString hasPrefix:WXAPPID]){
        if([url.host isEqualToString:@"pay"]){
            return  [WXApi handleOpenURL:url delegate:[NDPayManager sharedManager]];
        }
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    NSLog(@"url:%@",url);
    NSLog(@"url.host:%@",url.absoluteString);
    if ([url.host isEqualToString:@"safepay"]) {
        [[NDPayManager sharedManager] processOrderWithPaymentResult:url];
    }else if([url.absoluteString hasPrefix:WXAPPID]){
        if([url.host isEqualToString:@"pay"]){
          return  [WXApi handleOpenURL:url delegate:[NDPayManager sharedManager]];
        }
    }
    return YES;
}

@end
