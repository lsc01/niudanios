//
//  NDMIneDataViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMIneDataViewController.h"
#import "NDMineDataCell.h"
#import "NDMineDataHeaderView.h"
#import "NDUpdatePhoneViewController.h"
#import "BRDatePickerView.h"
#import "NDSexSelectView.h"
#import "SAMKeychain.h"

@interface NDMIneDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NDMineDataHeaderView * headView;

@property (nonatomic ,strong) UIView * viewFooter;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation NDMIneDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"账号资料";
    [self setUI];
}


-(void)setUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 10.0f;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.viewFooter;
    self.tableView.bounces = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineDataCell" bundle:nil] forCellReuseIdentifier:@"NDMineDataCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.headView.imageViewHead sd_setImageWithURL:[NSURL URLWithString:HTTP([HLLShareManager shareMannager].userModel.headPortrait?:@"")] placeholderImage:[UIImage imageNamed:@"head_placehold"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"error:%@",error);
    }];
 
}

-(void)saveBtnClick{
    
    
    NDMineDataCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString * stringName = cell.textFieldName.text;
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString * stringSex = cell.btnSelect.titleLabel.text;
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString * birth = cell.btnSelect.titleLabel.text;
    if ([birth isEqualToString:@"请选择"]) {
        [SVProgressHUD showToast:@"请选择出生日期"];
        return;
    }
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:birth forKey:@"Strdate"];
    [dictP setObject:@"18907350967"?:[HLLShareManager shareMannager].userModel.loginMobile forKey:@"loginMobile"];
    [dictP setObject:[stringSex isEqualToString:@"男"]?@(1):@(0) forKey:@"sex"];
    [dictP setObject:stringName forKey:@"nickName"];
//    [dictP setObject:@"这传头像" forKey:@"portrait"];
    
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_updateCustomerInfo params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        
        
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count > 0) {
            NSDictionary * dict = arrRows.firstObject;
            if ([dict[@"code"] integerValue] == 0) {
                [HLLShareManager shareMannager].userModel.birthdayTime = birth;
                [HLLShareManager shareMannager].userModel.sex = [stringSex isEqualToString:@"男"]?@"1":@"0";
                [HLLShareManager shareMannager].userModel.nickName = stringName;
                
                NSDictionary * dictT = [[HLLShareManager shareMannager].userModel mj_keyValues];
                NSData * data = [NSJSONSerialization dataWithJSONObject:dictT options:0 error:nil];
                [SAMKeychain setPasswordData:data forService:sevodadacnuizcnas account:acdadaddacnuizcnas];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([self.delegate respondsToSelector:@selector(updateDataInfoSuccess)]) {
                        [self.delegate updateDataInfoSuccess];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }
            [SVProgressHUD showToast:dict[@"msg"]];
        }
        
        
        
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"修改失败"];
        
    }];
    
    
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 3;
    }else{
        return 0;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NDMineDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineDataCell"  forIndexPath:indexPath];
        cell.viewLine.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textFieldName.hidden = YES;
        cell.btnSelect.hidden = NO;
        
        if (indexPath.row == 0) {
            cell.btnSelect.enabled = NO;

            cell.textFieldName.text = [HLLShareManager shareMannager].userModel.nickName;
            cell.textFieldName.hidden = NO;
            cell.btnSelect.hidden = YES;
            cell.labelTitle.text = @"昵称";
        }else if (indexPath.row == 1){
            cell.btnSelect.enabled = YES;
            
            [cell.btnSelect setTitle:[[HLLShareManager shareMannager].userModel.sex isEqualToString:@"1"]?@"男":@"女" forState:UIControlStateNormal];
            cell.labelTitle.text = @"性别";
           
        }else if (indexPath.row == 2){
            cell.viewLine.hidden = YES;
            cell.btnSelect.enabled = YES;
            
            NSArray * arrayT = [[HLLShareManager shareMannager].userModel.birthdayTime componentsSeparatedByString:@" "];
            if (arrayT.count>0) {
                NSString * Birth = arrayT.firstObject;
                [cell.btnSelect setTitle:Birth forState:UIControlStateNormal];
            }
            cell.labelTitle.text = @"出生年月";
            
        }
        [cell setSelectBtnBlock:^(UIButton *btnSelect) {
            if (indexPath.row == 1) {
                [NDSexSelectView showSexResultBlock:^(NSString *selectValue) {
                    [btnSelect setTitle:selectValue forState:UIControlStateNormal];
                }];
                
            }else if (indexPath.row == 2){
                [BRDatePickerView showDatePickerWithTitle:@"" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:@"" maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue,NSDate * selectDate) {
                    [btnSelect setTitle:selectValue forState:UIControlStateNormal];
                }];
            }
            
            
        }];
        
        
        
        return cell;
    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




-(NDMineDataHeaderView *)headView{
    if(_headView == nil){
        _headView = [[NSBundle mainBundle] loadNibNamed:@"NDMineDataHeaderView" owner:self options:nil].firstObject;
        _headView.frame = CGRectMake(0, 0, kScreenWidth, 74);
        _headView.backgroundColor = [UIColor whiteColor];
        
    }
    return _headView;
}

-(UIView *)viewFooter{
    if (_viewFooter == nil) {
        _viewFooter = [[UIView alloc] init];
        _viewFooter.frame = CGRectMake(0, 0, kScreenWidth, 64);
        _viewFooter.backgroundColor = [UIColor clearColor];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:HEXCOLOR(0x1dcb7c)];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(15, 20, kScreenWidth-30, 44);
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [_viewFooter addSubview:btn];
        
    }
    return _viewFooter;
}


@end
