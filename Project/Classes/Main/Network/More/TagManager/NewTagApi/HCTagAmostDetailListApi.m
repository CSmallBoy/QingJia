//
//  HCTagAmostDetailListApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagAmostDetailListApi.h"

@implementation HCTagAmostDetailListApi

-(void)startRequest:(HCTagAmostDetailListBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Label/listLabelSummaryByStatus.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};

    NSDictionary *para = @{@"labelStatus":_labelStatus};
    
    return @{@"Head":head,
             @"Para":para};
    
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
