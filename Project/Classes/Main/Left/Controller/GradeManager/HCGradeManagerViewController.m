//
//  HCGradeManagerViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCGradeManagerViewController.h"
#import "HCCodeLookViewController.h"
#import "HCCheckViewController.h"
#import "HCGradeManagerTableViewCell.h"
#import "HCFriendMessageInfo.h"
#import "HCAddFriendViewController.h"
#import "UIImageView+WebCache.h"
#import "HCFriendMessageApi.h"
#import "HCCreateGradeInfo.h"
#import "sigleFamilyMessage.h"

static NSString * const reuseIdentifier = @"FriendCell";

@interface HCGradeManagerViewController ()<HCGradeManagerTableViewCellDelegate>

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *signatureLabel;
@property (nonatomic,strong) HCCreateGradeInfo *info;

@end

@implementation HCGradeManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"家庭名字";
    [self setupBackItem];
    self.tableView.tableHeaderView = self.headImageView;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self requestGradeManager];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCGradeManagerTableViewCell *cell = [[HCGradeManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.array = self.dataSource;
    cell.info = _info;
    cell.image = IMG(@"1");
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCViewController *vc = nil;
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        vc = [[HCCodeLookViewController alloc] init];
        vc.data = @{@"info":self.info};
    }else if (indexPath.section == 1 && indexPath.row == 0)
    {
        vc = [[HCCheckViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section) ? 2 : 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section && indexPath.row)
    {
        NSInteger row = self.dataSource.count/4;
        if (self.dataSource.count%4)
        {
            row++;
        }
        return row*(WIDTH(self.view)*0.2+30);
    }else
    {
        return 44;
    }
}

#pragma mark - HCGradeManagerTableViewCellDelegate

- (void)HCGradeManagerTableViewCellSelectedTag:(NSInteger)tag
{
    if (tag == self.dataSource.count-1)
    {
        DLog(@"添加了添加按钮");
    }else
    {
        HCFriendMessageInfo *info = self.dataSource[tag];
        DLog(@"点击了某个人---%@", info.nickName);
    }
}

#pragma mark - private methods


#pragma mark - setter or getter

- (UIImageView *)headImageView
{
    if (!_headImageView)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), WIDTH(self.view)*0.5)];
        _headImageView.image = OrigIMG(@"head.jpg");
        [_headImageView addSubview:self.signatureLabel];
    }
    return _headImageView;
}

- (UILabel *)signatureLabel
{
    if (!_signatureLabel)
    {
        _signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT(self.headImageView)-30, WIDTH(self.view), 30)];
        _signatureLabel.textAlignment = NSTextAlignmentCenter;
        _signatureLabel.font = [UIFont systemFontOfSize:15];
        _signatureLabel.numberOfLines = 0;
        _signatureLabel.text = @"我们的家庭签名~！";
        _signatureLabel.textColor = [UIColor whiteColor];
    }
    return _signatureLabel;
}

#pragma mark - network

- (void)requestGradeManager
{
    
    sigleFamilyMessage *api = [[sigleFamilyMessage alloc]init];
    api.familyId = [HCAccountMgr manager].loginInfo.createFamilyId;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSDictionary *dic = respone[@"Data"][@"FamilyInf"];
            self.info = [HCCreateGradeInfo  mj_objectWithKeyValues:dic];
            
        }
        
        NSArray *array = respone[@"Data"][@"row"];
        
        [self.dataSource removeAllObjects];
        
        for (NSDictionary *dic in array)
        {
            HCFriendMessageInfo *friendInfo = [[HCFriendMessageInfo alloc]init];
            friendInfo.userId = dic[@"userId"];
            friendInfo.nickName = dic[@"nickName"];
            
            [self.dataSource addObject:friendInfo];
            
        }
        
        [self.tableView reloadData];
    }];
}


@end
