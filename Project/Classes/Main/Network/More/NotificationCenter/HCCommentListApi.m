//
//  HCCommentListApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCCommentListApi.h"

@implementation HCCommentListApi

-(void)startRequest:(HCCommentListBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"CallReply/listClue.do";
}

-(id)requestArgument
{
    
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};

    NSDictionary *para = @{@"callId":_callId,
                           @"start":__start,
                           @"count":__count};
    
    return @{@"Head":head,
             @"Para":para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
