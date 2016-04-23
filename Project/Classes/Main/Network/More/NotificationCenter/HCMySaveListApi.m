//
//  HCMySaveListApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMySaveListApi.h"

@implementation HCMySaveListApi

-(void)startRequest:(HCMySaveListBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"CallReply/listFavor.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"key":_key,@"start":__start,@"count":__count};
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
