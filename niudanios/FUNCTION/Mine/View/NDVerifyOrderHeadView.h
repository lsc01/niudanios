//
//  NDVerifyOrderHeadView.h
//  niudanios
//
//  Created by lsc on 2018/9/6.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDVerifyOrderHeadView : UIView


@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *lablePhone;


@property (weak, nonatomic) IBOutlet UIView *viewBackgruondNone;
@property (weak, nonatomic) IBOutlet UIButton *btnAddAddress;


@property (nonatomic ,assign ,getter=isHasAddress) BOOL hasAddress;

@end
