//
//  HCHomePictureDetailViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomePictureDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+MultiFormat.h"
#import "HCHomeInfo.h"
#import "OTCover.h"

#import "HCHomeDetailCommentTableViewCell.h"

#import "HCHomePictureDetailApi.h"

#define HCHomeDetailComment @"HCHomeDetailCommentTableViewCell"

@interface HCHomePictureDetailViewController ()<HCHomeDetailCommentTableViewCellDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, HCOTCoverDelegate>

@property (nonatomic, assign) CGFloat commentHeight;

@property (nonatomic, strong) OTCover *otcover;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HCHomePictureDetailViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"图文详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupBackItem];
    
    [self requestPictureDetail];
    [self setupAnimationHead];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCHomeDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCHomeDetailComment];
    if (!cell)
    {
        cell = [[HCHomeDetailCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HCHomeDetailComment];
    }
    cell.commentBtn.hidden = YES;
    cell.delegate = self;
    cell.info = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _commentHeight + 70;
}

#pragma mark - HCHomeDetailCommentTableViewCellDelegate

- (void)hchomeDetailCommentTableViewCellCommentHeight:(CGFloat)commentHeight
{
    _commentHeight = commentHeight;
    DLog(@"commentHeight--%@", @(_commentHeight));
}

#pragma mark - HCOTCoverDelegate

- (void)hcotcoreSelectedImageView
{
    DLog(@"点击了头部图片");
}

#pragma mark - setter or getter

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - Private methods

- (void)setupAnimationHead
{
    HCHomeInfo *info = self.data[@"data"];
    NSInteger index = [self.data[@"index"] integerValue];
    
    UIImage *image = [UIImage sd_imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:info.imgArr[index]]]];
    self.otcover = [[OTCover alloc] initWithTableViewWithHeaderImage:image withOTCoverHeight:WIDTH(self.view)*0.6];
    self.otcover.delegate = self;
    self.otcover.frame = CGRectMake(0, 64, WIDTH(self.view), HEIGHT(self.view));
    self.otcover.tableView.frame = CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)-64);
    self.otcover.tableView.delegate = self;
    self.otcover.tableView.dataSource = self;
    
    [self.view addSubview:self.otcover];
}

#pragma mark - network

- (void)requestPictureDetail
{
    [self showHUDView:nil];
    
    HCHomePictureDetailApi *api = [[HCHomePictureDetailApi alloc] init];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            [self.otcover.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}


@end
