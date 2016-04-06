//
//  NHCUSerInfoApi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCUSerInfoApi.h"

@implementation NHCUSerInfoApi
- (void)startRequest:(NHCUserInfo)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{   //完善用户信息
    return @"User/addUserInfo.do";
}
- (id)requestArgument
{   //完善用户信息
    NSDictionary *dict = [readUserInfo getReadDic];
    NSDictionary *head = @{@"UUID":dict[@"UserInf"][@"uuid"],
                           @"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token};
    NSDictionary *para = @{@"nickName":_myModel.nickName,
                           @"homeAddress":_myModel.adress,
                           @"career":_myModel.professional,
                           @"userDescription":@"日行一善",
                           @"company":_myModel.company
                           };
    NSDictionary *body = @{@"Para":para,@"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    
    return responseObject;
}
@end
