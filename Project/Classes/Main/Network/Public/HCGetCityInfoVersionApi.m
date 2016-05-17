//
//  HCGetCityInfoVersionApi.m
//  钦家
//
//  Created by Tony on 16/5/16.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCGetCityInfoVersionApi.h"

@implementation HCGetCityInfoVersionApi

-(void)startRequest:(HCReportBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Other/getRegionLayersVersion.do";
}

-(id)requestArgument
{
    NSLog(@"%@",[HCAccountMgr manager].loginInfo.UUID);
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"UUID":[readUserInfo GetUUID]};
    NSDictionary *para  = [NSDictionary dictionary];
    return @{@"Head":head,@"Para":para};
    
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
