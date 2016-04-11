//
//  HCObjectListApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCObjectListApi.h"

// -------------------对象列表----------------------

@implementation HCObjectListApi

-(void)startRequest:(HCObjectListBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Label/listObject.do";
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
