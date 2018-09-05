//
//  NDMineAddressViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineAddressViewController.h"
#import "NDMineAddressTableViewCell.h"
#import "NDAddressEditViewController.h"
@interface NDMineAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NDMineAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的收货地址";
    [self setUI];
    
}
-(void)setUI{
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = YES;
    self.tableView.sectionFooterHeight = 8.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDMineAddressTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NDMineAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineAddressTableViewCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)addNewAddressClick:(UIButton *)sender {
    NDAddressEditViewController * vc = [[NDAddressEditViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
