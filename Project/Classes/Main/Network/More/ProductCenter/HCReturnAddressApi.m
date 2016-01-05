//
//  HCReturnAddress.m
//  Project
//
//  Created by 朱宗汉 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCReturnAddressApi.h"
#import "HCReturnAddressInfo.h"

@implementation HCReturnAddressApi

- (void)startRequest:(HCReturnAddressBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
    return @{@"t": @"User,logout", @"token": @"23"};
}

- (id)formatResponseObject:(id)responseObject
{
    HCReturnAddressInfo *info = [[HCReturnAddressInfo alloc] init];
    info.returnAddress = @"上海市闵行区梅陇镇集心路168号1号楼502室";
    info.recipient = @"json";
    info.phoneNum = @"1248792184963";
    return info;
}


@end
