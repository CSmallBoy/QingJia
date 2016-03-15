//
//  HCPromisedCloseAnyCall.m
//  Project
//
//  Created by 朱宗汉 on 16/3/9.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedCloseAnyCallAPI.h"

@implementation HCPromisedCloseAnyCallAPI

-(void)startRequest:(HCPromisedCloseBlock1)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"AnyCall/AnyCall.ashx";
}


-(id)requestArgument
{
    NSDictionary *head = @{@"Action":@"End",
                           @"Token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *Para =@{@"CallId":@(_CallId)};
    NSDictionary *bodyDic = @{@"Head":head,@"Para":Para};
    
    return @{@"json":[Utils stringWithObject:bodyDic]};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end
