//
//  HCPromisedAddCallMessage.m
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedAddCallMessageAPI.h"

@implementation HCPromisedAddCallMessageAPI

-(void)startRequest:(HCPromisedCreateCallBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"AnyCall/AnyCall.ashx";
}

-(id)requestArgument
{
    NSDictionary * head = @{@"Action" : @"Create",
                           @"Token" : _Token,
                           @"UUID":[HCAppMgr manager].uuid};
     NSDictionary *bodyDic = @{@"Head" : head};
    return @{@"json" :[Utils stringWithObject:bodyDic] };
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}


@end
