//
//  HCTagUserFindApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/19.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagUserFindApi.h"

@implementation HCTagUserFindApi

-(void)startRequest:(HCTagUserFindBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Label/searchObject.do";
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
