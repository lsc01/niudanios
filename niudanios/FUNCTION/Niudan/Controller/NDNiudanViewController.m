//
//  NDNiudanViewController.m
//  niudanios
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDNiudanViewController.h"
#import "NDNiudanFilterView.h"
#import "NDNiudanGoodsCell.h"
#import "NDNiudanKindFilterModel.h"
#import "NDNiudanPriceFilterModel.h"
#import "NDNiudanSortFilterModel.h"
#import "NDBaseWebViewController.h"
#import "NDLoginViewController.h"
typedef NS_ENUM(NSInteger,FilterType) {
    Filter_Nomal = 0,
    Filter_Kind = 1,
    Filter_Price = 2,
    Filter_Sort = 3
};

#define Cell_Width (338.0/750*kScreenWidth)
#define CELL_Height ((255.0/168)*Cell_Width)
#define Cell_Spacing (kScreenWidth - 2*Cell_Width)/3.0
@interface NDNiudanViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic ,assign) FilterType filterType;
@property (nonatomic ,copy) NSString * kindIdCurr;
@property (nonatomic ,copy) NSString * priceIdCurr;
@property (nonatomic ,copy) NSString * sortIdCurr;
@property (nonatomic ,strong) NSMutableArray * arrFilterCurr;
@property (nonatomic ,strong) NSArray * arrSortFilter;
@property (nonatomic ,strong) NSDictionary * dictSortFilter;
    
@property (nonatomic ,strong) UICollectionView * collectionView;

@property (weak, nonatomic) IBOutlet UIView *viewSearchFieldBg;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;


@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UILabel *labelKind;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelNormal;
@property (weak, nonatomic) IBOutlet NDNiudanFilterView *filterView;

@property (weak, nonatomic) IBOutlet UIView *viewFilterBar;

@property (nonatomic ,strong) NSMutableArray * arrData;
    
    
    
@end

@implementation NDNiudanViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.filterType = Filter_Nomal;
        self.sortIdCurr = @"0";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUI];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    [self postRequestWithDictP:dictP];
}

-(void)postRequestWithDictP:(NSDictionary *)params{
    [SVProgressHUD show];
    
    [HLLHttpManager postWithURL:URL_qrequirementAll params:params success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        self.arrData = nil;
        for (NSDictionary * dict in arrRows) {
            NDGoodsInfoModel * model = [NDGoodsInfoModel mj_objectWithKeyValues:dict];
            [self.arrData addObject:model];
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
}
    
    
    

-(void)setUI{
    self.viewSearchFieldBg.layer.cornerRadius = 4;
    self.viewSearchFieldBg.layer.masksToBounds = YES;
    
    self.btnSearch.layer.cornerRadius = 4;
    self.btnSearch.layer.masksToBounds = YES;
    self.filterView.hidden = YES;
    
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewFilterBar.mas_bottom);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    
    WeakSelf();
    [self.filterView setSelectRowBlock:^(NSInteger row) {
        StrongSelf();
        strongself.filterView.hidden = YES;
        NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
        [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
        switch (self.filterType) {
            case Filter_Kind:
            {
                
                NDNiudanKindFilterModel * model = self.arrFilterCurr[row];
                [dictP setObject:model.Id forKey:@"classifyId"];
                self.kindIdCurr = model.Id;
            }
                break;
            case Filter_Price:
            {
                NDNiudanPriceFilterModel * model = self.arrFilterCurr[row];
                [dictP setObject:model.Id forKey:@"compareId"];
                self.priceIdCurr = model.Id;
            }
                break;
            case Filter_Sort:
            {
                if (row == 0) {
                    self.sortIdCurr = @"0";
                    break;
                }
                NDNiudanKindFilterModel * model = self.arrFilterCurr[row];
                [dictP setObject:model.Id forKey:@"status"];
                self.sortIdCurr = model.Id;
            }
                break;
                
            default:
                break;
        }
        [self postRequestWithDictP:dictP];
    }];
    
}


#pragma mark - UICollectionView代理方法
//设置分组的数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//设置每个分组里cell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //只能用注册的方式
    NDGoodsInfoModel * model = self.arrData[indexPath.row];
    NDNiudanGoodsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NDNiudanGoodsCell" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds = YES;
    
    cell.model = model;
    
    WeakSelf();
    [cell setCollectGoodsBlock:^(NSString *gashaponMachineId, BOOL isCollect) {
        StrongSelf();
        if (isCollect) {
            [strongself collectGoodsWithId:gashaponMachineId andIndexPath:indexPath];
        }else{
            [strongself collectCancelGoodsWithId:gashaponMachineId andIndexPath:indexPath];
        }
    }];
    return cell;
}


-(void)collectGoodsWithId:(NSString *)gashaponMachineId andIndexPath:(NSIndexPath *)inexPath{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:gashaponMachineId forKey:@"gashaponMachineId"];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_AddCollect params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count >0) {
            NSDictionary * dictT = arrRows.firstObject;
            if ([dictT[@"code"] integerValue] == 1) {
                [SVProgressHUD showToast:@"收藏成功"];
            }else{
                [SVProgressHUD showToast:dictT[@"msg"]];
                NDNiudanGoodsCell * cell = (NDNiudanGoodsCell *)[self.collectionView cellForItemAtIndexPath:inexPath];
                cell.btnCollect.selected = NO;
            }
        }
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"收藏失败"];
        NDNiudanGoodsCell * cell = (NDNiudanGoodsCell *)[self.collectionView cellForItemAtIndexPath:inexPath];
        cell.btnCollect.selected = NO;
    }];
}
-(void)collectCancelGoodsWithId:(NSString *)gashaponMachineId andIndexPath:(NSIndexPath *)inexPath{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:gashaponMachineId forKey:@"gashaponMachineId"];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_removeCollert params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count >0) {
            NSDictionary * dictT = arrRows.firstObject;
            if ([dictT[@"code"] integerValue] == 0) {
                [SVProgressHUD showToast:@"取消收藏成功"];
            }else{
                [SVProgressHUD showToast:dictT[@"msg"]];
                NDNiudanGoodsCell * cell = (NDNiudanGoodsCell *)[self.collectionView cellForItemAtIndexPath:inexPath];
                cell.btnCollect.selected = YES;
            }
        }
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"取消失败"];
        NDNiudanGoodsCell * cell = (NDNiudanGoodsCell *)[self.collectionView cellForItemAtIndexPath:inexPath];
        cell.btnCollect.selected = YES;
    }];
}

//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Cell_Width, CELL_Height);
}

/* 滚动方向有横向和纵向*/
//设置固定方向最小间距，如果屏幕大小不能满足几个cell总大小+多个间距总间距，就会换行显示
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

//设置滚动方向间距，可以很大
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 12;
}

//设置分组四周的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //参数(上，左，下，右)
    return UIEdgeInsetsMake(12, Cell_Spacing, 12, Cell_Spacing);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (![HLLShareManager shareMannager].userModel) {
        NDLoginViewController * loginVC = [[NDLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    NDGoodsInfoModel * model = self.arrData[indexPath.row];
    NDBaseWebViewController * webVC = [[NDBaseWebViewController alloc] init];
    webVC.urlString = [NSString stringWithFormat:@"%@?id=%@&customerId=%@",URL_h5ToTwisted,model.Id,[HLLShareManager shareMannager].userModel.Id];
    webVC.title = @"扭蛋";
    [self.navigationController pushViewController:webVC animated:YES];
}


-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        //collectionView需要一个布局对象，可以用来设置滑动方向，间距等
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        //设置滑动方向（横向/纵向）UICollectionViewScrollDirectionHorizontal横向
        layout.scrollDirection =  UICollectionViewScrollDirectionVertical; //纵向
        //初始化网格视图，需要设置一个layout
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(12, 0, kScreenWidth-12, CELL_Height) collectionViewLayout:layout];
        _collectionView.delegate = self;//UICollectionViewDelegateFlowLayout
        _collectionView.dataSource = self;//UICollectionViewDataSource
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        //网格视图的cell必须要用注册的方式,头部尾部也需要注册
        [_collectionView registerNib:[UINib nibWithNibName:@"NDNiudanGoodsCell" bundle:nil] forCellWithReuseIdentifier:@"NDNiudanGoodsCell"];
    }
    return _collectionView;
}

- (IBAction)searchBtnClick:(UIButton *)sender {
    if(self.textFieldSearch.text.length <1){
        [SVProgressHUD showToast:@"请输入查询条件"];
        return;
    }
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    [dictP setObject:self.textFieldSearch.text forKey:@"machineName"];
    [self postRequestWithDictP:dictP];
}
    
    
    ///查询条件 type== 1 种类查询  type==2 金额条件
-(void)findKindConditionWithType:(NSInteger)type{
    FilterType filterType = 0;
    if (type == 1) {
        filterType = Filter_Kind;
    }else if (type == 2){
        filterType = Filter_Price;
    }
    
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_classifycoalition params:nil success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        [self.view bringSubviewToFront:self.filterView];
        self.filterView.hidden = NO;
        self.filterType = filterType;
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dictT = arrRows.firstObject;
            NSArray * arrListClass = dictT[@"listClass"];
            NSArray * arrListMoneyCompare = dictT[@"listMoneyCompare"];
            self.arrFilterCurr = nil;
            NSMutableArray * arrTemp1 = [NSMutableArray array];
            NSMutableArray * arrTempModel1 = [NSMutableArray array];
            for (NSDictionary * dict in arrListClass) {
                NDNiudanKindFilterModel * model = [NDNiudanKindFilterModel mj_objectWithKeyValues:dict];
                if (type == 1) {
                    [self.arrFilterCurr addObject:model];
                }
                 [arrTempModel1 addObject:model];
                NDNiudanFilterModel * modelTemp = [[NDNiudanFilterModel alloc] init];
                modelTemp.textValue = model.classifyName;
                if ([model.Id isEqualToString:self.kindIdCurr]) {
                    modelTemp.textColor = HEXCOLOR(kBaseColor);
                }else{
                    modelTemp.textColor = HEXCOLOR(0x222222);
                }
                
                [arrTemp1 addObject:modelTemp];
            }
            if (type == 1) {
                self.filterView.arrayModel = arrTemp1;
            }
            
            NSMutableArray * arrTemp2 = [NSMutableArray array];
            NSMutableArray * arrTempModel2 = [NSMutableArray array];
            for (NSDictionary * dict in arrListMoneyCompare) {
                NDNiudanPriceFilterModel * model = [NDNiudanPriceFilterModel mj_objectWithKeyValues:dict];
                if (type == 2) {
                    [self.arrFilterCurr addObject:model];
                }
                [arrTempModel2 addObject:model];
                NDNiudanFilterModel * modelTemp = [[NDNiudanFilterModel alloc] init];
                modelTemp.textValue = model.name;
                if ([model.Id isEqualToString:self.kindIdCurr]) {
                    modelTemp.textColor = HEXCOLOR(kBaseColor);
                }else{
                    modelTemp.textColor = HEXCOLOR(0x222222);
                }
                
                [arrTemp2 addObject:modelTemp];
            }
            if (type == 2) {
                self.filterView.arrayModel = arrTemp2;
            }
            
            self.dictSortFilter = @{@"listClass":@{@"model":arrTempModel1,@"show":arrTemp1},
                                @"listMoneyCompare":@{@"model":arrTempModel2,@"show":arrTemp2}};
        }
        
        
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"获取失败,请重试"];
    }];
}
    
    
- (IBAction)kindBtnClick:(UIButton *)sender {
    if (self.dictSortFilter) {
        [self.view bringSubviewToFront:self.filterView];
        self.filterView.hidden = NO;
        self.filterType = Filter_Kind;
        NSDictionary * dictData = self.dictSortFilter[@"listClass"];
        self.arrFilterCurr = [NSMutableArray arrayWithArray:dictData[@"model"]];
        self.filterView.arrayModel = dictData[@"show"];
    }else{
        [self findKindConditionWithType:1];
    }
    
    return;
    
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_classify params:nil success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        [self.view bringSubviewToFront:self.filterView];
        self.filterView.hidden = NO;
        self.filterType = Filter_Kind;
        NSArray * arrRows = responseObject[@"rows"];
        self.arrFilterCurr = nil;
        NSMutableArray * arrTemp = [NSMutableArray array];
        for (NSDictionary * dict in arrRows) {
            NDNiudanKindFilterModel * model = [NDNiudanKindFilterModel mj_objectWithKeyValues:dict];
            [self.arrFilterCurr addObject:model];
            
            NDNiudanFilterModel * modelTemp = [[NDNiudanFilterModel alloc] init];
            modelTemp.textValue = model.classifyName;
            if ([model.Id isEqualToString:self.kindIdCurr]) {
                modelTemp.textColor = HEXCOLOR(kBaseColor);
            }else{
                modelTemp.textColor = HEXCOLOR(0x222222);
            }
            [arrTemp addObject:modelTemp];
        }
        self.filterView.arrayModel = arrTemp;
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"获取失败,请重试"];
    }];
    
}
- (IBAction)priceBtnClick:(UIButton *)sender {
    
    if (self.dictSortFilter) {
        [self.view bringSubviewToFront:self.filterView];
        self.filterView.hidden = NO;
        self.filterType = Filter_Price;
        NSDictionary * dictData = self.dictSortFilter[@"listMoneyCompare"];
        self.arrFilterCurr = [NSMutableArray arrayWithArray:dictData[@"model"]];
        self.filterView.arrayModel = dictData[@"show"];
    }else{
        [self findKindConditionWithType:2];
    }
    
    return;
    
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_qmoneyCompare params:nil success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        [self.view bringSubviewToFront:self.filterView];
        self.filterView.hidden = NO;
        self.filterType = Filter_Price;
        NSArray * arrRows = responseObject[@"rows"];
        self.arrFilterCurr = nil;
        NSMutableArray * arrTemp = [NSMutableArray array];
        for (NSDictionary * dict in arrRows) {
            NDNiudanPriceFilterModel * model = [NDNiudanPriceFilterModel mj_objectWithKeyValues:dict];
            [self.arrFilterCurr addObject:model];
            
            NDNiudanFilterModel * modelTemp = [[NDNiudanFilterModel alloc] init];
            modelTemp.textValue = model.name;
            if ([model.Id isEqualToString:self.priceIdCurr]) {
                modelTemp.textColor = HEXCOLOR(kBaseColor);
            }else{
                modelTemp.textColor = HEXCOLOR(0x222222);
            }
            [arrTemp addObject:modelTemp];
        }
        self.filterView.arrayModel = arrTemp;
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"获取失败,请重试"];
    }];
    
}
- (IBAction)normalBtnClick:(UIButton *)sender {

        [self.view bringSubviewToFront:self.filterView];
        self.filterView.hidden = NO;
        self.filterType = Filter_Sort;
        self.arrFilterCurr = nil;
        NSMutableArray * arrTemp = [NSMutableArray array];
        for (NDNiudanSortFilterModel * model in self.arrSortFilter) {
            [self.arrFilterCurr addObject:model];
            
            NDNiudanFilterModel * modelTemp = [[NDNiudanFilterModel alloc] init];
            modelTemp.textValue = model.status;
            if ([model.Id isEqualToString:self.sortIdCurr]) {
                modelTemp.textColor = HEXCOLOR(kBaseColor);
            }else{
                modelTemp.textColor = HEXCOLOR(0x222222);
            }
            [arrTemp addObject:modelTemp];
        }
        self.filterView.arrayModel = arrTemp;
}

-(NSMutableArray *)arrFilterCurr{
    if (_arrFilterCurr == nil) {
        _arrFilterCurr = [NSMutableArray array];
    }
    return _arrFilterCurr;
}
-(NSArray *)arrSortFilter{
    NDNiudanSortFilterModel * model = [[NDNiudanSortFilterModel alloc] init];
    model.Id = @"0";
    model.status = @"默认排序";
    NDNiudanSortFilterModel * model1 = [[NDNiudanSortFilterModel alloc] init];
    model1.Id = @"1";
    model1.status = @"销售降序";
    NDNiudanSortFilterModel * model2 = [[NDNiudanSortFilterModel alloc] init];
    model2.Id = @"2";
    model2.status = @"最新上架";
    NDNiudanSortFilterModel * model3 = [[NDNiudanSortFilterModel alloc] init];
    model3.Id = @"3";
    model3.status = @"价格降序";
    NDNiudanSortFilterModel * model4 = [[NDNiudanSortFilterModel alloc] init];
    model4.Id = @"4";
    model4.status = @"价格升序";
    return @[model,model1,model2,model3,model4];
}


-(NSMutableArray *)arrData{
    if (_arrData == nil) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

@end
