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

- (id)requestArgument
{
    return @{@"t": @"User,logout", @"token": @"23"};
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
        info.imgName = @"http://xiaodaohang.cn/2.jpg";
        info.nickName = @"姓名";
        info.inputtime = [NSString stringWithFormat:@"%@", [Utils transformServerDate:1450430935]];
        info.comments = @"#李嬷嬷#回复:TableViewgithu@撒旦 哈哈哈哈#九歌#九邮m旦旦/:dsad旦/::)sss/::~啊是大三的拉了/::B/::|/:8-)/::</::$/链接:http://baidu.com dudl@qq.com";
        [commentsArr addObject:info];
    }
    
    HCHomeDetailInfo *info = [[HCHomeDetailInfo alloc] init];
    info.praiseArr = userArr;
    info.commentsArr = commentsArr;
    
    return info;
}



@end
