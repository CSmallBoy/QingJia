//
//  HCTagDeleteObjectApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagDeleteObjectApi.h"

// -------------------删除对象----------------------

@implementation HCTagDeleteObjectApi

-(void)startRequest:(HCTagDeleteObjectBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
   return @"/Label/deleteObject.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"objectId":_objectId};
    
    return @{@"Head":head,
             @"Para":para};
}


-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}


@end
