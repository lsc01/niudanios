//
//  NDPackageViewController.m
//  niudanios
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDPackageViewController.h"
#import "NDPackageTableViewCell.h"
#import "NDVerifyOrderViewController.h"
@interface NDPackageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *btnAllSelect;

@property (weak, nonatomic) IBOutlet UILabel *labelSelect;

@property (weak, nonatomic) IBOutlet UILabel *labelDes;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;


@end

@implementation NDPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setUI];
    
}
-(void)setUI{
    self.btnAllSelect.layer.cornerRadius = 10;
    self.btnAllSelect.clipsToBounds = YES;
    self.btnAllSelect.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnAllSelect.layer.borderWidth = 1;
    
    
    self.btnSubmit.layer.cornerRadius = 4;
    self.btnSubmit.clipsToBounds = YES;
    

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = YES;
    self.tableView.sectionFooterHeight = 10.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"NDPackageTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDPackageTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}




- (IBAction)selectAllClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)submitOrderClick:(UIButton *)sender {
    NDVerifyOrderViewController * vc = [[NDVerifyOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
    
    
    NDPackageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDPackageTableViewCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
