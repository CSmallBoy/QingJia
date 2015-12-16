//
//  HCUserInfo.m
//  HealthCloud
//
//  Created by Vincent on 15/9/14.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCUserInfo.h"

@implementation HCUserInfo

- (id)mutableCopyWithZone:(NSZone *)zone
{
    HCUserInfo *userInfo = [[[self class] allocWithZone:zone]init];

    userInfo.wechat = [_wechat mutableCopy];
    userInfo.phone = [_phone mutableCopy];
    userInfo.album = [_album mutableCopy];
    userInfo.albumurl = [_albumurl mutableCopy];
    userInfo.educational = [_educational mutableCopy];
    userInfo.signature = [_signature mutableCopy];
    userInfo.birthday = [_birthday mutableCopy];
    
    userInfo.name = [_name mutableCopy];
    userInfo.hometown = [_hometown mutableCopy];
    userInfo.photoListArr = [_photoListArr mutableCopy];
    userInfo.photoImageArr = [_photoImageArr mutableCopy];
    userInfo.complete = [_complete mutableCopy];
    
    return userInfo;
}

- (NSMutableArray *)photoImageArr
{
    if (!_photoImageArr)
    {
        _photoImageArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _photoImageArr;
}
//- (NSString *)dob
//{
//    return [Utils birthdayFormatterWithServer:_dob];
//}
@end
