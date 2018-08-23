//
//  HLLByteTransform.m
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/7/23.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import "HLLByteTransform.h"

@implementation HLLByteTransform
+ (NSString*)stringWithbytes:(long long)bytes{
    
    if (bytes < 1024) // B
        
    {
        
        return [NSString stringWithFormat:@"%dB", (int)bytes];
        
    }
    
    else if (bytes >= 1024 && bytes < 1024 * 1024) // KB
        
    {
        
        return [NSString stringWithFormat:@"%.1fKB", (double)bytes / 1024];
        
    }
    
    else if (bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024) // MB
        
    {
        
        return [NSString stringWithFormat:@"%.1fMB", (double)bytes / (1024 * 1024)];
        
    }
    
    else // GB
        
    {
        
        return [NSString stringWithFormat:@"%.1fGB", (double)bytes / (1024 * 1024 * 1024)];
        
    }
    
}
@end
