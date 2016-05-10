//
//  NHCMessageSearchUserApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/20.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCMessageSearchUserApi.h"

@implementation NHCMessageSearchUserApi
-(void)startRequest:(NHCMeaaageUser)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
   
    return @"Chat/searchUser.do";
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"key":_UserChatID};
    
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{
    
    HCLoginInfo *info = [[HCLoginInfo alloc]init];
    info.chatName = responseObject[@"Data"][@"UserInf"][@"chatName"];
    info.userHeadPhoto = responseObject[@"Data"][@"UserInf"][@"imageName"];
    info.NickName = responseObject[@"Data"][@"UserInf"][@"nickName"];
    info.HomeAddress = responseObject[@"Data"][@"UserInf"][@"homeAddress"];
    info.UserDescription = responseObject[@"Data"][@"UserInf"][@"userDescription"];
    return info;
}
@end
