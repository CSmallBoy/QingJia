//
//  HCPromisedTagInfo.m
//  Project
//
//  Created by 朱宗汉 on 16/1/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedTagInfo.h"

@implementation HCPromisedTagInfo


-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCPromisedTagInfo  *tagInfo = [[[self class]allocWithZone:zone]init];
    tagInfo.name = [_name mutableCopy];
    tagInfo.image = [_image mutableCopy];
    return tagInfo;
}


@end
