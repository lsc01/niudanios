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
}

-(void)saveBtnClick{
    
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
    
        if (indexPath.row == 0) {
            cell.btnSelect.enabled = NO;
            [cell.btnSelect setTitle:@"宋钟敏" forState:UIControlStateDisabled];
            cell.labelTitle.text = @"昵称";
        }else if (indexPath.row == 1){
            cell.btnSelect.enabled = YES;
            [cell.btnSelect setTitle:@"请选择" forState:UIControlStateNormal];
            cell.labelTitle.text = @"性别";
           
        }else if (indexPath.row == 2){
            cell.viewLine.hidden = YES;
            cell.btnSelect.enabled = YES;
            [cell.btnSelect setTitle:@"请选择" forState:UIControlStateNormal];
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
