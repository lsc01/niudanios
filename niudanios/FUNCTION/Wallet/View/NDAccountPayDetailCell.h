//
//  NDAccountPayDetailCell.h
//  niudanios
//
//  Created by lsc on 2018/9/3.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDMyWalletRecordModel.h"

typedef NS_ENUM(NSInteger,AccountPayDetailType) {
    AccountPayDetailType1 = 1,
    AccountPayDetailType2 = 2,
    AccountPayDetailType3 = 3,
    AccountPayDetailType4 = 4,
    
};

@interface NDAccountPayDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelDes;
@property (weak, nonatomic) IBOutlet UILabel *labelAdd;
@property (weak, nonatomic) IBOutlet UILabel *labelResidue;
@property (weak, nonatomic) IBOutlet UILabel *labelDay;

@property (weak, nonatomic) IBOutlet UIView *viewLIne;

@property (nonatomic ,assign) AccountPayDetailType accountPayDetailType;

@property (nonatomic ,strong) NDMyWalletRecordModel * model;
@end
