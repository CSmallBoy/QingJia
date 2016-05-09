//
//  NHCEditingFamilyApi.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCEditingFamilyApi.h"

@implementation NHCEditingFamilyApi
-(void)startRequest:(HCRequestBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Family/edit.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"familyId":_familyId,
                           @"ancestralHome":_ancestralHome,
                           @"familyNickName":_familyNickName,
                           @"imageName":_imageName,
                           @"contactAddr":_contactAddr};
    
    return @{@"Head":head,
             @"Para":para};
    
}


-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end
