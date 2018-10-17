//
//  NDHomeGoodsCell.h
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDHomeGoodsCell : UITableViewCell
    
    
    @property (nonatomic ,strong) NSArray * arrCellModel;
@property (nonatomic ,copy) void(^selectItemBlock)(NSInteger index);
-(void)setSelectItemBlock:(void (^)(NSInteger index))selectItemBlock;
@end
