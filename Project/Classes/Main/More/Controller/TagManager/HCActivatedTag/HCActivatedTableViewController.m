//
//  HCActivatedTableViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/27.
//  Copyright © 2015年 com.xxx. All rights reserved.
//------------------------已激活界面------------------------------------

#import "HCActivatedTableViewController.h"
#import "HCTagManagerDetailViewController.h"

#import "HCTagManagerInfo.h"
#import "HCTagManagerApi.h"

#import "HCTagAmostDetailListApi.h"
#import "HCTagManagerHeader.h"
#import "HCTagManagerTableViewCell.h"

#define activatedcell @"activatedcell"
@interface HCActivatedTableViewController ()<HCTagManagerTableViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *categoryArray;
@end

@implementation HCActivatedTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requestHomeData];
    [self.tableView registerClass:[HCTagManagerTableViewCell class] forCellReuseIdentifier:activatedcell];

}

#pragma mark---UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCTagManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:activatedcell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    HCTagManagerInfo *info = self.dataSource[indexPath.section];
    cell.info = info;
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark--UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREEN_WIDTH - 60)/3 +50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HCTagManagerHeader *header = [[HCTagManagerHeader alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 60)];
    if (section == 0) [self.categoryArray removeAllObjects];
    [self.categoryArray addObject:header];
    HCTagManagerInfo *info = self.dataSource[section];
    header.titleString = info.tagUserName;
    header.tag = section;
    [header addTarget:self action:@selector(handleHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
    if (info.isShowRow)
    {
        header.markImgView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HCTagManagerInfo *info = self.dataSource[section];
    if (info.isShowRow)
    {
        NSInteger count = info.imgArr.count % 3;
        NSInteger row = (count) ? 1 : 0;
        return ((int)info.imgArr.count/3) + row;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

#pragma mark---HCTagManagerTableViewCellDelegate

-(void)HCTagManagerTableViewCell:(NSIndexPath *)indexPath tag:(NSInteger)tag
{
    NSInteger index = tag+indexPath.row*3;
    HCTagManagerInfo *info = self.dataSource[indexPath.section];
    
    HCTagManagerDetailViewController *detailVC = [[HCTagManagerDetailViewController alloc]init];
    detailVC.data = @{@"data":info};
    detailVC.index = index;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - private methods

- (void)handleHeaderButton:(HCTagManagerHeader *)headerBtn
{
    HCTagManagerInfo *info = self.dataSource[headerBtn.tag];
    info.isShowRow = !info.isShowRow;
    [self.tableView reloadData];
}

#pragma  mark---Setter Or Getter

- (NSMutableArray *)categoryArray
{
    if (!_categoryArray)
    {
        _categoryArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _categoryArray;
}

#pragma mark - network

- (void)requestHomeData
{

    HCTagAmostDetailListApi *api = [[HCTagAmostDetailListApi alloc]init];
    api.labelStatus = @"0";
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        if (requestStatus == HCRequestStatusSuccess) {
            
            
            NSArray *oldArr = respone[@"Data"][@"rows"];
            
            
            
            NSMutableArray *smallArr = [NSMutableArray array];
            NSMutableArray *bigArr = [NSMutableArray array];
            
            [bigArr addObject:smallArr];
            
            for (int i = 0; i<oldArr.count; i++)
            {
                if (i == 0)
                {
                    [smallArr addObject:oldArr[i]];
                    
                }
                else
                {
                    for (int j = 0; j<bigArr.count; j++)
                    {
                        
                        NSString *bigStr =bigArr[j][0][@"trueName"];
                        NSString *oldStr =oldArr[i][@"trueName"];
                        
                        if ([bigStr isEqualToString:oldStr])
                        {
                            [bigArr[j] addObject:oldArr[i]];
                            break;
                            
                            
                        }else
                        {
                            if (j == bigArr.count-1)
                            {
                                NSMutableArray *newArr = [NSMutableArray array];
                                [newArr addObject:oldArr[i]];
                                [bigArr addObject:newArr];
                                break;
                            }
                            
                        }
                    }
                }
            }
            
            NSLog(@"%@",bigArr);
            
            for (int i = 0; i<bigArr.count; i++) {
                NSArray *smallArr = bigArr[i];
                HCTagManagerInfo *info = [[HCTagManagerInfo alloc] init];
                info.tagUserName = [NSString stringWithFormat:@"%@",smallArr[0][@"trueName"]];
                NSMutableArray *tagNameArr =[NSMutableArray array];
                
                for (int j = 0; j<smallArr.count; j++) {
                    [tagNameArr addObject:smallArr[j][@"labelTitle"] ];
                }
                info.tagNameArr = tagNameArr;
                
                NSMutableArray *imgArr = [NSMutableArray array];
                for (int  k = 0; k<smallArr.count; k++) {
                    [imgArr addObject:@"time_picture"];
                }
                info.imgArr = imgArr;
                
                [self.dataSource addObject:info];
                [self.tableView reloadData];
            }
            
            NSLog(@"*********标签概要信息列表*************");
        }
    }];
    
//    for (int i = 0; i<4; i++) {
//
//        HCTagManagerInfo *info = [[HCTagManagerInfo alloc] init];
//
//        info.tagUserName = [NSString stringWithFormat:@"王一%d",i];
//        info.imgArr = @[@"time_picture",@"time_picture",@"time_picture",@"time_picture"];
//        info.tagNameArr = @[@"衬衣上的1号标签",@"书包上的2号标签",@"裤子上的3号标签",@"帽子上的4号标签"];
//        info.tagIDArr = @[@"111111",@"222222",@"333333",@"444444"];
//        info.contactImgArr = @[@"cards_but_phone",@"cards_but_phone"];
//        info.contactNameArr = @[@"周一",@"王大"];
//        info.contactRelationShipArr = @[@"母亲",@"父亲"];
//        info.contactPhoneArr = @[@"11111111111",@"22222222222"];
//        info.cardName = @"我是谁";
//        info.cardImg = @"label";
//        info.userGender = @"男";
//        info.userAge = @"15";
//        info.userBrithday = @"2015-12-12";
//        info.userAddress = @"上海市闵行区梅陇镇集心路168号4号楼201室";
//        info.userSchool = @"闵行中心第一小学";
//        info.userJob = @"学生";
//        info.userHealth = @"健康";
//        
//        [self.dataSource addObject:info];
//
//    }
    
    
}


@end
