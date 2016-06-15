//
//  MyFriendsApi.m
//  钦家
//
//  Created by 殷易辰 on 16/6/8.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "MyFriendsApi.h"

@implementation MyFriendsApi
-(void)startRequest:(NHCChatUSer)requestBlock
{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    //
    return @"Chat/searchUserFriendsInfo.do";
    
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{};
    NSLog(@"%@",head);
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{
    
    NSDictionary*dict = responseObject[@"Data"][@"rows"];
    return responseObject;
}
@end
