//
//  applyToFamily.m
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "applyToFamily.h"

@implementation applyToFamily

-(void)startRequest:(applyToFamilyBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
   return @"Family/joinApplication.do";
}


-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"familyId":_familyId,
                           @"joinMessage":_joinMessage};
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
