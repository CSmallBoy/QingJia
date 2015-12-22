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
    tagUserInfo.userImageStr = [_userImageStr mutableCopy];
     tagUserInfo.userImageUrlStr = [_userImageUrlStr mutableCopy];
    tagUserInfo.userName = [_userName mutableCopy];
    tagUserInfo.userGender = [_userGender mutableCopy];
    tagUserInfo.userBirthday = [_userBirthday mutableCopy];
    tagUserInfo.userAddress = [_userAddress mutableCopy];
    tagUserInfo.userSchool = [_userSchool mutableCopy];
    tagUserInfo.userPhoneNum = [_userPhoneNum mutableCopy];
    tagUserInfo.userIDCard = [_userIDCard mutableCopy];
    tagUserInfo.contactInfoArr = [_contactInfoArr mutableCopy];
    tagUserInfo.contactPersonInfo = [_contactPersonInfo mutableCopy];
    tagUserInfo.userBloodType = [_userBloodType mutableCopy];
    tagUserInfo.userAllergicHistory = [_userAllergicHistory mutableCopy];
 
    return tagUserInfo;
}

-(NSMutableArray *)contactInfoArr
{
    if (!_contactInfoArr) {
        _contactInfoArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _contactInfoArr;
}
@end
