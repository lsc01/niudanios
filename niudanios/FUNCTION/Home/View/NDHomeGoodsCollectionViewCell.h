//
//  NDHomeGoodsCollectionViewCell.h
//  niudanios
//
//  Created by lsc on 2018/8/28.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDGoodsInfoModel.h"
@interface NDHomeGoodsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewGoods;

@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property (weak, nonatomic) IBOutlet UILabel *labelNum;

@property (weak, nonatomic) IBOutlet UILabel *labelOther;
    
@property (nonatomic ,strong) NDGoodsInfoModel * model;
@end
