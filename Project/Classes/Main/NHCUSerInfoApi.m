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
{   //验证验证码
    return @"User/addUserInfo.do";
}
- (id)requestArgument
{   //完善用户信息
    NSDictionary *head = @{@"UUID":@"3284F4E0-80CE-4F14-AEA8-1361066BFBBB",@"platForm":@"IOS9.3",@"token":[HCAccountMgr manager].loginInfo.Token};
    NSDictionary *para = @{@"nickName":_myModel.nickName,
                           @"photoType":@"jpg",
                           @"userPhoto":_myModel.PhotoStr,
                           @"homeAddress":_myModel.adress,
                           @"career":_myModel.professional,
                           @"userDescription":@"日行一善"
                           };
    NSDictionary *body = @{@"Para":para,@"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    
    return responseObject;
}
@end
