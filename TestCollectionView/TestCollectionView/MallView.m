//
//  MallView.m
//  TestCollectionView
//
//  Created by 孙海琛 on 2019/1/21.
//  Copyright © 2019年 孙海琛. All rights reserved.
//

#define kLeftWidth 110

#import "MallView.h"
#import "MallLeftCell.h"
#import "MallRightCell.h"
#import "MallRightHeaderView.h"
#import "MallRightTopView.h"

@interface MallView()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger _selectIndex;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *leftArrayData;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *rightArrayData;

@end

@implementation MallView
-(id)initWithFrame:(CGRect)frame
{
    if (self  == [super initWithFrame:frame]) {
        _selectIndex = 0;
        [self addSubview:self.tableView];
        [self addSubview:self.collectionView];
    }
    return self;
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftArrayData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MallLeftCell *cell = (MallLeftCell *)[tableView dequeueReusableCellWithIdentifier:@"MallLeftCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MallLeftCell" owner:self options:nil].lastObject;
    }
    if (indexPath.row == _selectIndex) {
        cell.backgroundColor=[UIColor yellowColor];
    }else
    {
        cell.backgroundColor=[UIColor grayColor];
    }
    cell.titStr = self.leftArrayData[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    MallLeftCell * cell=(MallLeftCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor=[UIColor yellowColor];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [self.rightArrayData removeAllObjects];
    self.rightArrayData = nil;
    [self.tableView reloadData];
    [self.collectionView reloadData];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MallLeftCell * cell=(MallLeftCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor=[UIColor grayColor];
}
#pragma mark -- UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.rightArrayData.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MallRightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MallRightCell" forIndexPath:indexPath];
    NSDictionary *dic = self.rightArrayData[indexPath.section];
    NSArray *arrL = dic[@"lists"];
    cell.titleLab.text = arrL[indexPath.row];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *supplementaryView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MallRightHeaderView* header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MallRightHeaderView" forIndexPath:indexPath];
        NSDictionary *dic = self.rightArrayData[indexPath.section];
        header.titleLab.text = dic[@"header"];
        supplementaryView = header;
    }
    return supplementaryView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.frame.size.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.frame.size.width, 0);
}

#pragma mark --set
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}
- (NSMutableArray *)leftArrayData
{
    if (!_leftArrayData) {
        _leftArrayData = [NSMutableArray array];
        NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16"];
        [_leftArrayData addObjectsFromArray:arr];
    }
    return _leftArrayData;
}
- (NSMutableArray *)rightArrayData
{
    if (!_rightArrayData) {
        _rightArrayData = [NSMutableArray array];
        for (int j = 0; j < 5; j++) {
            NSMutableArray *arr0 = [NSMutableArray array];
            for (int i = 0; i < 10 ; i++) {
                NSString *strT = [NSString stringWithFormat:@"%d",i];
                [arr0 addObject:strT];
            }
            NSDictionary*dic0 = @{@"header":[NSString stringWithFormat:@"header%d",j],@"lists":arr0};
            [_rightArrayData addObject:dic0];
        }
    }
    return _rightArrayData;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemW = (self.frame.size.width-kLeftWidth)/3;
        CGFloat itemH = 100;
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kLeftWidth, 0, self.frame.size.width-kLeftWidth, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        UINib *nib=[UINib nibWithNibName:@"MallRightCell" bundle:nil];
        [_collectionView registerNib: nib forCellWithReuseIdentifier:@"MallRightCell"];
        UINib *header=[UINib nibWithNibName:@"MallRightHeaderView" bundle:nil];
        [_collectionView registerNib:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MallRightHeaderView"];
        //设置滚动范围偏移200
        _collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(200, 0, 0, 0);
        //设置内容范围偏移200
        _collectionView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
        _collectionView.alwaysBounceVertical = YES;
        MallRightTopView *topV = [[MallRightTopView alloc] initWithFrame:CGRectMake(0, -200, self.frame.size.width, 200)];
        [_collectionView addSubview:topV];
    }
    return _collectionView;
}
@end
