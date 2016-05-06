//
//  findFamilyMessage.m
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "findFamilyMessage.h"

#import "Utils.h"

@implementation findFamilyMessage

-(void)startRequest:(findFamilyMessageBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Family/searchFamily.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    if (IsEmpty(_familyId)) {
         _familyId = @"1234";
    }else{
        
    }
    NSDictionary *Para = @{@"familyId":_familyId};
    
    return @{@"Head":head,
             @"Para":Para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}


@end
