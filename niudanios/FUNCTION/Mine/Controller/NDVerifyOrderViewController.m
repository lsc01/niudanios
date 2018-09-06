//
//  NDVerifyOrderViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/6.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDVerifyOrderViewController.h"
#import "NDVerifyOrderTableViewCell.h"
#import "NDVerifyOrderHeadView.h"
@interface NDVerifyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalGoods;
@property (weak, nonatomic) IBOutlet UILabel *labelYunfei;

@property (nonatomic ,strong) NDVerifyOrderHeadView * headView;
@end

@implementation NDVerifyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"确认订单";
    
    [self setUI];
    
}
- (IBAction)submitOrderClick:(UIButton *)sender {
}
-(void)setUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarAndStateBarHeight-44) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 10.0f;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.bounces = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDVerifyOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDVerifyOrderTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 93.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NDVerifyOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDVerifyOrderTableViewCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(NDVerifyOrderHeadView *)headView{
    if (_headView == nil) {
        _headView = [[NSBundle mainBundle] loadNibNamed:@"NDVerifyOrderHeadView" owner:self options:nil].firstObject;
        _headView.frame = CGRectMake(0, 0, kScreenWidth, 75);
        
        _headView.hasAddress = YES;
    }
    return _headView;
}

@end
