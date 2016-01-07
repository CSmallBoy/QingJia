//
//  HCPromisedListApi.m
//  Project
//
//  Created by 朱宗汉 on 16/1/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedListApi.h"

@implementation HCPromisedListApi

-(void)startRequest:(HCPrromisedListBlock)requestBlock
{
    [super startRequest:requestBlock];
}


-(NSString *)requestUrl
{
    return @"ObjectInf/ObjectInf.ashx";
}

-(id)requestArgument
{
    NSDictionary  *head = @{@"Action" : @"GetList",
                            @"Token" : _Token,
                            @"UUID" : [HCAppMgr manager].uuid};
    NSDictionary  *body = @{@"Head" : head};
    return @{@"json" : [Utils stringWithObject:body]};
}
@end
