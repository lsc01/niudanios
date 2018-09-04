//
//  NDMyWalletViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/3.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMyWalletViewController.h"
#import "NDMineTableViewCell.h"
#import "NDMyWalletHeadView.h"
#import "NDMIneDataViewController.h"
#import "NDAccountPayViewController.h"
#import "NDAccountPayDeatailVC.h"
@interface NDMyWalletViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NDMyWalletHeadView * headView;

@property(nonatomic,strong)UITableView *tableView;



@end

@implementation NDMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    [self setUI];
}


-(void)setUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.bounces = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDMineTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        NDMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineTableViewCell"  forIndexPath:indexPath];
        cell.viewLine.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.imageViewRight.hidden = YES;
        if (indexPath.row == 0) {
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_arg"];
            cell.labelName.text = @"账号充值";
        }else if (indexPath.row == 1){
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_ads"];
            cell.labelName.text = @"账号明细";
        }
        
        
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        NDAccountPayViewController * vc = [[NDAccountPayViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        NDAccountPayDeatailVC * vc = [[NDAccountPayDeatailVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}




-(NDMyWalletHeadView *)headView{
    if(_headView == nil){
        _headView = [[NSBundle mainBundle] loadNibNamed:@"NDMyWalletHeadView" owner:self options:nil].firstObject;
        _headView.frame = CGRectMake(0, 0, kScreenWidth, 106);
    }
    return _headView;
}


@end
