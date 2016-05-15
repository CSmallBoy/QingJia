//
//  NHCBindPhoneNumAPi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCBindPhoneNumAPi.h"

@implementation NHCBindPhoneNumAPi
- (void)startRequest:(NHCUserInfo)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{   //修改绑定的手机号
    return @"User/changePhoneNo.do";
}
- (id)requestArgument
{
    NSDictionary *head = @{@"UUID":[HCAccountMgr manager].loginInfo.UUID,
                           @"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token};
    NSDictionary *para = @{@"newPhoneNo":_PhoneNum,
                           @"theCode":_theCode};
    NSDictionary *body = @{@"Para":para,
                           @"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end
