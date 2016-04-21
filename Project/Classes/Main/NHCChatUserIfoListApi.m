//
//  NHCChatUserIfoListApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/21.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCChatUserIfoListApi.h"

@implementation NHCChatUserIfoListApi
-(void)startRequest:(NHCChatUSerList)requestBlock
{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    //
    return @"Chat/searchUserInfoByChatNames.do";
}
-(id)requestArgument{
    
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"chatName":_chatNames};
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{
    
    NSDictionary*dict = responseObject[@"Data"][@"UserInf"];
    return dict;
}
@end
