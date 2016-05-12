//
//  HCGetCityInfoApi.m
//  钦家
//
//  Created by Tony on 16/5/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCGetCityInfoApi.h"

@implementation HCGetCityInfoApi

-(void)startRequest:(HCReportBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Other/getRegionLayers.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para  = @{};
    return @{@"Head":head,@"Para":para};
    
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
