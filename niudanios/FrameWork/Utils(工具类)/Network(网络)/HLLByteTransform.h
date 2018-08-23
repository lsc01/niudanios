//
//  HLLByteTransform.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/7/23.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLByteTransform : NSObject
///字节转为字符串  KB MB GB
+ (NSString*)stringWithbytes:(long long)bytes;
@end
