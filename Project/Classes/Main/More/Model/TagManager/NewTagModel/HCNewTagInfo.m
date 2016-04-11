//
//  HCNewTagInfo.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCNewTagInfo.h"

@implementation HCNewTagInfo

-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCNewTagInfo *info = [[[self class]allocWithZone:zone]init];
    info.trueName = [_trueName mutableCopy];
    info.imageName = [_imageName mutableCopy];
    info.sex = [_sex mutableCopy];
    info.birthDay = [_birthDay mutableCopy];
    info.homeAddress = [_homeAddress mutableCopy];
    info.school = [_homeAddress mutableCopy];
    info.height = [_height mutableCopy];
    info.weight = [_weight mutableCopy];
    info.bloodType = [_bloodType mutableCopy];
    info.allergic = [_allergic mutableCopy];
    info.cureCondition = [_cureCondition mutableCopy];
    info.cureNote = [_cureNote mutableCopy];
    
    return info;
}

@end
