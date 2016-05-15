//
//  NHCChatGroupInfoApi.m
//  Project
//
//  Created by 朱宗汉 on 16/5/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCChatGroupInfoApi.h"

@implementation NHCChatGroupInfoApi
-(void)startRequest:(NHCChatGroup)requestBlock
{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    return @"Chat/searchFamilyInfoByGroupIds.do";
}
-(id)requestArgument{
    
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"chatGroupIds":_chatNames};
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{
    
    NSArray*arr = responseObject[@"Data"][@"rows"];
    return arr;
}
@end
