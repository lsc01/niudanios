//
//  NDNuidanRecordViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDNuidanRecordViewController.h"
#import "NDRecodeTableViewCell.h"
#import "NDNuidanRecordModel.h"
#import "UIScrollView+EmptyDataSet.h"
@interface NDNuidanRecordViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic ,strong) NSMutableArray * arrData;
@end

@implementation NDNuidanRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"扭蛋记录";
    [self setUI];
    [self postRequest];
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
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

-(void)postRequest{
    [SVProgressHUD show];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    
    [HLLHttpManager postWithURL:URL_niudanqueryRecord params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        self.arrData = nil;
        for (NSDictionary * dict in arrRows) {
            NDNuidanRecordModel * model = [NDNuidanRecordModel mj_objectWithKeyValues:dict];
            [self.arrData addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
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
    
    
    NDRecodeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDRecodeTableViewCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NDNuidanRecordModel * model = self.arrData[indexPath.section];
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
    NSString *title = @"您还没有任何的扭蛋记录哦";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:HEXCOLOR(0x999999)
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"点击 这里 前往商城来一发吧~~~~";
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置所有字体大小为 #15
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:14.0]
                   range:NSMakeRange(0, text.length)];
    // 设置所有字体颜色为浅灰色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:HEXCOLOR(0x999999)
                   range:NSMakeRange(0, text.length)];
    // 设置指定4个字体为蓝色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:HEXCOLOR(0x1dcb7c)
                   range:NSMakeRange(2, 4)];
    return attStr;
}

//将组件彼此上下分离（默认分隔为11个分
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 16.0f;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    NSLog(@"空白按钮点击");
}


-(NSMutableArray *)arrData{
    if (_arrData == nil) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

@end
