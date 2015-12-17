//
//  HCProductIntrodApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCProductIntrodApi.h"
#import "HCProductIntroductionInfo.h"

@implementation HCProductIntrodApi

- (void)startRequest:(HCProductBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
    return @{@"t": @"User,logout", @"token": @"23"};
}

- (id)formatResponseObject:(id)responseObject
{
        HCProductIntroductionInfo *info = [[HCProductIntroductionInfo alloc] init];
        info.buyWayFirst = @"不租用";
        info.buyWaySecond = @"租用";
        info.buyNumber = 4;
        info.productName = @"标签";
    info.selectState = YES;
    info.price = 89;
    
    return info;
}

@end