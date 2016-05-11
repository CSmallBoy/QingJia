//
//  HCDeletePromisedApi.m
//  钦家
//
//  Created by Tony on 16/5/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCDeletePromisedApi.h"

@implementation HCDeletePromisedApi

-(void)startRequest:(HCReportBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"CallReply/removeCall.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para  = @{@"callId":self.callId};
    return @{@"Head":head,@"Para":para};
    
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
