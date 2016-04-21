//
//  NHCChatUserInfoApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/21.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCChatUserInfoApi.h"

@implementation NHCChatUserInfoApi

-(void)startRequest:(NHCChatUSer)requestBlock
{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    //
    return @"Chat/searchUserInfoByChatName.do";
}
-(id)requestArgument{
   
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"chatName":_chatName};
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{
    
    NSDictionary*dict = responseObject[@"Data"][@"UserInf"];
    return dict;
}
@end