//
//  NDMineOrderSelectView.h
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDMineOrderSelectView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIView *viewLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewLineConstraint;

-(void)setSelectNormalWithTag:(NSInteger)tag;


@property (nonatomic ,strong)UIButton * btnCurr;


@property (nonatomic ,copy) void(^selectBtnStatusBlock)(NSInteger tag);
@end
