//
//  HCTagAddObjectApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagAddObjectApi.h"
#import "HCNewTagInfo.h"

// -------------------添加对象----------------------

@implementation HCTagAddObjectApi

-(void)startRequest:(HCTagAddObjectBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
   return @"Label/createObject.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = [_info mj_keyValues];
    
    return @{@"Head":head,
             @"Para":para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
