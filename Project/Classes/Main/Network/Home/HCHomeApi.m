//
//  HCHomeApi.m
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeApi.h"
#import "HCHomeInfo.h"

@implementation HCHomeApi

- (void)startRequest:(HCHomeBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"FamilyTimes/FamilyTimes.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action": @"GetList", @"Token": [HCAccountMgr manager].loginInfo.Token, @"UUID": [HCAppMgr manager].uuid};
    NSDictionary *result = @{@"Start":@([_Start integerValue]), @"Count": @(20)};
    NSDictionary *body = @{@"Head": head, @"Result": result};
    
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    // 测试
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i = 0; i < 10; i++)
    {
        HCHomeInfo *info = [[HCHomeInfo alloc] init];
        
        info.KeyId = @"1234567";
        info.NickName = @"测试名字";
        info.FTContent = @"测试发布时光内容";
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger j = 0; j < i; j++)
        {
            NSString *imageStr = [NSString stringWithFormat:@"http://img2.3lian.com/img2007/10/28/%@.jpg", @(120+j)];
            DLog(@"%@", imageStr);
            [array addObject:imageStr];
        }
        
        info.FTImages = array;
        info.CreateAddrSmall = @"上海市浦东新区";
        
        [arrayM addObject:info];
    }
    return arrayM;
    //------
    NSDictionary *dic = responseObject[@"Data"][@"rows"];
    return [HCHomeInfo mj_objectArrayWithKeyValuesArray:dic];
}

@end
