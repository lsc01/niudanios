//
//  NDNiudanPriceFilterModel.h
//  niudanios
//
//  Created by lsc on 2018/9/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDNiudanPriceFilterModel : NSObject
@property (nonatomic ,copy) NSString * Id;
@property (nonatomic ,copy) NSString * name;
@property (nonatomic ,copy) NSString * flag;

@property (nonatomic ,strong) NSNumber * minMoney;
@property (nonatomic ,strong) NSNumber * maxMoney;

@end
