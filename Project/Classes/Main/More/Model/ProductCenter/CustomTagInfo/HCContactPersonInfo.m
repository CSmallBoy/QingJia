//
//  HCContactPersonInfo.m
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCContactPersonInfo.h"

@implementation HCContactPersonInfo

-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCContactPersonInfo *contactInfo = [[[self class]allocWithZone:zone]init];
    
    contactInfo.ObjectXName = [_ObjectXName mutableCopy];
    contactInfo.ObjectXRelative = [_ObjectXRelative mutableCopy];
    contactInfo.PhoneNo = [_PhoneNo mutableCopy];
    contactInfo.IDNo = [_IDNo mutableCopy];
    
    return contactInfo;
}
@end
