//
//  HCCreateGradeViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCreateGradeViewController.h"
#import "HCGradeSuccessViewController.h"
#import "HCAvatarMgr.h"
#import "HCCreateGradeTableViewCell.h"
#import "HCCreateGradeInfo.h"
#import "HCFooterView.h"

#define HCCreateGrade @"HCCreateGrade"

@interface HCCreateGradeViewController ()<HCFooterViewDelegate>

@property (nonatomic, strong) HCCreateGradeInfo *info;

@property (nonatomic, strong) HCFooterView *footerView;

@end

@implementation HCCreateGradeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"创建班级";
    [self setupBackItem];
    
    _info = [[HCCreateGradeInfo alloc] init];
    
    [self.tableView registerClass:[HCCreateGradeTableViewCell class] forCellReuseIdentifier:HCCreateGrade];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCCreateGradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCCreateGrade];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.info = _info;
    cell.indexPath = indexPath;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5)
    {
        [HCAvatarMgr manager].noUploadImage = YES;

        [[HCAvatarMgr manager] modifyAvatarWithController:self completion:^(BOOL result, UIImage *image, NSString *msg){
            if (result)
            {
                _info.gradeImage = image;
                [self.tableView reloadData];
            }
        }];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5)
    {
        return 150;
    }
    return 50;
}

#pragma mark - HCFooterViewDelegate

- (void)hcfooterViewSelectedButton:(HCFooterViewButtonType)type
{
    if (type == HCFooterViewButtonTypeSave)
    {
        [self checkCreateGradeData];
    }else if (type == HCFooterViewButtonTypeServer)
    {
        DLog(@"服务协议");
    }else if (type == HCFooterViewButtonTypePrivacy)
    {
        DLog(@"隐私政策");
    }
}

#pragma mark - private methods

- (void)checkCreateGradeData
{
    HCGradeSuccessViewController *success = [[HCGradeSuccessViewController alloc] init];
    [self.navigationController pushViewController:success animated:YES];
}

#pragma mark - setter or getter

- (HCFooterView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[HCFooterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 160)];
        _footerView.delegate = self;
    }
    return _footerView;
}

#pragma mark - network 

- (void)requestCreateGrade
{
    
}


@end
