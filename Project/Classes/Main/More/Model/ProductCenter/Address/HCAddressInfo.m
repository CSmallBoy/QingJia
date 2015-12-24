//
//  HCAddressInfo.m
//  Project
//
//  Created by 朱宗汉 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCAddressInfo.h"

@implementation HCAddressInfo

-(id)mutableCopyWithZone:(NSZone *)zone
{
    HCAddressInfo *AddressInfo = [[[self class]allocWithZone:zone]init];
    
    AddressInfo.consigneeName = [_consigneeName mutableCopy];
    AddressInfo.phoneNumb = _phoneNumb;
    AddressInfo.postcode = _postcode;
    AddressInfo.receivingStreet = [_receivingStreet mutableCopy];
    AddressInfo.receivingCity = [_receivingCity mutableCopy];
    
    return AddressInfo;
}
@end
