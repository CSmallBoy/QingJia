//
//  HCCheckCodeApi.m
//  Project
//
//  Created by 陈福杰 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCCheckCodeApi.h"

@implementation HCCheckCodeApi

- (void)startRequest:(HCCheckCodeBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"User/AuthCode.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = [Utils getRequestHeadWithAction:@"Validate"];
    NSDictionary *para = @{@"PhoneNumber": _PhoneNumber, @"theCode": @(_theCode), @"theType": @(_theType)};
    NSDictionary *body = @{@"Head": head, @"Para": para};
    
    return @{@"json": [Utils stringWithObject:body]};
}


- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"Data"];
}

@end
