//
//  HCPromisedDetailAPI.m
//  Project
//
//  Created by 朱宗汉 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedDetailAPI.h"
#import "HCContactPersonInfo.h"

@implementation HCPromisedDetailAPI

-(void)startRequest:(HCPromisedDetailBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"AnyCall/AnyCall.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action" : @"Get" ,
                           @"Token":[HCAccountMgr manager].loginInfo.Token ,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary  *ParaDic = @{@"CallId" :@(100000001)};// @([_ObjectId intValue])};
    
    
    NSDictionary *bodyDic = @{@"Head" : head, @"Para" : ParaDic};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{
    NSDictionary  *ObjectInf = responseObject[@"Data"][@"ObjectInf"];
    NSDictionary *AnyCallInf = responseObject[@"Data"][@"AnyCallInf"];
    
    HCPromisedDetailInfo  *detailInfo = [HCPromisedDetailInfo mj_objectWithKeyValues:ObjectInf];
    HCPromisedMissInfo * missInfo = [HCPromisedMissInfo mj_objectWithKeyValues:AnyCallInf];
    NSArray *arr = @[detailInfo,missInfo];
    
    return arr;
}


@end
