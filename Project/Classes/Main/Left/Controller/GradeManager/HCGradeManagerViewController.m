//
//  HCGradeManagerViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCGradeManagerViewController.h"
#import "HCRefreshHeader.h"
#import "HCFriendMessageCollectionViewCell.h"
#import "HCFriendMessageInfo.h"
#import "HCAddFriendViewController.h"
#import "UIImageView+WebCache.h"
#import "HCFriendMessageApi.h"

static NSString * const reuseIdentifier = @"FriendCell";

@interface HCGradeManagerViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UILabel *signatureLabel;


@end

@implementation HCGradeManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.title = @"XXX班级";
    [self setupBackItem];
    [self requestGradeManager:nil];
    
    self.collectionView.mj_header = [HCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestGradeManager:)];
    
    [self.collectionView registerClass:[HCFriendMessageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
     [self.collectionView registerClass:[HCFriendMessageCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionhead"];
}

#pragma mark - UICollectionView

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCFriendMessageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.info = self.dataSource[indexPath.section*4+indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionhead" forIndexPath:indexPath];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), WIDTH(self.view)*0.5)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://xiaodaohang.cn/2.jpg"] placeholderImage:OrigIMG(@"AddImages")];
        [reusableview addSubview:imgView];
        
        self.signatureLabel.frame = CGRectMake(0, MaxY(imgView)+10, WIDTH(self.view), 20);
        [reusableview addSubview:self.signatureLabel];
    }
    
    reusableview.backgroundColor = [UIColor whiteColor];
    
    return reusableview;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{

    
    if (section == 0)
    {
        CGSize size = {WIDTH(self.view), WIDTH(self.view)*0.5+40};
        return size;
    }else
    {
        CGSize size = {0, 0};
        return size;
    }

}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCFriendMessageInfo *info = self.dataSource[indexPath.section*4 + indexPath.row];
    if ([info.uid integerValue])
    {
        DLog(@"点击了---%@", info.name);
    }else
    {
        HCAddFriendViewController *addFriend = [[HCAddFriendViewController alloc] init];
        [self.navigationController pushViewController:addFriend animated:YES];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger row = self.dataSource.count/4;
    if (self.dataSource.count%4)
    {
        row = row + 1;
    }
    return row;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ((self.dataSource.count/4) == section)
    {
        return (self.dataSource.count % 4);
    }
    return 4;
}

#pragma mark - private methods

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupBackItem
{
    HCBarButtonItem *item = [[HCBarButtonItem alloc] initWithBackTarget:self action:@selector(backBtnClick)];
    self.navigationItem.leftBarButtonItem = item;
}

#pragma mark - setter or getter

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UILabel *)signatureLabel
{
    if (!_signatureLabel)
    {
        _signatureLabel = [[UILabel alloc] init];
        _signatureLabel.textAlignment = NSTextAlignmentCenter;
        _signatureLabel.font = [UIFont systemFontOfSize:15];
        _signatureLabel.numberOfLines = 0;
        _signatureLabel.text = @"XXX班的签名";
        _signatureLabel.textColor = DarkGrayColor;
    }
    return _signatureLabel;
}

#pragma mark - network

- (void)requestGradeManager:(HCRefreshHeader *)refresh
{
    if (refresh)
    {
        [self.collectionView.mj_header endRefreshing];
        return;
    }
    HCFriendMessageApi *api = [[HCFriendMessageApi alloc] init];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        [self.collectionView.mj_header endRefreshing];
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataSource addObjectsFromArray:array];
            [self.collectionView reloadData];
        }else
        {
            
        }
    }];
}


@end
