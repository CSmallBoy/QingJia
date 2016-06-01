//
//  HCMedicalViewController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/3.
//  Copyright © 2016年 com.xxx. All rights reserved.
//————————————————  医疗急救卡  ————————————————

#import "HCMedicalViewController.h"

#import "HCMedicalCell.h"

#import "HCMedicalInfo.h"
#import "HCMedicalFrameIfo.h"

#import "HCGetMedicalApi.h"

@interface HCMedicalViewController ()

@property (nonatomic,strong) HCMedicalFrameIfo  *info;
@property (nonatomic,strong) NSMutableArray   *dataArr;

@end

@implementation HCMedicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"医疗急救卡";
    
    self.dataArr = [[NSMutableArray alloc]init];
    [self requestData];

    self.tableView.tableHeaderView = HCTabelHeadView(1);
    [self setupBackItem];

}


#pragma mark --- tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCMedicalCell *cell = [HCMedicalCell cellWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.info = self.dataArr[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCMedicalFrameIfo *info = self.dataArr[indexPath.row];
    if (info.cellHeight > 44 ) {
        
        return info.cellHeight;
    }else
    {
        return 44;
    }
    
}


#pragma mark --- private mothods

-(void)requestData
{
    if (self.objectId) {
        HCGetMedicalApi *api = [[HCGetMedicalApi alloc]init];
        api.objectId = self.objectId;
        
        [api startRequest:^(HCRequestStatus requestStauts, NSString *message, id respone) {
            
            if (requestStauts == HCRequestStatusSuccess) {
                
                NSDictionary *dic = respone[@"Data"][@"objectInf"];
                
                NSArray *arr = @[dic[@"height"],dic[@"weight"],dic[@"bloodType"],dic[@"allergic"],dic[@"cureCondition"],dic[@"cureNote"]];
                for (int i = 0;i<6 ; i++)
                {
                    HCMedicalFrameIfo  *info = [[HCMedicalFrameIfo alloc]init];
                    info.title = arr[i];
                    [self.dataArr addObject:info];
                }
                
                [self.tableView reloadData];
                
            }
            else
            {
               [self showHUDError:@"该一呼百应没有开放医疗急救卡"];
            }
            
        }];
    }
    else
    {
        
        
        NSArray  *arr =@[_height,_weight,_bloodType,_allergic,_cureCondition,_cureNote];
        for (int i = 0;i<6 ; i++)
        {
            HCMedicalFrameIfo  *info = [[HCMedicalFrameIfo alloc]init];
            info.title = arr[i];
            [self.dataArr addObject:info];
        }
        [self.tableView reloadData];
    }
    
   
    
    
}

#pragma mark --- getter Or setter




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
