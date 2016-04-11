//
//  HCTagDetailApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagDetailApi.h"

// -------------------获取标签详细信息----------------------

@implementation HCTagDetailApi

-(void)startRequest:(HCTagDetailBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Label/getLabelDetailInfo.do";
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
