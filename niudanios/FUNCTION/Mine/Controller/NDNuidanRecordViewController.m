//
//  NDNuidanRecordViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDNuidanRecordViewController.h"
#import "NDRecodeTableViewCell.h"
@interface NDNuidanRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NDNuidanRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"扭蛋记录";
    [self setUI];
    
}
-(void)setUI{
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = YES;
    self.tableView.sectionFooterHeight = 10.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"NDRecodeTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDRecodeTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NDRecodeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDRecodeTableViewCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
