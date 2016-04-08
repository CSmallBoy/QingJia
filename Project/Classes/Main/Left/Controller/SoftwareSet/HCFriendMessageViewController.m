//
//  HCFriendMessageViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCFriendMessageViewController.h"
#import "HCAddFriendViewController.h"
#import "HCFriendMessageCollectionViewCell.h"
#import "HCFriendMessageInfo.h"
#import "HCFriendMessageApi.h"

@interface HCFriendMessageViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HCFriendMessageViewController

static NSString * const reuseIdentifier = @"FriendCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.title = @"指定好友不可见";
    [self setupBackItem];
    
    [self requestFriendMessage];
    
    [self.collectionView registerClass:[HCFriendMessageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCFriendMessageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.info = self.dataSource[indexPath.section*4+indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCFriendMessageInfo *info = self.dataSource[indexPath.section*4 + indexPath.row];
    if ([info.userId integerValue])
    {
        DLog(@"点击了---%@", info.nickName);
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


#pragma mark - setter or getter

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)setupBackItem
{
    HCBarButtonItem *item = [[HCBarButtonItem alloc] initWithBackTarget:self action:@selector(backBtnClick)];
    self.navigationItem.leftBarButtonItem = item;
}

#pragma mark - network

- (void)requestFriendMessage
{
    HCFriendMessageApi *api = [[HCFriendMessageApi alloc] init];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
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
