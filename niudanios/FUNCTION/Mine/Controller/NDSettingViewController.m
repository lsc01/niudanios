//
//  NDSettingViewController.m
//  niudanios
//
//  Created by lsc on 2018/8/26.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDSettingViewController.h"
#import "NDSettingTableViewCell.h"
#import "NDSettingHeaderView.h"
#import "NDUpdatePhoneViewController.h"

@interface NDSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NDSettingHeaderView * headView;

@property (nonatomic ,strong) UIView * viewFooter;

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation NDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDSettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDSettingTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(void)exitBtnClick{
    
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 3;
    }else if(section == 1){
        return 2;
    }else{
        return 0;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NDSettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDSettingTableViewCell"     forIndexPath:indexPath];
        cell.viewLine.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.switchVoice.hidden = YES;
        cell.imageViewRight.hidden = NO;
        if (indexPath.row == 0) {
            
            cell.labelName.text = @"账号资料";
        }else if (indexPath.row == 1){
            
            cell.labelName.text = @"修改手机号";
        }else if (indexPath.row == 2){
            
            cell.labelName.text = @"修改密码";
        }
        
        
        return cell;
    }else if (indexPath.section == 1){
        NDSettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDSettingTableViewCell" forIndexPath:indexPath];
        cell.viewLine.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.labelName.text = @"声音";
            cell.switchVoice.hidden = NO;
            cell.imageViewRight.hidden = YES;
        }else if (indexPath.row == 1){
            cell.labelName.text = @"清除缓存";
            cell.viewLine.hidden = YES;
            cell.switchVoice.hidden = YES;
            cell.imageViewRight.hidden = NO;
        }
        
        
        return cell;
    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            NDUpdatePhoneViewController * updatePhone = [[NDUpdatePhoneViewController alloc] init];
            [self.navigationController pushViewController:updatePhone animated:YES];
        }
    }
}




-(NDSettingHeaderView *)headView{
    if(_headView == nil){
        _headView = [[NSBundle mainBundle] loadNibNamed:@"NDSettingHeaderView" owner:self options:nil].firstObject;
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
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:@"退出" forState:UIControlStateNormal];
        [btn setTitleColor:HEXCOLOR(0x1dcb7c) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(15, 20, kScreenWidth-30, 44);
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [_viewFooter addSubview:btn];
        
    }
    return _viewFooter;
}


@end
