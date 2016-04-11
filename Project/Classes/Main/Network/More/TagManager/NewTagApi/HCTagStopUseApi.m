//
//  HCTagStopUseApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagStopUseApi.h"

// -------------------停用标签----------------------

@implementation HCTagStopUseApi

-(void)startRequest:(HCTagStopUseBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Label/stopLabel.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para =@{@"labelId":_labelId};
    
    
    return @{@"Head":head,
             @"Para":para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
