//
//  NDMineFunctionCell.h
//  niudanios
//
//  Created by lsc on 2018/8/24.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDMineFunctionCell : UITableViewCell

@property (nonatomic ,copy) void(^functionSelectedBlock)(NSInteger tag);

-(void)setFunctionSelectedBlock:(void (^)(NSInteger tag))functionSelectedBlock;

@end
