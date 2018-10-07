//
//  NDOrderDetailInfoModel.m
//  niudanios
//
//  Created by lsc on 2018/10/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDOrderDetailInfoModel.h"

@implementation NDOrderDetailInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id": @"id"};
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"logisticsDataArray": @"NDLogisticsInfoModel"};
}

@end

@implementation NDLogisticsInfoModel

@end

