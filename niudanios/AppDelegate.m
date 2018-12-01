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

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

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
    [self setJPushwithLaunchingWithOptions:launchOptions];
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

-(void)setJPushwithLaunchingWithOptions:(NSDictionary *)launchOptions{
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    // 如需继续使用 pushConfig.plist 文件声明 appKey 等配置内容，请依旧使用 [JPUSHService setupWithOption:launchOptions] 方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"827287a40715554140146e36"
                          channel:@"App Store"
                 apsForProduction:YES];
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate
// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
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
