//
//  HCCancelSaveApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCCancelSaveApi.h"

@implementation HCCancelSaveApi

-(void)startRequest:(HCCancelSaveBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
   return @"CallReply/cancelFavor.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"callId":@"146138454386580"};
    
    return @{@"Head":head,
             @"Para":para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
