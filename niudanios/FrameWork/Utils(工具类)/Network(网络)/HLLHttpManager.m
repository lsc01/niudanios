//
//  HLLHttpManager.m
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import "HLLHttpManager.h"
#import "AFNetworking.h"
#import "HLLFormData.h"
#import "HLLPhoneModel.h"

typedef NS_ENUM(NSInteger , RequsetType) {
    kPOST = 0,
    kGET = 1,
    kUploadFile = 2
};

@implementation HLLHttpManager

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError * error ,NSInteger errCode,NSString * errMsg))failure
{
    
    AFHTTPSessionManager *mgr = [HLLHttpManager shareManager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableDictionary * dictParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    [dictParams setObject:[HLLPhoneModel getUUIDString] forKey:@"deviceId"];
    
    [mgr POST:url parameters:dictParams progress:^(NSProgress * _Nonnull uploadProgress) {
//        progress?progress(uploadProgress):nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSData * data = (NSData *)responseObject;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"url:%@ ---- \nresponseObject：%@",url,dict);
            if ([dict[@"code"] integerValue] == 200) {
                success?success(dict):nil;
            }else{
                failure?failure(nil,[dict[@"code"] integerValue],dict[@"msg"]):nil;
                HLLLog(@"HTTP-请求失败- error:x errCode:%d errMsg:%@\n url:%@ -- params:%@",[dict[@"code"] integerValue],dict[@"msg"],url,dictParams);
            }
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            failure?failure(error,0,nil):nil;
            HLLLog(@"HTTP-请求失败- error:%@  errCode:x errMsg:x\n url:%@ -- params:%@",error,url,params);
        });
    }];
}

#pragma mark - get请求
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError * error ,NSInteger errCode,NSString * errMsg))failure{
    
    AFHTTPSessionManager *mgr = [HLLHttpManager shareManager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableDictionary * dictParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    [dictParams setObject:[HLLPhoneModel getUUIDString] forKey:@"deviceId"];
    [mgr GET:url parameters:dictParams progress:^(NSProgress * _Nonnull downloadProgress) {
//        progress?progress(downloadProgress):nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSData * data = (NSData *)responseObject;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([dict[@"code"] integerValue] == 200) {
                success?success(dict):nil;
            }else{
                failure?failure(nil,[dict[@"code"] integerValue],dict[@"msg"]):nil;
                HLLLog(@"HTTP-请求失败- error:x errCode:%d errMsg:%@\n url:%@ -- params:%@",[dict[@"code"] integerValue],dict[@"msg"],url,params);
            }
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            failure?failure(error,0,nil):nil;
            HLLLog(@"HTTP-请求失败- error:%@  errCode:x errMsg:x\n url:%@ -- params:%@",error,url,dictParams);
        });
    }];
}


#pragma mark  - 上传文件
+ (void)uploadWithURL:(NSString *)url params:(NSDictionary *)params progress:(void (^)(id uploadProgress))progress formDataArray:(NSArray *)formDataArray success:(void (^)(NSDictionary * responseObject))success failure:(void (^)(NSError * error ,NSInteger errCode,NSString * errMsg))failure{
    
    
    AFHTTPSessionManager *mgr = [HLLHttpManager shareManager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableDictionary * dictParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    [dictParams setObject:[HLLPhoneModel getUUIDString] forKey:@"deviceId"];
    [mgr POST:url parameters:dictParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        for(HLLFormData *formData in formDataArray){
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress?progress(uploadProgress):nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSData * data = (NSData *)responseObject;
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([dict[@"code"] integerValue] == 200) {
                success?success(dict):nil;
            }else{
                failure?failure(nil,[dict[@"code"] integerValue],dict[@"msg"]):nil;
               
            }
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            failure?failure(error,0,nil):nil;
            HLLLog(@"HTTP-请求失败- error:%@  errCode:x errMsg:x\n url:%@ -- params:%@",error,url,dictParams);
        });
    }];
}

+ (AFHTTPSessionManager *)shareManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSSet *acceptableContentTypes = manager.responseSerializer.acceptableContentTypes;
    NSMutableSet *mutableContentTypes = [[NSMutableSet alloc] initWithSet:acceptableContentTypes];
    [mutableContentTypes addObject:@"text/plain"];
    [mutableContentTypes addObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithSet:mutableContentTypes];
    // 设置超时时间，写在上面不起作用，要写在[AFHTTPRequestSerializer serializer]后
    manager.requestSerializer.timeoutInterval = 10.f;
    
    
    return manager;
}




@end
