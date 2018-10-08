//
//  NDMineDownViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/4.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineDownViewController.h"
#import "NDMineDownTableViewCell.h"
#import "NDMineDownInfoModel.h"
#import "UIScrollView+EmptyDataSet.h"
@interface NDMineDownViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray * arrData;
@end

@implementation NDMineDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的下线";

    [self setUI];
    [self postRequest];
}

-(void)postRequest{
    [SVProgressHUD show];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"id"];
   
    [HLLHttpManager postWithURL:URL_rqueryHeeler params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        self.arrData = nil;
        for (NSDictionary * dict in arrRows) {
            NDMineDownInfoModel * model = [NDMineDownInfoModel mj_objectWithKeyValues:dict];
            [self.arrData addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
}



-(void)setUI{
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = YES;
    self.tableView.sectionFooterHeight = 10.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineDownTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDMineDownTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
}
#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrData.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 68.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NDMineDownTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineDownTableViewCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NDMineDownInfoModel * model =self.arrData[indexPath.section];
    cell.model = model;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - 空白页
//空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"bg_nrd"];
}
//空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"您还没有下线用户哦";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:HEXCOLOR(0x999999)
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

//将组件彼此上下分离（默认分隔为11个分
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 16.0f;
}


-(NSMutableArray *)arrData{
    if (_arrData == nil) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

@end
