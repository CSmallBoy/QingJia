//
//  HCDeleteMember.m
//  钦家
//
//  Created by 殷易辰 on 16/6/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCDeleteMember.h"

@implementation HCDeleteMember

- (void)startRequest:(HCEditCommentBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"Family/deleteMember.do";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"memberUserId":_memberUserId};
     return @{@"Head":head,@"Para":para};}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"Data"];
}


@end
