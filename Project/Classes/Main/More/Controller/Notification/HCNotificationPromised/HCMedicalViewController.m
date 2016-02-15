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
@interface HCMedicalViewController ()

@property (nonatomic,strong) HCMedicalFrameIfo  *info;
@property (nonatomic,strong) NSMutableArray   *dataArr;

@end

@implementation HCMedicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"医疗急救卡";
    
    self.dataArr = [[NSMutableArray alloc]init];
    NSArray  *arr =@[@"120",@"35",@"AB",@"对龙虾等海鲜过敏，另外某些抗生素的药物叶过敏",@"飒飒大嘎嘎啊大大干大事地方 发电公司的分公司阿斯顿噶大概阿达的感受到",@"地方噶的嘎嘎多发发斯蒂芬阿斯顿发送到发送到发送到发达时发生的发生的 发生地方的股份公司分公司大嘎达地方萨芬的"];
    for (int i = 0;i<6 ; i++)
    {
        HCMedicalFrameIfo  *info = [[HCMedicalFrameIfo alloc]init];
        info.title = arr[i];
        [self.dataArr addObject:info];
    }

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
    return 6;
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
    

    
    
}

#pragma mark --- getter Or setter




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
