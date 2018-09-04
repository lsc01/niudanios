//
//  NDNiudanFilterView.m
//  niudanios
//
//  Created by lsc on 2018/8/30.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDNiudanFilterView.h"
#import "NDNiudanFilterCell.h"
@implementation NDNiudanFilterView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUI];
}


-(void)setUI{
    UIView * viewBg = [[UIView alloc] init];
    viewBg.backgroundColor = HEXCOLOR(0x000000);
    viewBg.alpha = 0.2;
    [self addSubview:viewBg];
    [viewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDNiudanFilterCell" bundle:nil] forCellReuseIdentifier:@"NDNiudanFilterCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    
    }];
}
#pragma mark - tableview

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayModel.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NDNiudanFilterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDNiudanFilterCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    NDNiudanFilterModel * model = self.arrayModel[indexPath.row];
    
    cell.labelFilter.textColor = model.textColor;
    cell.labelFilter.text = model.textValue;
  
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectRowBlock?_selectRowBlock(indexPath.row):nil;
}


-(void)setArrayModel:(NSArray<NDNiudanFilterModel *> *)arrayModel{
    _arrayModel = arrayModel;
    [self.tableView reloadData];
}


@end
