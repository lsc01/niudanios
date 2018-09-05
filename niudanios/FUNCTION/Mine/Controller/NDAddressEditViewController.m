//
//  NDAddressEditViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDAddressEditViewController.h"

@interface NDAddressEditViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldPerson;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UITextView *textAddressDetail;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@end

@implementation NDAddressEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textAddressDetail.text = @"请填写详细地址    ";
    self.textAddressDetail.textColor = HEXCOLOR(0xaaaaaa);
    self.textAddressDetail.delegate = self;
    self.textAddressDetail.layer.cornerRadius = 4;
    self.textAddressDetail.clipsToBounds = YES;
    
    self.btnSave.layer.cornerRadius = 4;
    self.btnSave.clipsToBounds = YES;
}
- (IBAction)saveBtnClick:(UIButton *)sender {
}
- (IBAction)selectAddressClick:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请填写详细地址    "]) {
        textView.text = @"";
        self.textAddressDetail.textColor = HEXCOLOR(0x222222);
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text length]<1) {
        textView.text = @"请填写详细地址    ";
        self.textAddressDetail.textColor = HEXCOLOR(0xaaaaaa);
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    NSInteger maxCount = 200;
    if (textView.text.length > maxCount) {
        NSString * strTemp = [textView.text substringWithRange:NSMakeRange(0,maxCount)];
        textView.text = strTemp;
    }
}

@end
