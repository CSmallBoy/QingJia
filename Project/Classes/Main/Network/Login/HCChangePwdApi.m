//
//  HCChangePwdRequest.m
//  HealthCloud
//
//  Created by Jessie on 15/10/9.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCChangePwdApi.h"

@implementation HCChangePwdApi

- (void)startRequest:(HCChangePwdBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
    return @{@"t": @"User,restpassword", @"token": self.token, @"password": self.password};
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"data"];
}

@end
