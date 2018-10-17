//
//  NDLogisticsDetailViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/8.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDLogisticsDetailViewController.h"
#import "NDLogisticsDetailTableViewCell.h"
#import "NDLogisticsDetailHeadView.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface NDLogisticsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) UITableView *tableView;


@property (nonatomic ,strong) NDLogisticsDetailHeadView * headView;

@property (nonatomic ,strong) UIView * setioneHeadView;

@property (nonatomic ,strong) NSMutableArray * arrData;

@end

@implementation NDLogisticsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    self.arrData = self.modelInfo.logisticsDataArray;
    [self.headView.imageViewGoods sd_setImageWithURL:[NSURL URLWithString:ImageUrl(self.modelInfo.gashaponImg)] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"error:%@",error);
    }];
    self.headView.labelOrderId.text = self.modelInfo.Id;
    if ([self.modelInfo.status isEqualToString:@"DF"]) {
        self.headView.labelState.text = @"待发货";
    }else if ([self.modelInfo.status isEqualToString:@"DS"]) {
        self.headView.labelState.text = @"运输中";
    }else if ([self.modelInfo.status isEqualToString:@"YS"]) {
        self.headView.labelState.text = @"已收货";
    }

    self.headView.labelPhone.text =self.modelInfo.phone==nil?self.modelInfo.phone:@"暂无";
    self.headView.labelKuaiDiCompany.text = self.modelInfo.companyName;
    
    [self setUI];
    
}

-(void)setUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarAndStateBarHeight-44) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 44.0f;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.bounces = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDLogisticsDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDLogisticsDetailTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"NDLogisticsDetailTableViewCell" cacheByIndexPath:indexPath configuration:^(NDLogisticsDetailTableViewCell * cell) {
        NDLogisticsInfoModel * model = self.arrData[indexPath.row];
        if (indexPath.row == 0) {
            cell.viewLineTop.hidden = YES;
            cell.viewLineBottom.hidden = NO;
            cell.labelDes.textColor = HEXCOLOR(0x1dcb7c);
        }else if (indexPath.row == self.arrData.count-1){
            cell.viewLineTop.hidden = NO;
            cell.viewLineBottom.hidden = YES;
            cell.labelDes.textColor = HEXCOLOR(0x666666);
        }else{
            cell.viewLineTop.hidden = NO;
            cell.viewLineBottom.hidden = NO;
            cell.labelDes.textColor = HEXCOLOR(0x666666);
        }
        cell.labelTime.text = model.time;
        cell.labelDes.text = model.context;
    }];
    
//    return 68.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrData.count;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return self.setioneHeadView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NDLogisticsDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDLogisticsDetailTableViewCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NDLogisticsInfoModel * model = self.arrData[indexPath.row];
    if (indexPath.row == 0) {
        cell.viewLineTop.hidden = YES;
        cell.viewLineBottom.hidden = NO;
        cell.labelDes.textColor = HEXCOLOR(0x1dcb7c);
    }else if (indexPath.row == self.arrData.count-1){
        cell.viewLineTop.hidden = NO;
        cell.viewLineBottom.hidden = YES;
        cell.labelDes.textColor = HEXCOLOR(0x666666);
    }else{
        cell.viewLineTop.hidden = NO;
        cell.viewLineBottom.hidden = NO;
        cell.labelDes.textColor = HEXCOLOR(0x666666);
    }
    cell.labelTime.text = model.time;
    cell.labelDes.text = model.context;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(NDLogisticsDetailHeadView *)headView{
    if (_headView == nil) {
        _headView = [[NSBundle mainBundle] loadNibNamed:@"NDLogisticsDetailHeadView" owner:self options:nil].firstObject;
        _headView.frame = CGRectMake(0, 0, kScreenWidth, 110);
    }
    return _headView;
}

-(UIView *)setioneHeadView{
    if (_setioneHeadView == nil) {
        _setioneHeadView = [[UIView alloc] init];
        _setioneHeadView.backgroundColor = [UIColor whiteColor];
        _setioneHeadView.frame = CGRectMake(0, 0, kScreenWidth, 44);
        
        
        UIImageView * imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake(12, 12, 20, 20);
        imageview.image = [UIImage imageNamed:@"ic_eceived"];
        [_setioneHeadView addSubview:imageview];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(44, 12, 100, 20);
        label.text = @"物流跟踪";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = HEXCOLOR(0x222222);
        [_setioneHeadView addSubview:label];
        
        UIView * viewLine = [[UIView alloc] init];
        viewLine.backgroundColor = HEXCOLOR(0xe5e5e5);
        viewLine.frame = CGRectMake(12, 43, kScreenWidth-12, 1);
        [_setioneHeadView addSubview:viewLine];
    }
    return _setioneHeadView;
}

-(NSMutableArray *)arrData{
    if (_arrData == nil) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

@end
