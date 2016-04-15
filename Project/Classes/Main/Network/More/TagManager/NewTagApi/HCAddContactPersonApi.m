//
//  HCAddContactPersonApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCAddContactPersonApi.h"

#import "HCTagContactInfo.h"

// -------------------添加紧急联系人----------------------

@implementation HCAddContactPersonApi

-(void)startRequest:(HCAddContactPersonBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Label/createUrgentContactor.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para =@{@"trueName":_trueName,
                          @"phoneNo":_phoneNo};
    
    return @{@"Head":head,
             @"Para":para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
