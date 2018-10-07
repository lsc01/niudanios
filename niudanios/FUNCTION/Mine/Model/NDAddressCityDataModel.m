//
//  NDAddressCityDataModel.m
//  niudanios
//
//  Created by lsc on 2018/10/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDAddressCityDataModel.h"


@implementation NDAddressProvinceDataModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"city": @"NDAddressCityDataModel"};
}
@end
@implementation NDAddressCityDataModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"area": @"NDAddressAreaDataModel"};
}
@end

@implementation NDAddressAreaDataModel

@end
