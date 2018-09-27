//
//  NDPackageGoodsModel.h
//  niudanios
//
//  Created by lsc on 2018/9/25.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDPackageGoodsModel : NSObject

@property (nonatomic ,copy) NSString * Id;
@property (nonatomic ,copy) NSString * customerId;
@property (nonatomic ,copy) NSString * gashaponImg;
@property (nonatomic ,strong) NSNumber * createTime;
@property (nonatomic ,strong) NSNumber * currentTime;
@property (nonatomic ,strong) NSNumber * createMaturity;
@property (nonatomic ,copy) NSString * gashaponName;
@property (nonatomic ,copy) NSString * describe;

@property (nonatomic ,assign) NSInteger flag;
@property (nonatomic ,assign) CGFloat gashaponPrice;//扭蛋价格
@property (nonatomic ,assign) CGFloat machinePrice;//扭蛋机价格
@end
