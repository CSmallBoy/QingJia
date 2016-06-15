//
//  HCHomeViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/15.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeFamilyViewController.h"
#import "HCHomeDetailViewController.h"
#import "HCShareViewController.h"
#import "HCHomeUserTimeViewController.h"
#import "HCEditCommentViewController.h"
#import "HCHomePictureDetailViewController.h"
#import "MJRefresh.h"
#import "HCWelcomeJoinGradeViewController.h"
#import "HCHomeTableViewCell.h"
#import "HCHomeInfo.h"
#import "HCHomeApi.h"
#import "HCHomeLikeCountApi.h"
//下载 时光的图片
#import "NHCDownLoadManyApi.h"
#import "NHCListOfTimeAPi.h"
//点赞
#import "NHCHomeLikeApi.h"
#import "HCCreateGradeViewController.h"
//通知button  视图
#import "HCHomeNotiButton.h"
//与我相关的评论列表
#import "HCHomePushListViewController.h"


#define HCHomeCell @"HCHomeTableViewCell"

@interface HCHomeFamilyViewController ()<HCHomeTableViewCellDelegate>{
    NSMutableArray *arr_image_all;
    //下拉加载 用到的m
    int m;
    BOOL AccordingTo;
    
    
}

@property (nonatomic, strong) NSString *start;
@property (nonatomic, assign) NSIndexPath *inter;
@property (nonatomic, strong) HCWelcomeJoinGradeViewController *welcomJoinGrade;

@end

@implementation HCHomeFamilyViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    arr_image_all = [NSMutableArray array];
    [self readLocationData];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self.tableView registerClass:[HCHomeTableViewCell class] forCellReuseIdentifier:HCHomeCell];
    
    //self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHomeData)];
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHomeData)];
    // 设置普通状态的动画图片
    
    NSArray *images1 = @[IMG(@"refresh_00"),IMG(@"refresh_11"),IMG(@"refresh_22")];
    NSArray *images2 = @[IMG(@"refresh_00"),IMG(@"refresh_11"),IMG(@"refresh_22")];
    
    [header setImages:images1 forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:images2 forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:images1 forState:MJRefreshStateRefreshing];
    // 设置header2
    self.tableView.mj_header = header;
    //上拉刷新
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreHomeData)];
    // 设置刷新图片
    [footer setImages:images1 forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = footer;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestHomeData) name:@"刷新数据所有" object:nil];
    AccordingTo = YES;
    //推送消息显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuxin) name:@"timePushUI" object:nil];

}
-(void)shuxin{
    AccordingTo = NO;
    [self readLocationData];
}
- (void)viewWillAppear:(BOOL)animated
{
    m = 0;
    _inter=nil;
    [super viewWillAppear:animated];
    [self requestHomeData];
    [self.tableView reloadData];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCHomeCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    cell.delegate = self;
    HCHomeInfo *info = self.dataSource[indexPath.section];
    if (IsEmpty(_inter)) {
        
    }else{
        if (indexPath.section == _inter.section) {
            info.isLike = @"1";
        }
    }
    cell.info = info;
    return cell;
}
//时光详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCHomeInfo *info = self.dataSource[indexPath.section];
    HCHomeDetailViewController *detail = [[HCHomeDetailViewController alloc] init];
    detail.islikeArr = info.isLikeArr;
    detail.data = @{@"data": info};
    detail.timeID = info.TimeID;
    
    NSDictionary *dict = [readUserInfo getReadDic];
    NSString *user = dict[@"UserInf"][@"userId"];
    if ([info.creator isEqualToString:user]) {
        detail.MySelf = @"我自己的时光";
    }
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 60 + WIDTH(self.view)*0.15;
    HCHomeInfo *info = self.dataSource[indexPath.section];
    height = height + [Utils detailTextHeight:info.FTContent lineSpage:4 width:WIDTH(self.view)-20 font:14];
    if (!IsEmpty(info.FTImages))
    {
        if (info.FTImages.count < 5)
        {
            NSInteger row = ((int)info.FTImages.count/3) + 1;
            if (info.FTImages.count==3) {
                row = 1;
            }
            height += WIDTH(self.view) * 0.33 * row;
        }else
        {
            NSInteger row = ((int)MIN(info.FTImages.count, 9)/3.5) + 1;
            height += WIDTH(self.view) * 0.33 * row;
        }
    }
    //每一次和你分开，我深深地被你打败 采用info.openAddress
//    if (!IsEmpty(info.CreateAddrSmall))
//    {
//        height = height + 30;
//    }
    if ([info.openAddress isEqualToString:@"1"]) {
        height = height + 30;
    }
    
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view_notification = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.25, 0, SCREEN_WIDTH*0.36, 50)];
    if (section==0) {
        //根据推送  显示   隐藏
        view_notification.backgroundColor = [UIColor whiteColor];
        HCHomeNotiButton *button = [[HCHomeNotiButton alloc]init];
        NSInteger messageNum = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Time_Badge"] integerValue];
        button.message_num.text = [NSString stringWithFormat:@"%ld条新消息", messageNum];
        button.headimage.image = IMG(@"1");
        button.backgroundColor = [UIColor darkGrayColor];
        ViewRadius(button, 5);
        [button setFrame:CGRectMake(SCREEN_WIDTH/3, 10, SCREEN_WIDTH/3, 33)];
        [view_notification addSubview:button];
        [button addTarget:self action:@selector(changeViewCon) forControlEvents:UIControlEventTouchUpInside];
        if (AccordingTo) {
            view_notification.hidden = YES;
        }else{
            view_notification.hidden = NO;
        }
    }
    return view_notification;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        NSInteger messageNum = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Time_Badge"] integerValue];
        if (messageNum == 0) {
            return 1;
        }else{
            return 50;
        }
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - HCHomeTableViewCellDelegate 功能 都是点击事件
//功能 都是点击事件
- (void)hcHomeTableViewCell:(HCHomeTableViewCell *)cell indexPath:(NSIndexPath *)indexPath functionIndex:(NSInteger)index
{
    HCHomeInfo *info = self.dataSource[indexPath.section];
    if (index == 2)
    {
        //评论界面
        HCEditCommentViewController *editComment = [[HCEditCommentViewController alloc] init];
        editComment.data = @{@"data": info};
        UIViewController *rootController = self.view.window.rootViewController;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            editComment.modalPresentationStyle=
            UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
        }else
        {
            rootController.modalPresentationStyle=
            UIModalPresentationCurrentContext|UIModalPresentationFullScreen;
        }
        [rootController presentViewController:editComment animated:YES completion:nil];
    }else if (index == 1){
        HCShareViewController  *shareVC = [[HCShareViewController alloc] init];
        shareVC.timeId = info.TimeID;
        [self presentViewController:shareVC animated:YES completion:nil];
    }else if (index == 0)
    {//     点赞触发的方法
        [self requestLikeCount:info indexPath:indexPath];
    }
}
#pragma mark  图片详情
- (void)hcHomeTableViewCell:(HCHomeTableViewCell *)cell indexPath:(NSIndexPath *)indexPath moreImgView:(NSInteger)index
{
    HCHomePictureDetailViewController *pictureDetail = [[HCHomePictureDetailViewController alloc] init];
    pictureDetail.data = @{@"data": self.dataSource[indexPath.section], @"index": @(index)};
    pictureDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pictureDetail animated:YES];
}
#pragma mark 个人时光详情
- (void)hcHomeTableViewCell:(HCHomeTableViewCell *)cell indexPath:(NSIndexPath *)indexPath seleteHead:(UIButton *)headBtn
{
    HCHomeInfo *info = self.dataSource[indexPath.section];
    HCHomeUserTimeViewController *userTime = [[HCHomeUserTimeViewController alloc] init];
    userTime.data = @{@"data": info};
    userTime.userID = info.creator;
    userTime.hidesBottomBarWhenPushed = YES;
  
    
    [self.navigationController pushViewController:userTime animated:YES];
}

#pragma mark - 时光评论列表
- (void)changeViewCon{
    NSLog(@"跳转了");
    AccordingTo  = YES;
    [self.tableView reloadData];
    HCHomePushListViewController *vc = [[HCHomePushListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - private methods 加载数据 保存数据 写入数据

- (void)readLocationData
{
    NSString *path = [self getSaveLocationDataPath];
    NSArray *arrayData = [NSArray arrayWithContentsOfFile:path];
    
    [self.dataSource addObjectsFromArray:[HCHomeInfo mj_objectArrayWithKeyValuesArray:arrayData]];
    [self.tableView reloadData];
    [self requestHomeData];
}

- (NSString *)getSaveLocationDataPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"homedata.plist"];
}

- (void)writeLocationData:(NSArray *)array
{
    NSString *path = [self getSaveLocationDataPath];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    for (NSInteger i = 0; i < array.count; i++)
    {
        HCHomeInfo *info = array[i];
        NSDictionary *dic = [info mj_keyValues];
        [arrayM addObject:dic];
    }
    [arrayM writeToFile:path atomically:YES];
}

#pragma mark - setter or getter 视图创建

- (void)setGradeId:(NSString *)gradeId
{
    if (!IsEmpty(gradeId))
    {
        _welcomJoinGrade = [[HCWelcomeJoinGradeViewController alloc] init];
        _welcomJoinGrade.gradeId = [NSString stringWithFormat:@"欢迎加入%@班级", gradeId];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIViewController *rootController = window.rootViewController;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            _welcomJoinGrade.modalPresentationStyle=
            UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
        }else
        {
            rootController.modalPresentationStyle=
            UIModalPresentationCurrentContext|UIModalPresentationFullScreen;
        }
        [_welcomJoinGrade setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [rootController presentViewController:_welcomJoinGrade animated:YES completion:nil];
    }
}

#pragma mark - network  网络请求

//上啦刷新  
- (void)requestHomeData
{
    NHCListOfTimeAPi *api = [[NHCListOfTimeAPi alloc]init];
    api.start_num = @"0";
    api.home_conut = @"10";
    [api startRequest:^(HCRequestStatus resquestStatus, NSString *message, id Data) {
        if (resquestStatus == HCRequestStatusSuccess) {
            [self.tableView.mj_header endRefreshing];
            [self.dataSource removeAllObjects];
            [self writeLocationData:Data];
            [self.dataSource addObjectsFromArray:Data];
            [self.tableView reloadData];
        }else{
            [self showHUDError:message];
        }
      ;
    }];
    _baseRequest = api;
}
//更多数据  下拉加载
- (void)requestMoreHomeData
{
    NHCListOfTimeAPi *api = [[NHCListOfTimeAPi alloc] init];
    api.start_num = [NSString stringWithFormat:@"%d",10 * (m+1)];
    api.home_conut = [ NSString stringWithFormat:@"%d",10];
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        [self.tableView.mj_footer endRefreshing];
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataSource addObjectsFromArray:array];
            [self writeLocationData:array];
            [self.tableView reloadData];
            m ++;
            if (IsEmpty(array)) {
                [self showHUDText:@"没有更多数据了"];
            }
            
        }else
        {
            [self showHUDError:message];
        }
    }];
}

// 请求点赞
- (void)requestLikeCount:(HCHomeInfo *)info indexPath:(NSIndexPath *)indexPath
{
    _inter = indexPath;
    NHCHomeLikeApi *api = [[NHCHomeLikeApi alloc]init];
    api.TimeID = info.TimeID;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
        if (requestStatus == 401) {
            [self showHUDText:@"您已经点过赞了,请刷新"];
        }
        [self requestHomeData];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }];
    //    HCHomeLikeCountApi *api = [[HCHomeLikeCountApi alloc] init];
    //    api.TimesId = info.KeyId;
    //    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id responseObject) {
    //        if (requestStatus == HCRequestStatusSuccess)
    //        {
    //            info.FTLikeCount = [NSString stringWithFormat:@"%@", @([info.FTLikeCount integerValue]+1)];
    //            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    //        }else
    //        {
    //            [self showHUDError:message];
    //        }
    //    }];
    
}



@end
