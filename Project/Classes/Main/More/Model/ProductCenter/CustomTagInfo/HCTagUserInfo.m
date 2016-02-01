//
//  HCTagUserInfo.m
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTagUserInfo.h"

@implementation HCTagUserInfo

-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCTagUserInfo *tagUserInfo = [[[self class]allocWithZone:zone]init];
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
@end
