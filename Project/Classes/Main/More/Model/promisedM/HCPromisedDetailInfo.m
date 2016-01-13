//
//  HCPromisedDetailInfo.m
//  Project
//
//  Created by 朱宗汉 on 16/1/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedDetailInfo.h"
#import "HCContactPersonInfo.h"
#import "HCPromisedContractPersonInfo.h"
@implementation HCPromisedDetailInfo

-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCPromisedDetailInfo *tagUserInfo = [[[self class]allocWithZone:zone]init];
    tagUserInfo.ObjectXName = [_ObjectXName mutableCopy];
    tagUserInfo.ObjectSex = [_ObjectSex mutableCopy];
    tagUserInfo.ObjectBirthDay = [_ObjectBirthDay mutableCopy];
    tagUserInfo.ObjectHomeAddress = [_ObjectHomeAddress mutableCopy];
    tagUserInfo.ObjectSchool = [_ObjectSchool mutableCopy];
    tagUserInfo.ObjectIdNo = [_ObjectSchool mutableCopy];
    tagUserInfo.ObjectCareer = [_ObjectCareer mutableCopy];
    tagUserInfo.BloodType = [_BloodType mutableCopy];
    tagUserInfo.Allergic = [_Allergic mutableCopy];
    tagUserInfo.ContactArray  = [_ContactArray mutableCopy];
 
    return tagUserInfo;
}

-(NSMutableArray *)ContactArray
{
    if (!_ContactArray)
    {
        _ContactArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _ContactArray;
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{ @"ContactArray" :[HCPromisedContractPersonInfo class]};
}

@end
