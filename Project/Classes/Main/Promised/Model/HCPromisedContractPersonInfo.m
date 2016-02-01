//
//  HCPromisedContractPersonInfo.m
//  Project
//
//  Created by 朱宗汉 on 16/1/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedContractPersonInfo.h"

@implementation HCPromisedContractPersonInfo
-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCPromisedContractPersonInfo *contactInfo = [[[self class]allocWithZone:zone]init];
    
    contactInfo.ObjectXName = [_ObjectXName mutableCopy];
    contactInfo.ObjectXRelative = [_ObjectXRelative mutableCopy];
    contactInfo.PhoneNo = [_PhoneNo mutableCopy];
    contactInfo.IDNo = [_IDNo mutableCopy];
    contactInfo.OrderIndex = [_OrderIndex mutableCopy];
    return contactInfo;
}
@end
