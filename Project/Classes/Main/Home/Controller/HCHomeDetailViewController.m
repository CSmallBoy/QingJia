//
//  HCHomeDetailViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeDetailViewController.h"
#import "HCHomeDetailTableViewCell.h"
#import "HCHomeDetailInfo.h"
#import "HCHomeDetailUserInfo.h"
#import "HCHomeInfo.h"
#import "HCHomeDetailApi.h"

#define HCHomeDetailCell @"HCHomeDetailTableViewCell"

@interface HCHomeDetailViewController ()

@property (nonatomic, strong) HCHomeDetailInfo *detailInfo;
@property (nonatomic, assign) CGFloat praiseHeight;

@end

@implementation HCHomeDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"时光详情";
    [self setupBackItem];
    
    [self requestHomeDetail];
    
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self.tableView registerClass:[HCHomeDetailTableViewCell class] forCellReuseIdentifier:HCHomeDetailCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCHomeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCHomeDetailCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.praiseHeight = _praiseHeight;
    
    cell.detailInfo = _detailInfo;
    
    HCHomeInfo *info = self.data[@"data"];
    cell.info = info;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (IsEmpty(_detailInfo))
    {
        return 0;
    }
    return (section) ? _detailInfo.commentsArr.count : 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 30 + WIDTH(self.view)*0.15;
    
    HCHomeInfo *info = self.data[@"data"];
    
    height = height + [Utils detailTextHeight:info.contents lineSpage:4 width:WIDTH(self.view)-20 font:14];
    
    if (!IsEmpty(info.imgArr))
    {
        height = height + (WIDTH(self.view)-40)/3 + 13;
    }
    
    if (!IsEmpty(_detailInfo.praiseArr))
    {
        height = height + [self getPraiseHeight];
    }
    
    return height;
}

- (CGFloat)getPraiseHeight
{
    CGRect previousFrame = CGRectMake(10, 0, WIDTH(self.view)-20, 0);
    CGFloat totalHeight = 0;
    
    NSArray *array = _detailInfo.praiseArr;
    
    for (NSInteger i = 0; i < array.count; i++)
    {
        HCHomeDetailUserInfo *info = _detailInfo.praiseArr[i];
        
        NSString *title = nil;
        if (i != _detailInfo.praiseArr.count - 1)
        {
            title = [NSString stringWithFormat:@"%@、", info.nickName];
        }else
        {
            title = info.nickName;
        }
        
        NSDictionary *attriDic = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        CGSize size_value = [title sizeWithAttributes:attriDic];
        size_value.width ++;
        size_value.height ++;
        
        CGRect newRect = CGRectZero;
        
        if (previousFrame.origin.x+previousFrame.size.width+size_value.width > WIDTH(self.view)-20)
        {
            newRect.origin = CGPointMake(0, previousFrame.origin.y + size_value.height);
            totalHeight += size_value.height ;
        }
        else
        {
            newRect.origin = CGPointMake(previousFrame.origin.x+previousFrame.size.width, previousFrame.origin.y);
        }
        
        newRect.size = size_value;
        previousFrame = newRect;
        
        _praiseHeight = totalHeight;
    }
    return _praiseHeight;
}

#pragma mark - network

- (void)requestHomeDetail
{
    [self showHUDView:nil];
    
    HCHomeDetailApi *api = [[HCHomeDetailApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, HCHomeDetailInfo *info) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            [self.dataSource removeAllObjects];
            _detailInfo = info;
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}


@end
