//
//  HCEditFamilyApi.m
//  钦家
//
//  Created by 殷易辰 on 16/6/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCEditFamilyApi.h"

@implementation HCEditFamilyApi

-(void)startRequest:(HCAllFamilyBlock)requestBlock{
    
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    //
    return @"Family/edit.do";
}
-(id)requestArgument{
    
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"familyId":_familyId,@"ancestralHome":@"",@"familyNickName":_familyNickName,@"familyDescription":_familyDescription,@"contactAddr":@""};
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{
    
    return responseObject;
}

@end
