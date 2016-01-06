//
//  HCRescueCenter.m
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRescueCenterApi.h"
#import "HCRescueCenterInfo.h"

@implementation HCRescueCenterApi

-(void)startRequest:(HCResCueCenterBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"HelpCase/HelpCase.ashx";
}


- (id)requestArgument
{
    NSDictionary *head = @{@"Action" : @"GetList"};
    
    NSDictionary *result = @{@"Start" : @(_Start), @"Count" : @(_Count)};
    NSDictionary *bodyDic = @{@"Head" : head, @"Result" : result};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{
//    return responseObject;
    return responseObject[@"rows"];
}
@end
