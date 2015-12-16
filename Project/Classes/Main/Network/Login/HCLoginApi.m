//
//  HCLoginApi.m
//  HealthCloud
//
//  Created by Vincent on 15/10/27.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCLoginApi.h"

@implementation HCLoginApi

- (void)startRequest:(HCLoginBlock)requestBlock
{
    [super startRequest:requestBlock];
}


- (id)formatResponseObject:(id)responseObject
{
    
    HCLoginInfo *loginInfo = [HCLoginInfo mj_objectWithKeyValues:responseObject[@"data"]];
    return loginInfo;
}
- (id)requestArgument
{
    return @{@"t": @"User,login", @"username": _mobile, @"password": _password};
}




@end
