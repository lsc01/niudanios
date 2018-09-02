//
//  NDMineOrderSelectView.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineOrderSelectView.h"

@implementation NDMineOrderSelectView

-(void)awakeFromNib{
    [super awakeFromNib];

}
- (IBAction)btnSelectClick:(UIButton *)sender {
    if (sender == self.btnCurr) {
        return;
    }
    self.btnCurr.selected = NO;
    self.btnCurr = sender;
    self.btnCurr.selected = YES;
    CGPoint center = self.viewLine.center;
    center.x = sender.center.x;
    [UIView animateWithDuration:0.3 animations:^{
        self.viewLine.center = center;
    }];
}

-(void)setSelectNormalWithTag:(NSInteger)tag{
    if (tag == 0) {
        self.btnCurr = self.btn1;
        [self btnSelectClick:self.btn1];
    }else if (tag == 1){
        self.btnCurr = self.btn2;
        [self btnSelectClick:self.btn2];
    }else if (tag == 2){
        self.btnCurr = self.btn3;
        [self btnSelectClick:self.btn3];
    }else if (tag == 3){
        self.btnCurr = self.btn4;
        [self btnSelectClick:self.btn4];
    }
}
@end
