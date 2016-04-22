//
//  HCPromisedTagMangerViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//


#import "HCPromiedTagWhenMissController.h"
#import "HCPromiseDetailViewController1.h"
#import "HCPromisedMissMessageControll.h"

#import "HCPromisedTagCell.h"
#import "HCTagAmostDetailListApi.h"
#import "HCNewTagInfo.h"

@interface HCPromiedTagWhenMissController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView  *collectionView;


@property (nonatomic,strong) UIView *footerView;
@end

@implementation HCPromiedTagWhenMissController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"走失时候佩戴的标签";
//    [self requestData];
    [self  setupBackItem];
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.footerView];
    
    
}

#pragma mark ---UICollectionViewDataSource,UICollectionViewDelegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCPromisedTagCell *cell = [HCPromisedTagCell cellWithCollectionView:collectionView andIndexPath:indexPath];
    cell.info = self.dataArr[indexPath.row];
    
    return cell;
}
//
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
    
    HCNewTagInfo *info = self.dataArr[indexPath.row];
    
    if (info.isBlack) {
        info.isBlack = NO;
    }
    else
    {
        info.isBlack = YES;
    }
    [self.collectionView reloadData];
}

#pragma  mark --- private mothods
// 点击了下一步按钮
-(void)toNextVC
{
    HCPromisedMissMessageControll*vc = [[HCPromisedMissMessageControll alloc]init];
    NSMutableArray *tagArr = [NSMutableArray array];
    
    for (HCNewTagInfo *info in self.dataArr) {
        
        if (info.isBlack) {
            [tagArr addObject:info];
        }
        
    }
    vc.info = self.info;
    vc.tagArr = tagArr;
    vc.contactArr = self.contactArr;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark --- getter Or setter

- (UICollectionView *)collectionView
{
    if(!_collectionView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3-10,SCREEN_WIDTH/3);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) collectionViewLayout:flowLayout];
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


- (UIView *)footerView
{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 5, SCREEN_WIDTH-40, 40);
        ViewRadius(button, 5);
        button.backgroundColor = kHCNavBarColor;
        [button setTitle:@"下一步" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toNextVC) forControlEvents:UIControlEventTouchUpInside ];
        [_footerView addSubview:button];
        
    }
    return _footerView;
}


#pragma mrk --- network

-(void)requestData
{
    HCTagAmostDetailListApi *api = [[HCTagAmostDetailListApi alloc]init];
    api.labelStatus = @"0";// 已经激活的标签
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess) {
            
            NSArray *array = respone[@"Data"][@"rows"];
            for (NSDictionary *dic in array) {
                HCNewTagInfo *info = [HCNewTagInfo mj_objectWithKeyValues:dic];
                [self.dataArr addObject:info];
            }
            [self.collectionView reloadData];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
