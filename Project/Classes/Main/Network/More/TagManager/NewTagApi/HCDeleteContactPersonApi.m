//
//  HCDeleteContactPersonApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCDeleteContactPersonApi.h"

// -------------------删除紧急联系人----------------------

@implementation HCDeleteContactPersonApi

-(void)startRequest:(HCDeleteContactPersonBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Label/deleteUrgentContactor.do";
}

-(id)requestArgument
{
    NSDictionary *head =@{@"platForm":[readUserInfo GetPlatForm],
                          @"token":[HCAccountMgr manager].loginInfo.Token,
                          @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"contactorId":_contactorId};
    
    return @{@"Head":head,
             @"Para":para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
