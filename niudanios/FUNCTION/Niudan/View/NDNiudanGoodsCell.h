//
//  NDNiudanGoodsCell.h
//  niudanios
//
//  Created by lsc on 2018/8/30.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDGoodsInfoModel.h"
@interface NDNiudanGoodsCell : UICollectionViewCell

@property (nonatomic ,strong) NDGoodsInfoModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewGoods;
@property (weak, nonatomic) IBOutlet UILabel *labelGoodsName;

@property (weak, nonatomic) IBOutlet UILabel *labelGoodsNum;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;

@property (weak, nonatomic) IBOutlet UIButton *btnCollect;
- (IBAction)collectBtnClick:(UIButton *)sender;

@property (nonatomic ,copy) void (^collectGoodsBlock)(NSString * gashaponMachineId ,BOOL isCollect);
@end
