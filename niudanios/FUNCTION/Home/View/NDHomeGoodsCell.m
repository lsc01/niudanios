//
//  NDHomeGoodsCell.m
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDHomeGoodsCell.h"
#import "NDHomeGoodsCollectionViewCell.h"
#define CELL_Height 169.0
#define Cell_Width 130.0
@interface NDHomeGoodsCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic ,strong) UICollectionView * collectionView;
@end

@implementation NDHomeGoodsCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.right.mas_equalTo(self);
    }];
}
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        //collectionView需要一个布局对象，可以用来设置滑动方向，间距等
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        //设置滑动方向（横向/纵向）UICollectionViewScrollDirectionHorizontal横向
        layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal; //纵向
        //初始化网格视图，需要设置一个layout
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(12, 0, kScreenWidth-12, CELL_Height) collectionViewLayout:layout];
        _collectionView.delegate = self;//UICollectionViewDelegateFlowLayout
        _collectionView.dataSource = self;//UICollectionViewDataSource
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        //网格视图的cell必须要用注册的方式,头部尾部也需要注册
        [_collectionView registerNib:[UINib nibWithNibName:@"NDHomeGoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NDHomeGoodsCollectionViewCell"];
    }
    return _collectionView;
}


#pragma mark - UICollectionView代理方法
//设置分组的数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//设置每个分组里cell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //只能用注册的方式
    
    NDHomeGoodsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NDHomeGoodsCollectionViewCell" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds = YES;
    return cell;
}

//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Cell_Width, CELL_Height);
}

/* 滚动方向有横向和纵向*/
//设置固定方向最小间距，如果屏幕大小不能满足几个cell总大小+多个间距总间距，就会换行显示
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//设置滚动方向间距，可以很大
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 12;
}

//设置分组四周的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //参数(上，左，下，右)
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectItemBlock?_selectItemBlock(indexPath.row):nil;
}

@end
