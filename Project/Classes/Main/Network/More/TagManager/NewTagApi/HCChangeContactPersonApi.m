//
//  HCChangeContactPersonApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCChangeContactPersonApi.h"

// -------------------变更紧急联系人----------------------

@implementation HCChangeContactPersonApi

-(void)startRequest:(HCChangeContactPersonBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Label/updateUrgentContactor.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *Para = @{@"contactorId":_contactorId,
                           @"phoneNo":_phoneNo,
                           @"imageName":_imageName};
    
    return @{@"Head":head,
             @"Para":Para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
