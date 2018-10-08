//
//  NDMineEnshrineViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineEnshrineViewController.h"
#import "NDMineEnshrineTableViewCell.h"
#import "NDMineEnshrineInfoModel.h"
#import "UIScrollView+EmptyDataSet.h"
@interface NDMineEnshrineViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray * arrData;
@end

@implementation NDMineEnshrineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的收藏";
    
    [self setUI];
    [SVProgressHUD show];
    [self postRequest];
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
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}


-(void)postRequest{
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    
    [HLLHttpManager postWithURL:URL_findCustomerId params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
            self.arrData = nil;
            for (NSDictionary * dict in arrRows) {
                NDMineEnshrineInfoModel * model = [NDMineEnshrineInfoModel mj_objectWithKeyValues:dict];
                [self.arrData addObject:model];
            }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
}


-(void)deleteEnshrinGoodsWithId:(NSString *)Id{
    [SVProgressHUD showWithStatus:@"正在删除"];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:Id forKey:@"id"];
    
    [HLLHttpManager postWithURL:URL_modifyCollect params:dictP success:^(NSDictionary *responseObject) {
        [self postRequest];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"删除失败"];
    }];
}

#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrData.count;
    
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
    NDMineEnshrineInfoModel * model = self.arrData[indexPath.section];
    cell.model = model;
    WeakSelf();
    [cell setDeleteEnshrinGoodsBlock:^(NSString *Id) {
        StrongSelf();
        [strongself deleteEnshrinGoodsWithId:Id];
    }];
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 空白页
//空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"bg_eeg"];
}
//空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"这里啥都没有";
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
