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
//    tagUserInfo.userImageStr = [_userImageStr mutableCopy];
//     tagUserInfo.userImageUrlStr = [_userImageUrlStr mutableCopy];
//    tagUserInfo.userName = [_userName mutableCopy];
//    tagUserInfo.userGender = [_userGender mutableCopy];
//    tagUserInfo.userBirthday = [_userBirthday mutableCopy];
//    tagUserInfo.userAddress = [_userAddress mutableCopy];
//    tagUserInfo.userSchool = [_userSchool mutableCopy];
//    tagUserInfo.userPhoneNum = [_userPhoneNum mutableCopy];
//    tagUserInfo.userIDCard = [_userIDCard mutableCopy];
//    tagUserInfo.contactInfoArr = [_contactInfoArr mutableCopy];
//    tagUserInfo.contactPersonInfo = [_contactPersonInfo mutableCopy];
//    tagUserInfo.userBloodType = [_userBloodType mutableCopy];
//    tagUserInfo.userAllergicHistory = [_userAllergicHistory mutableCopy];
    tagUserInfo.ObjectXName = [_ObjectXName mutableCopy];
    tagUserInfo.ObjectSex = [_ObjectSex mutableCopy];
    tagUserInfo.ObjectBirthDay = [_ObjectBirthDay mutableCopy];
    tagUserInfo.ObjectHomeAddress = [_ObjectHomeAddress mutableCopy];
    tagUserInfo.ObjectSchool = [_ObjectSchool mutableCopy];
    tagUserInfo.ObjectIdNo = [_ObjectSchool mutableCopy];
    tagUserInfo.ObjectCareer = [_ObjectCareer mutableCopy];
    tagUserInfo.BloodType = [_BloodType mutableCopy];
    tagUserInfo.Allergic = [_Allergic mutableCopy];
    
    return tagUserInfo;
}

//-(NSMutableArray *)contactInfoArr
//{
//    if (!_contactInfoArr) {
//        _contactInfoArr = [NSMutableArray arrayWithCapacity:2];
//    }
//    return _contactInfoArr;
//}

-(NSMutableArray *)ContactArray
{
    if (!_ContactArray) {
        _ContactArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _ContactArray;
}
@end
