//
//  applyList.m
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCFamilyapplyList.h"

@implementation HCFamilyapplyList

-(void)startRequest:(applyListBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
   return @"Family/listJoinApplication.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"familyId":_familyId,
                           @"start":@"0",
                           @"count":@"20",
                           @"endUserId":_endUserId};
    
    return @{@"Head":head,
             @"Para":para};

}


-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
