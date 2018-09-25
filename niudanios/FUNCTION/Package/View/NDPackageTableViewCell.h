//
//  NDPackageTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/9/4.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDPackageGoodsModel.h"
@interface NDPackageTableViewCell : UITableViewCell
@property (nonatomic ,strong) NDPackageGoodsModel * model;

- (IBAction)selectBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewGoods;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@property (nonatomic ,copy) void(^SelectGoodsBlock)(BOOL selected,NDPackageGoodsModel * goodsModel);


@end
