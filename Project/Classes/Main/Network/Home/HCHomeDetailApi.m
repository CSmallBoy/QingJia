//
//  HCHomeDetailApi.m
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeDetailApi.h"
#import "HCHomeDetailUserInfo.h"
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
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
    
    NSMutableArray *userArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i ++)
    {
        HCHomeDetailUserInfo *userInfo = [[HCHomeDetailUserInfo alloc] init];
        userInfo.uid = [NSString stringWithFormat:@"%@", @(i)];
        userInfo.nickName = @"测试昵称";
        [userArr addObject:userInfo];
    }
    HCHomeDetailInfo *info = [[HCHomeDetailInfo alloc] init];
    info.praiseArr = userArr;
    
    [arrayM addObject:info];
    
    return arrayM;
}



@end
