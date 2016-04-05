//
//  HCCreateGradeInfo.m
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCreateGradeInfo.h"

@implementation HCCreateGradeInfo

-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCCreateGradeInfo *info = [[[self class]allocWithZone:zone]init];
    info.familyId = [_familyId mutableCopy];
    info.ancestralHome = [_ancestralHome mutableCopy];
    info.familyNickName = [_familyNickName mutableCopy];
    info.familyPhoto = [_familyPhoto mutableCopy];
    info.contactAddr = [_contactAddr mutableCopy];
    info.createTime = [_createTime mutableCopy];
    info.uploadImage = [_uploadImage mutableCopy];
    info.OrderIndex = [_OrderIndex mutableCopy];
    info.VisitPassWord = [_VisitPassWord mutableCopy];
    info.FamilyCode = [_FamilyCode mutableCopy];
    info.repassword = [_repassword mutableCopy];
    
    return info;
    
}


@end
