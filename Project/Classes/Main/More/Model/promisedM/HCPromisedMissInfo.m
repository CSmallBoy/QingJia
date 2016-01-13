//
//  HCPromisedMissInfo.m
//  Project
//
//  Created by 朱宗汉 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedMissInfo.h"

@implementation HCPromisedMissInfo

-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCPromisedMissInfo  *missInfo = [[[self class]allocWithZone:zone]init ];
    missInfo.LossAddress = [_LossAddress mutableCopy];
    missInfo.LossTime = [_LossAddress mutableCopy];
    missInfo.LossDesciption = [_LossDesciption mutableCopy];
    return missInfo;
}

@end
