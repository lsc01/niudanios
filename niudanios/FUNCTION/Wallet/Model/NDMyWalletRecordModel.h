//
//  NDMyWalletRecordModel.h
//  niudanios
//
//  Created by lsc on 2018/9/28.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDMyWalletRecordModel : NSObject
@property (nonatomic ,copy) NSString * Id;
@property (nonatomic ,copy) NSNumber * balance;
@property (nonatomic ,copy) NSString * createTime;
@property (nonatomic ,copy) NSString * customerId;
@property (nonatomic ,copy) NSString * version;
@property (nonatomic ,copy) NSString * status;

@end
