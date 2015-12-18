//
//  HCContactPersonInfo.m
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCContactPersonInfo.h"

@implementation HCContactPersonInfo

-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCContactPersonInfo *contactInfo = [[[self class]allocWithZone:zone]init];
    
    contactInfo.contactName = [_contactName mutableCopy];
    contactInfo.contactPhoneNum = [_contactPhoneNum mutableCopy];
    contactInfo.contactIDCard = [_contactIDCard mutableCopy];
    contactInfo.contactRelationShip = [_contactRelationShip mutableCopy];
    
    return contactInfo;
}
@end
