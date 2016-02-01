//
//  HCPromisedTagMangerViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedTagMangerViewController.h"
#import "HCPromiseDetailViewController1.h"

#import "HCPromisedTagCell.h"

@interface HCPromisedTagMangerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView  *collectionView;
@property (nonatomic,strong) NSMutableArray   *dataArr;
@end

@implementation HCPromisedTagMangerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标签管理";
    [self  setupBackItem];
    [self.view addSubview:self.collectionView];
    
    
}

#pragma mark ---UICollectionViewDataSource,UICollectionViewDelegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCPromisedTagCell *cell = [HCPromisedTagCell cellWithCollectionView:collectionView andIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
//
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCPromiseDetailViewController1  *detailVC = [[HCPromiseDetailViewController1 alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
 
}

#pragma mark --- getter Or setter

- (UICollectionView *)collectionView
{
    if(!_collectionView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/4-15,SCREEN_WIDTH/4-15);
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource =self;
        
        [_collectionView registerClass:[HCPromisedTagCell class] forCellWithReuseIdentifier:@"TagCellID"];
        
    }
    return _collectionView;
}

-(NSMutableArray *)dataArr
{
    if(!_dataArr){
        _dataArr = [NSMutableArray arrayWithCapacity:4];
    }
    return _dataArr;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
