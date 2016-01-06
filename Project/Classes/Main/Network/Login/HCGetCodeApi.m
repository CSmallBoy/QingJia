//
//  HCGetCodeApi.m
//  Project
//
//  Created by 陈福杰 on 16/1/4.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCGetCodeApi.h"

@implementation HCGetCodeApi

- (void)startRequest:(HCGetCodeBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"User/AuthCode.ashx";
}

- (id)requestArgument
{
    
    NSDictionary *head = [Utils getRequestHeadWithAction:@"ReGet"];
    NSDictionary *para = @{@"PhoneNumber": _phoneNumber, @"theType": @(_thetype)};
    NSDictionary *bodyDic = @{@"Head": head, @"Para": para};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"Data"];
}

@end
