//
//  NDAddressEditViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDAddressEditViewController.h"
#import "NDAddressPickerView2.h"
#import "HLLVerifyTools.h"

#import "NDAddressCityDataModel.h"
@interface NDAddressEditViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldPerson;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UITextView *textAddressDetail;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (nonatomic ,strong) NSArray * arrData;
@property (nonatomic ,strong) NSArray * selectIdArr;
@end

@implementation NDAddressEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"编辑收货地址";
    
    self.textAddressDetail.text = @"请填写详细地址    ";
    self.textAddressDetail.textColor = HEXCOLOR(0xaaaaaa);
    self.textAddressDetail.delegate = self;
    self.textAddressDetail.layer.cornerRadius = 4;
    self.textAddressDetail.clipsToBounds = YES;
    
    self.btnSave.layer.cornerRadius = 4;
    self.btnSave.clipsToBounds = YES;
    
    
    
    self.textFieldPerson.text = self.modelAddress.recipientName;
    self.textFieldPhone.text = self.modelAddress.moblie;
    if (self.modelAddress.provinceId) {
        self.labelAddress.text = [NSString stringWithFormat:@"%@%@%@",self.modelAddress.provinceName,self.modelAddress.cityName,self.modelAddress.areaName];
        self.selectIdArr = @[self.modelAddress.provinceId,self.modelAddress.cityId,self.modelAddress.areaId];
    }
    self.textAddressDetail.text = self.modelAddress.detail;
    
    
}
- (IBAction)saveBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (self.textFieldPerson.text.length<1) {
        [SVProgressHUD showToast:@"请输入名字"];
        return;
    }
    
    if (![HLLVerifyTools hllVerifyMobile:self.textFieldPhone.text]) {
        [SVProgressHUD showToast:@"手机号格式错误"];
        return;
    }
    
    if([self.labelAddress.text isEqualToString:@"请选择"]){
        [SVProgressHUD showToast:@"请选择收货地址"];
        return;
    }
    
    if([self.textAddressDetail.text isEqualToString:@"请填写详细地址    "]){
        [SVProgressHUD showToast:@"请填写详细地址"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.textFieldPhone.text forKey:@"moblie"];
    [dictP setObject:self.textFieldPerson.text forKey:@"recipientName"];
    [dictP setObject:self.selectIdArr[1] forKey:@"cityId"];
    [dictP setObject:self.selectIdArr[0] forKey:@"provinceId"];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    [dictP setObject:self.textAddressDetail.text forKey:@"detail"];
    [dictP setObject:self.selectIdArr[2] forKey:@"areaId"];
    
    NSString * url = URL_ShippingAddressadd;
    if (self.modelAddress.Id) {
        [dictP setObject:self.modelAddress.Id forKey:@"id"];
        url = URL_ShippingAddressmodify;
    }
    
    [HLLHttpManager postWithURL:url params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        if (self.modelAddress.Id) {
            [SVProgressHUD showToast:@"修改成功"];
        }else{
            [SVProgressHUD showToast:@"添加成功"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(addNewAddrSuccess)]) {
                [self.delegate addNewAddrSuccess];
            }
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        if (self.modelAddress.Id) {
            [SVProgressHUD showToast:@"修改失败"];
        }else{
            [SVProgressHUD showToast:@"添加失败"];
        }
    }];
    
}
- (IBAction)selectAddressClick:(UIButton *)sender {
    [self.view endEditing:YES];
    WeakSelf();
    if (self.arrData) {
        [NDAddressPickerView2 showAddressPickerWithDefaultSelected:@[@0,@0,@0] andArrData:self.arrData isAutoSelect:NO resultBlock:^(NSArray *selectAddressArr, NSArray *selectIdArr) {
            StrongSelf();
            strongself.labelAddress.text = [NSString stringWithFormat:@"%@%@%@",selectAddressArr[0],selectAddressArr[1],selectAddressArr[2]];
            strongself.selectIdArr = [selectIdArr copy];
        }];
        return;
    }
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_selectProvince params:nil success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
    
        self.arrData = [NDAddressProvinceDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]];
        [NDAddressPickerView2 showAddressPickerWithDefaultSelected:@[@0,@0,@0] andArrData:self.arrData isAutoSelect:NO resultBlock:^(NSArray *selectAddressArr, NSArray *selectIdArr) {
            StrongSelf();
            strongself.labelAddress.text = [NSString stringWithFormat:@"%@%@%@",selectAddressArr[0],selectAddressArr[1],selectAddressArr[2]];
            strongself.selectIdArr = [selectIdArr copy];
        }];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"查询地址失败，请重试"];
    }];
    
    
    
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
