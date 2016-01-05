//
//  HCLogoutApi.m
//  HealthCloud
//
//  Created by Vincent on 15/11/3.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCLogoutApi.h"

@implementation HCLogoutApi

- (id)requestArgument
{
    return @{@"t": @"User,logout", @"token": [HCAccountMgr manager].loginInfo.Token};
}


@end
