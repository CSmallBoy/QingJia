
//
//  HCActivateTagApi.m
//  Project
//
//  Created by 朱宗汉 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCActivateTagApi.h"

@implementation HCActivateTagApi

- (void)startRequest:(HCActivateTagApiBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"Label/Label.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action" : @"Active" ,
                           @"Token":[HCAccountMgr manager].loginInfo.Token ,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"LabelGUID": _LabelGUID};
    NSDictionary *bodyDic = @{@"Head" : head, @"Para" : para};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{

    return responseObject;
}
@end
