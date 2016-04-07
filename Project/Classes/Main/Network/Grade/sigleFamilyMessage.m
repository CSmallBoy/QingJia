//
//  sigleFamilyMessage.m
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "sigleFamilyMessage.h"

@implementation sigleFamilyMessage

-(void)startRequest:(SigleFamilyMessageBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Family/getFamilyDetailInfo.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":@"IOS9.2",
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *pata = @{@"familyId":_familyId};
    
    return @{@"Head":head,
             @"Para":pata};
    
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
