//
//  HCTagUserAmostListApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/19.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagUserAmostListApi.h"

@implementation HCTagUserAmostListApi

-(void)startRequest:(HCTagUserAmostListBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
     return @"Label/listObjectSummary.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{};
    
    
    return @{@"Head":head,
             @"Para":para};
}


-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
