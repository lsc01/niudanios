//
//  HLLShareManager.m
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import "HLLShareManager.h"
#import "SAMKeychain.h"
#import "BSELocationTool.h"
@implementation HLLShareManager
static HLLShareManager *share = nil;
+(instancetype)shareMannager
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[HLLShareManager alloc]init];
        share.NetworkStatus = AFNetworkReachabilityStatusUnknown;

    });
    return share;
}

-(NDUserInfoModel *)userModel{
    if (_userModel) {
        return _userModel;
    }else{
//        NSData * data = [SAMKeychain passwordDataForService:sevodadacnuizcnas account:acdadaddacnuizcnas];
        NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:acdadaddacnuizcnas];
        if (data==nil) {
            return nil;
        }
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        share.userModel = [NDUserInfoModel mj_objectWithKeyValues:dict];
        return share.userModel;
    }
}

-(void)setCurrLocation:(CLLocation *)currLocation{
    _currLocation = currLocation;
    [BSELocationTool TransCLLocationTo:currLocation City:^(NSString *city) {
        NSLog(@"city:%@",city);
    } Location:^(NSString *location) {
        NSLog(@"location:%@",location);
        self.currLocationInfo = location;
    } Coordinate:^(CLLocationCoordinate2D Coordinate) {
        NSLog(@"Coordinate:lat:%lf,lon:%lf",Coordinate.latitude,Coordinate.longitude);
    }];
}


@end
