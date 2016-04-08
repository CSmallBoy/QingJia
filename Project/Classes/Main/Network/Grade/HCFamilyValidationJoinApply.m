
//
//  ValidationJoinApply.m
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCFamilyValidationJoinApply.h"

@implementation HCFamilyValidationJoinApply

-(void)startRequest:(ValidationJoinApplyBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
   return @"Family/permitJoinApplication.do";

}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":@"IOS9",
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"applyUserId":_applyUserId,
                           @"permitResult":@"1"};
    
    return @{@"Head":head,
             @"Para":para};
 
}


-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
