//
//  NDMineOrderDetailViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineOrderDetailViewController.h"
#import "NDMineOrderDetailView.h"
#import "NDOrderDetailTableViewCell.h"
#import "NDLogisticsDetailViewController.h"
@interface NDMineOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NDMineOrderDetailView * headerView;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation NDMineOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    [self setUI];
}


-(void)setUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarAndStateBarHeight-kTabbarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 10.0f;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.bounces = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDOrderDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDOrderDetailTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    WeakSelf();
    [self.headerView setLookOrderLogisticsDetailBlock:^{
        StrongSelf();
        NDLogisticsDetailViewController * vc = [[NDLogisticsDetailViewController alloc] init];
        [strongself.navigationController pushViewController:vc animated:YES];
    }];
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 92.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NDOrderDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDOrderDetailTableViewCell"     forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
   
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}




-(NDMineOrderDetailView *)headerView{
    if(_headerView == nil){
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"NDMineOrderDetailView" owner:self options:nil].firstObject;
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 229);
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}



@end
