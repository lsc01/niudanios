//
//  NDHomeNewMessageModel.h
//  niudanios
//
//  Created by lsc on 2018/9/21.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDHomeNewMessageModel : NSObject
@property (nonatomic ,assign) NSInteger Id;

@property (nonatomic ,copy) NSString * createTime;

@property (nonatomic ,copy) NSString * twistedName;

@property (nonatomic ,copy) NSString * typeName;

@property (nonatomic ,copy) NSString * userName;
@end
