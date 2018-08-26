//
//  NDUpdatePhoneViewController.m
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDUpdatePhoneViewController.h"

@interface NDUpdatePhoneViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewBg1;
@property (weak, nonatomic) IBOutlet UIView *viewBg2;
@property (weak, nonatomic) IBOutlet UILabel *labelBindPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCode;
@property (weak, nonatomic) IBOutlet UIButton *btnCode;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNewPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelTips;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@end

@implementation NDUpdatePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改手机号";
    
    [self setUI];
}

-(void)setUI{
    self.viewBg1.layer.cornerRadius = 4;
    self.viewBg1.layer.masksToBounds = YES;
    self.viewBg2.layer.cornerRadius = 4;
    self.viewBg2.layer.masksToBounds = YES;
    self.btnSubmit.layer.cornerRadius = 4;
    self.btnSubmit.layer.masksToBounds = YES;
//    self.labelTips.hidden = YES;
}
- (IBAction)getCodeBtnClick:(UIButton *)sender {
}
- (IBAction)submitClick:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
