//
//  HCPromisedTagMangerViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//


#import "HCTagUserMangerViewController.h"
#import "HCPromiseDetailViewController1.h"
#import "HCTagUserDetailController.h"

#import "HCTagUserCell.h"

#import "HCNewTagInfo.h"

#import "HCObjectListApi.h"
#import "HCTagDeleteObjectApi.h"

@interface HCTagUserMangerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong) UICollectionView  *collectionView;
@property (nonatomic,strong) NSMutableArray   *dataArr;
@property (nonatomic,strong) HCNewTagInfo *deleteInfo;
@end

@implementation HCTagUserMangerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"标签试用者管理";
    [self  setupBackItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.collectionView];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

#pragma mark ---UICollectionViewDataSource,UICollectionViewDelegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCTagUserCell *cell = [HCTagUserCell cellWithCollectionView:collectionView andIndexPath:indexPath];
 
    HCNewTagInfo *info = self.dataArr[indexPath.row];
        cell.info =info;
   
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [cell addGestureRecognizer:longPress];
    return cell;
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
    HCTagUserDetailController *detailVC = [[HCTagUserDetailController alloc]init];
    HCNewTagInfo *info = self.dataArr[indexPath.row];
    detailVC.data = @{@"info":info};
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark --- UIAlertViewdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
       
        
    }
    else
    {
        HCTagDeleteObjectApi *api = [[HCTagDeleteObjectApi alloc]init];
        api.objectId = self.deleteInfo.objectId;
        
        [api startRequest:^(HCRequestStatus requestStaus, NSString *message, id respone) {
           
            if (requestStaus == HCRequestStatusSuccess)
            {
                [self.dataArr removeObject:self.deleteInfo];
                [self.collectionView reloadData];
            }
            
        }];
    }
}

#pragma mark --- private mothods

// 点击了右边的Item
-(void)rightItemClick:(UIBarButtonItem *)item

{

    HCNewTagInfo *info = [[HCNewTagInfo alloc]init];
    HCTagUserDetailController *detailVC = [[HCTagUserDetailController alloc]init];
    detailVC.data = @{@"info":info};
    [self.navigationController pushViewController:detailVC animated:YES];
   
}

-(void)longPress:(UILongPressGestureRecognizer *)longP
{
    
    if (longP.state == UIGestureRecognizerStateBegan) {
        HCTagUserCell *cell = (HCTagUserCell *)longP.view;
        self.deleteInfo = cell.info;
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除此标签使用者" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
    
    }
    

}


#pragma mark --- getter Or setter

- (UICollectionView *)collectionView
{
    if(!_collectionView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3-10,SCREEN_WIDTH/3-10);
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource =self;
        
        [_collectionView registerClass:[HCTagUserCell class] forCellWithReuseIdentifier:@"TagCellID"];
        
    }
    return _collectionView;
}

-(NSMutableArray *)dataArr
{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark --- network

-(void)requestData
{
    HCObjectListApi *api = [[HCObjectListApi alloc]init];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataArr removeAllObjects];
            NSArray *array = respone [@"Data"][@"rows"];
            
            for (NSDictionary *dic in array) {
                HCNewTagInfo *info = [HCNewTagInfo mj_objectWithKeyValues:dic];
                [self.dataArr addObject:info];
                [self.collectionView reloadData];
            }
            
        }
        else
        {
            [self showHUDError:@"请求数据失败"];
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
