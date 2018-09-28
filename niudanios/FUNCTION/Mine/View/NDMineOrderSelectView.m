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
    self.btn1.tag = 2220;
    self.btn2.tag = 2221;
    self.btn3.tag = 2222;
    self.btn4.tag = 2223;
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
    
    _selectBtnStatusBlock?_selectBtnStatusBlock(sender.tag-2220):nil;
}

-(void)setSelectNormalWithTag:(NSInteger)tag{
    if (tag == 0) {
        
        [self btnSelectClick:self.btn1];
    }else if (tag == 1){
        
        [self btnSelectClick:self.btn2];
    }else if (tag == 2){
        
        [self btnSelectClick:self.btn3];
    }else if (tag == 3){
        
        [self btnSelectClick:self.btn4];
    }
}
@end
