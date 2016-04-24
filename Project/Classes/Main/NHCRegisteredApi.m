//
//  NHCRegisteredApi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCRegisteredApi.h"

@implementation NHCRegisteredApi
- (void)startRequest:(HCRegister)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{ //注册
    return @"User/regUser.do";
}
- (id)requestArgument
{// 注册
    NSDictionary *head = @{@"UUID":[readUserInfo GetUUID],
                           @"platForm":[readUserInfo GetPlatForm],
                           @"userName":_userName,
                           @"address":@"上海市"};
    NSDictionary *para = @{@"trueName":_TrueName,
                           @"birthDay":_birthday,
                           @"userPWD":_passWord,
                           @"sex":_sex};
    NSDictionary *body = @{@"Para":para,
                           @"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    NSDictionary *dic = responseObject[@"Data"];
    HCLoginInfo *loginInfo = [HCLoginInfo mj_objectWithKeyValues:dic[@"UserInf"]];
    loginInfo.Token = dic[@"Token"];
    loginInfo.TrueName = dic[@"UserInf"][@"trueName"];
    loginInfo.NickName = dic[@"UserInf"][@"nickName"];
    loginInfo.chineseZodiac = dic[@"UserInf"][@"chineseZodiac"];
    loginInfo.status = dic[@"UserInf"][@"status"];
    loginInfo.UserDescription = dic[@"UserInf"][@"userDescription"];
    loginInfo.Company = dic[@"UserInf"][@"company"];
    loginInfo.birthday = dic[@"UserInf"][@"birthDay"];
    loginInfo.Sex = dic[@"UserInf"][@"sex"];
    loginInfo.PhoneNo = dic[@"UserInf"][@"phoneNo"];
    loginInfo.UUID = dic[@"UserInf"][@"uuid"];
    loginInfo.DefaultFamilyID = dic[@"UserInf"][@"defaultFamilyID"];
    loginInfo.Career = dic[@"UserInf"][@"career"];
    loginInfo.chatName = dic[@"UserInf"][@"chatName"];
    loginInfo.chatPwd = dic[@"UserInf"][@"chatPwd"];
    loginInfo.allFamilyIds = dic[@"UserInf"][@"allFamilyIds"];
    loginInfo.createFamilyId = dic[@"UserInf"][@"createFamilyId"];
    loginInfo.UserName = dic[@"UserInf"][@"userName"];
    loginInfo.HomeAddress = dic[@"UserInf"][@"homeAddress"];
    loginInfo.UserId = dic[@"UserInf"][@"UserId"];
    if (IsEmpty(dic[@"UserInf"][@"imageName"])) {
        
    }else{
        loginInfo.userHeadPhoto = dic[@"UserInf"][@"imageName"];
    }
    [readUserInfo Dicdelete];
    [readUserInfo creatDic:dic];

    return loginInfo;
}
@end
