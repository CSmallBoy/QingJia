//
//  HCCreateAllFamily.m
//  钦家
//
//  Created by 殷易辰 on 16/6/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCCreateAllFamily.h"

@implementation HCCreateAllFamily


-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCCreateAllFamily *info = [[[self class]allocWithZone:zone]init];
    info.familyId = [_familyId mutableCopy];
    info.isCreator = [_isCreator mutableCopy];
    info.ancestralHome = [_ancestralHome mutableCopy];
    info.familyNickName = [_familyNickName mutableCopy];
    info.familyDescription = [_familyDescription mutableCopy];
    info.contactAddr = [_contactAddr mutableCopy];
    info.memberCount = [_memberCount mutableCopy];
    info.members = [_members mutableCopy];
    return info;
    
}

-(NSMutableArray *)ContactArray
{
    if (!_members)
    {
        _members = [NSMutableArray arrayWithCapacity:2];
    }
    return _members;
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{ @"members" :[HCCreateAllFamily class]};
}

@end
