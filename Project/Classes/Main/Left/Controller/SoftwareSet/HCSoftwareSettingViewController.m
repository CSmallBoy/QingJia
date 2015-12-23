//
//  HCSoftwareSettingViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCSoftwareSettingViewController.h"
#import "HCJurisdictionViewController.h"
#import "HCFeedbackViewController.h"
#import "HCFeedbackView.h"
#import "HCAboutMTalkViewController.h"

@interface HCSoftwareSettingViewController ()

@property (nonatomic, strong) NSDictionary *imageNameDic;
@property (nonatomic, strong) NSDictionary *titleDic;
@property (nonatomic, strong) UISwitch *switchs;

@end

@implementation HCSoftwareSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"软件设置";
    [self setupBackItem];
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"sofeware"];
    if (!cell)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"sofeware"];
    }
    
    NSArray *imageNameArr = self.imageNameDic[[NSString stringWithFormat:@"%@", @(indexPath.section+1)]];
    cell.imageView.image = OrigIMG(imageNameArr[indexPath.row]);
    
    NSArray *titleArr = self.titleDic[[NSString stringWithFormat:@"%@", @(indexPath.section+1)]];
    cell.textLabel.text = titleArr[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row ==2)
        {
            UISwitch *switchs = self.switchs;
            [cell.contentView addSubview:switchs];
            switchs.tag = indexPath.row;
        }else if (indexPath.row == 3)
        {
            cell.detailTextLabel.text = @"仅好友可见";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HCViewController *vc = nil;
    if (indexPath.section == 0 && indexPath.row == 3)
    {
        vc = [[HCJurisdictionViewController alloc] init];
    }else if (indexPath.section == 1 && indexPath.row == 0)
    {
        vc = [[HCFeedbackViewController alloc] init];
    }else if (indexPath.section == 1 && indexPath.row == 2)
    {
        vc = [[HCAboutMTalkViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.imageNameDic[[NSString stringWithFormat:@"%@", @(section+1)]];
    return array.count;
}

#pragma mark - setter or getter

- (NSDictionary *)imageNameDic
{
    if (!_imageNameDic)
    {
        _imageNameDic = @{@"1":@[@"airplane", @"seting_Locate", @"Network", @"permission", @"delete"], @"2": @[@"Feedback", @"Recommend", @"about_mtalk"]};
    }
    return _imageNameDic;
}

- (NSDictionary *)titleDic
{
    if (!_titleDic)
    {
        _titleDic = @{@"1": @[@"消息推送提醒", @"默认定位设置", @"允许2G/3G/4G网络上传图片", @"默认权限设置", @"清除缓存"], @"2": @[@"反馈建议", @"推荐给好友", @"关于M-Talk"]};
    }
    return _titleDic;
}

- (UISwitch *)switchs
{
    _switchs = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH(self.view)-60, 10, 30, 30)];
    return _switchs;
}


@end
