//
//  NDBindPhoneViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBindPhoneViewController.h"

@interface NDBindPhoneViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewInputBg;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMsg;

@property (weak, nonatomic) IBOutlet UIButton *btnGetCode;


@property (weak, nonatomic) IBOutlet UIButton *btnBindPhone;
@end

@implementation NDBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


    self.title = @"绑定手机";
    
    [self setUI];
}

-(void)setUI{
    self.viewInputBg.layer.cornerRadius = 4;
    self.viewInputBg.clipsToBounds = YES;
    
    
    self.btnBindPhone.layer.cornerRadius = 4;
    self.btnBindPhone.clipsToBounds = YES;
}

- (IBAction)bindPhoneClick:(id)sender {
}

- (IBAction)getCodeClick:(id)sender {
}

@end
