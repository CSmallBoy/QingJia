//
//  HCLogoutApi.m
//  HealthCloud
//
//  Created by Vincent on 15/11/3.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCLogoutApi.h"

@implementation HCLogoutApi

- (NSString *)requestUrl
{
    return @"logon/logout";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}

- (NSDictionary *)headerFieldDict
{
    return @{@"X-Access-Token" : [HCAccountMgr manager].loginInfo.accessToken};
}


@end
