//
//  HCHomeDetailApi.m
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeDetailApi.h"
#import "HCHomeDetailUserInfo.h"
#import "HCHomeInfo.h"
#import "HCHomeDetailInfo.h"

@implementation HCHomeDetailApi

- (void)startRequest:(HCHomeDetailBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"FamilyTimes/FamilyTimesReply.ashx";
}

- (id)requestArgument
{
    NSString *ParentId = @"";
    NSString *ItemId = @"";
    if (!IsEmpty(_ParentId))
    {
        ParentId = _ParentId;
    }
    if (!IsEmpty(_ItemId))
    {
        ItemId = _ItemId;
    }
    
    NSDictionary *head = @{@"Action": @"GetList",@"Token": [HCAccountMgr manager].loginInfo.Token, @"UUID": [HCAccountMgr manager].loginInfo.UUID, @"PlatForm": [HCAppMgr manager].systemVersion};
    NSDictionary *para = @{@"FTID": _FTID, @"ParentId": ParentId, @"ItemId": ItemId};
    NSDictionary *body = @{@"Head": head, @"Para": para};
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    NSMutableArray *userArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i ++)
    {
        HCHomeDetailUserInfo *userInfo = [[HCHomeDetailUserInfo alloc] init];
        userInfo.uid = [NSString stringWithFormat:@"%@", @(i)];
        userInfo.nickName = @"测试昵称";
        [userArr addObject:userInfo];
    }
    
    NSMutableArray *commentsArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++)
    {
        HCHomeInfo *info = [[HCHomeInfo alloc] init];
        info.HeadImg = @"http://xiaodaohang.cn/2.jpg";
        info.NickName = @"姓名";
        info.CreateTime = [NSString stringWithFormat:@"%@", [Utils transformServerDate:1450430935]];
        info.FTContent = @"#李嬷嬷#回复:TableViewgithu@撒旦 哈哈哈哈#九歌#九邮m旦旦/:dsad旦/::)sss/::~啊是大三的拉了/::B/::|/:8-)/::</::$/链接:http://baidu.com dudl@qq.com";
        [commentsArr addObject:info];
    }
    
    HCHomeDetailInfo *info = [[HCHomeDetailInfo alloc] init];
    info.praiseArr = userArr;
    info.commentsArr = commentsArr;
    
    return info;
}



@end
