//
//  NDHomeLikeCell.h
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDGoodsInfoModel.h"
@interface NDHomeLikeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellViewBg;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewGoods;

@property (weak, nonatomic) IBOutlet UILabel *labelDes;

@property (weak, nonatomic) IBOutlet UILabel *labelNum;
    
@property (nonatomic ,strong) NDGoodsInfoModel * model;


@end
