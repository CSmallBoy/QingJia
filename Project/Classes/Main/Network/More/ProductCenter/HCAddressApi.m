//
//  HCAddressApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//收货地址

#import "HCAddressApi.h"
#import "HCAddressInfo.h"

@implementation HCAddressApi


- (void)startRequest:(HCAddressBlock)requestBlock
{
    [super startRequest:requestBlock];
}

//- (id)requestArgument
//{
//    return @{@"t": @"User,logout", @"token": @"23"};
//}
- (NSString *)requestUrl
{
    return @"User/AuthCode.ashx";// 测试
    return @"FamilyTimes/FamilyTimes.ashx";
}

- (id)requestArgument
{
    //测试
    NSDictionary *cshead = @{@"Action": @"ReGet", @"UUID": [HCAppMgr manager].uuid, @"PlatForm": [HCAppMgr manager].systemVersion};
    NSDictionary *cspara = @{@"PhoneNumber": @(18012345678), @"theType": @(1000)};
    NSDictionary *csbody = @{@"Head": cshead, @"Para": cspara};
    return @{@"json": [Utils stringWithObject:csbody]};
    
}

- (id)formatResponseObject:(id)responseObject
{
    HCAddressInfo *info = [[HCAddressInfo alloc] init];
    info.consigneeName = @"Tom";
    info.phoneNumb = @"12345678907 ";
    info.postcode = @"100000";
    info.receivingCity = @"江苏省南京市玄武区";
    info.receivingStreet = @"XX镇北京东路XXXX号XX楼XX室";
  
    
    return info;
}


@end
