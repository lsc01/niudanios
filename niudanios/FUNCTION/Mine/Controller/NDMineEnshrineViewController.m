//
//  NDMineEnshrineViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineEnshrineViewController.h"
#import "NDMineEnshrineTableViewCell.h"
@interface NDMineEnshrineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NDMineEnshrineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的收藏";
    
    [self setUI];
    
}
-(void)setUI{
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = YES;
    self.tableView.sectionFooterHeight = 10.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineEnshrineTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDMineEnshrineTableViewCell"];
    
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
    
    
    NDMineEnshrineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineEnshrineTableViewCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
