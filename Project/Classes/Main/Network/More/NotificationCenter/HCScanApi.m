//
//  HCScanApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCScanApi.h"

@implementation HCScanApi

-(void)startRequest:(HCScanBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
   return @"CallReply/scan.do";
}


-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"labelGuid":_labelGuid};
    
    return @{@"Head":head,
             @"Para":para};
    
    
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
