//
//  HCPromisedListAPI.m
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedListAPI.h"
#import "HCPromisedListInfo.h"
@implementation HCPromisedListAPI

-(void)startRequest:(HCPromisedListBlock)requestBlock
{
    [super startRequest:requestBlock];
}
- (NSString *)requestUrl
{
    return @"Shop/ObjectInf.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action" : @"GetList" ,
                           @"Token":[HCAccountMgr manager].loginInfo.Token ,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *Result = @{@"Start":@(1000),@"Count":@(20)};
    NSDictionary *bodyDic = @{@"Head" : head, @"Result" : Result};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{
    NSArray  *arrRows = responseObject[@"Data"][@"rows"];
    
    
    NSMutableArray  *ListInfos = [NSMutableArray array];
    
    for (NSDictionary *dic in arrRows) {
        HCPromisedListInfo  *info = [[HCPromisedListInfo alloc]init];
        info.name = dic[@"ObjectXName"];
        info.ObjectId = [dic[@"KeyId"] stringValue];
       
        [ListInfos addObject:info];
    }
    return ListInfos;
}

@end
