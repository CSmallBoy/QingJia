//
//  HCHomePushListViewController.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/10.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCHomePushListViewController.h"
#import "NHCHomepushListApi.h"
#import "HCTimePushListInfo.h"
#import "HCTimePushListCell.h"
#import "NHCHomeClickPushListApi.h"
//时光
#import "HCHomeDetailViewController.h"
//单图
#import "HCHomePictureDetailViewController.h"

@interface HCHomePushListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *pushListArr;

@end

@implementation HCHomePushListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"与我相关";
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Time_Badge"];
    self.navigationController.tabBarItem.badgeValue = nil;
    [self requestPushData];
}
#pragma mark - tableviewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pushListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    HCTimePushListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell== nil) {
        cell = [[HCTimePushListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.info = self.pushListArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCTimePushListInfo *pushInfo = self.pushListArr[indexPath.row];
    if ([pushInfo.type isEqualToString:@"0"] || [pushInfo.type isEqualToString:@"2"])
    {
        [self clickPushListByType:@"0" timesId:pushInfo.timesId contentImageName:pushInfo.contentImageName];
//        HCHomeDetailViewController *vc = [[HCHomeDetailViewController alloc] init];
//        vc.timeID = pushInfo.timesId;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([pushInfo.type isEqualToString:@"1"])
    {
        [self clickPushListByType:@"1'" timesId:pushInfo.timesId contentImageName:pushInfo.contentImageName];
//        HCHomePictureDetailViewController *vc = [[HCHomePictureDetailViewController alloc] init];
//        vc.TimeId = pushInfo.timesId;
//        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - lazyLoading

- (NSMutableArray *)pushListArr
{
    if (_pushListArr == nil)
    {
        _pushListArr = [NSMutableArray array];
    }
    return _pushListArr;
}

#pragma mark - Networking

//请求推送消息
- (void)requestPushData
{
    NHCHomepushListApi *Api = [[NHCHomepushListApi alloc]init];
    [Api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject)
    {
        NSLog(@"%@",responseObject);
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.pushListArr removeAllObjects];
            NSArray *array = responseObject[@"Data"][@"rows"];
            for (NSDictionary *dic in array)
            {
                HCTimePushListInfo *pushInfo = [HCTimePushListInfo mj_objectWithKeyValues:dic];
                [self.pushListArr addObject:pushInfo];
            }
        }
        [self.tableView reloadData];
    }];
}

//点击推送消息
- (void)clickPushListByType:(NSString *)type timesId:(NSString *)timesId contentImageName:(NSString *)contentImageName
{
    NHCHomeClickPushListApi *api = [[NHCHomeClickPushListApi alloc] init];
    api.type = type;
    api.timesId = timesId;
    api.contentImageName = contentImageName;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self requestPushData];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
