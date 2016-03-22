//
//  HCMtalkShopingController.m
//  Project
//
//  Created by 朱宗汉 on 16/3/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMtalkShopingController.h"
#import "HCProductDetailController.h"
#import "HCMtalkShopingInfo.h"
#import "HCMtalkShopingCell.h"

#import "HCMyMtalkShoping.h"

@interface HCMtalkShopingController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation HCMtalkShopingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"M-Talk商城";
    [self setupBackItem];
    self.view.backgroundColor = kHCBackgroundColor;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:IMG(@"User name") style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self.view addSubview:self.collectionView];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor=kHCNavBarColor;
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}

#pragma mark --- collectionDelegate

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCMtalkShopingCell *cell = [HCMtalkShopingCell costomCellWithCollectionView:collectionView indexPath:indexPath];
    cell.info = self.dataArr[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


#pragma mark --- private mothods

-(void)rightClick:(UIBarButtonItem *)right
{
    HCMyMtalkShoping *myVC = [[HCMyMtalkShoping alloc]init];
    [self.navigationController pushViewController:myVC animated:YES];

}

#pragma mark --- getter Or setter


- (UICollectionView *)collectionView
{
    if(!_collectionView){
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-10)/2, 250/668.0*SCREEN_HEIGHT);

        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource =self;
        
        _collectionView.backgroundColor = kHCBackgroundColor;
        
        [_collectionView registerClass:[HCMtalkShopingCell class] forCellWithReuseIdentifier:@"mtablkCell"];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}



-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCProductDetailController *productDetailVC = [[HCProductDetailController alloc]init];
    productDetailVC.data = @{@"info":self.dataArr[indexPath.row]};
    [self.navigationController pushViewController:productDetailVC animated:YES];

}


- (NSMutableArray *)dataArr
{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
        
        for (int i = 0; i<30; i++) {
            
            HCMtalkShopingInfo *info = [[HCMtalkShopingInfo alloc]init];
            info.title = [NSString stringWithFormat:@"套餐%d M-talk二维码标签10张+M-talk烫印机1个",i];
            info.price = @"9.9";
            info.discount = @"满一百减二十";
            
            [_dataArr addObject:info];
        }
        
        
        
    }
    return _dataArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
