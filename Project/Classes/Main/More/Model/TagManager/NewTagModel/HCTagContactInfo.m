//
//  HCTagContactInfo.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagContactInfo.h"

@implementation HCTagContactInfo

-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCTagContactInfo *info = [[[self class]allocWithZone:zone]init];
    info.trueName = [_trueName mutableCopy];
    info.relative = [_relative mutableCopy];
    info.phoneNo = [_phoneNo mutableCopy];
    
    return info;
}

@end
