//
//  HLLHttpManager.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLHttpManager : NSObject

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError * error ,NSInteger errCode,NSString * errMsg))failure;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError * error ,NSInteger errCode,NSString * errMsg))failure;

/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formDataArray  文件参数
 *  @param progress  进度回调
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)uploadWithURL:(NSString *)url params:(NSDictionary *)params progress:(void (^)(id uploadProgress))progress formDataArray:(NSArray *)formDataArray success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError * error ,NSInteger errCode,NSString * errMsg))failure;

///保存登录的信息
+(void)savaLoginInfoWithDict:(NSDictionary *)dictInfo;
+(NSString *)getToken;
+(void)removeAllLoginInfo;
@end
