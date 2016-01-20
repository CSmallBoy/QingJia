//
//  HCLogisticsApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/25.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCLogisticsApi.h"


#import "HCLogisticsInfo.h"

@implementation HCLogisticsApi

- (void)startRequest:(HCLogisticsBlock)requestBlock
{
    [super startRequest:requestBlock];
}

//- (id)requestArgument
//{
//    return @{@"t": @"User,logout", @"token": @"23"};
//}

//测试
- (NSString *)requestUrl
{
    return @"HelpCase/HelpCase.ashx";
}


- (id)requestArgument
{
    NSDictionary *head = @{@"Action" : @"GetList"};
    
    NSDictionary *result = @{@"Start" : @(1000), @"Count" : @(20)};
    NSDictionary *bodyDic = @{@"Head" : head, @"Result" : result};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
        NSArray *imageNameArr = @[@"redPointAndLine", @"lightGrayPointAndLine1", @"lightGrayPointAndLine1", @"lightGrayPointAndLine1", @"lightGrayPointAndLine1", @"lightGrayPointAndLine1", @"lightGrayPointAndLine1", @"lightGrayPointAndLine1", @"lightGrayPointAndLine1", @"lightGrayPointAndLine2"
                                  ];
        NSArray *titleArr = @[@"我的推荐", @"我的简历", @"我申请的工作", @"我的收藏", @"我的足迹",@"我的推荐", @"我的简历", @"我申请的工作", @"我的收藏", @"我的足迹"];
        NSArray *timeArr = @[@"2015-01-14 08:00:20",@"2015-02-14 08:12:20",@"2015-03-14 08:00:20",@"2015-04-14 08:00:20",@"2015-05-14 08:00:20",@"2015-01-14 08:00:20",@"2015-02-14 08:12:20",@"2015-03-14 08:00:20",@"2015-04-14 08:00:20",@"2015-05-14 08:00:20"];
        
        for (NSInteger i = 0; i < 10; i++)
        {
            HCLogisticsInfo *info = [[HCLogisticsInfo alloc] init];
            info.imageName = imageNameArr[i];
            info.titleText = titleArr[i];
            info.detailText = timeArr[i];
            [arrayM addObject:info];
        }
    return arrayM;
}


@end
