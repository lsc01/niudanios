//
//  NDVerifyOrderHeadView.m
//  niudanios
//
//  Created by lsc on 2018/9/6.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDVerifyOrderHeadView.h"

@implementation NDVerifyOrderHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.btnAddAddress.layer.cornerRadius = 4;
    self.btnAddAddress.clipsToBounds = YES;
    self.btnAddAddress.layer.borderColor = HEXCOLOR(0xe5e5e5).CGColor;
    self.btnAddAddress.layer.borderWidth = 1;
    
    self.viewBackgruondNone.hidden = NO;
    self.viewBackground.hidden = YES;
}

- (IBAction)addNewAddressClick:(UIButton *)sender {
}

-(void)setHasAddress:(BOOL)hasAddress{
    _hasAddress = hasAddress;
    if (!hasAddress) {
        self.viewBackgruondNone.hidden = NO;
        self.viewBackground.hidden = YES;
    }else{
        self.viewBackgruondNone.hidden = YES;
        self.viewBackground.hidden = NO;
    }
   
}

@end
