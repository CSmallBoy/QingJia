//
//  HCPromisedListInfo.m
//  Project
//
//  Created by 朱宗汉 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedListInfo.h"

@implementation HCPromisedListInfo


-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCPromisedListInfo  *ListInfo = [[[self class]allocWithZone:zone]init ];
    ListInfo.name = [_name mutableCopy];
    ListInfo.ObjectId = [_ObjectId mutableCopy];
    return ListInfo;
}


@end
