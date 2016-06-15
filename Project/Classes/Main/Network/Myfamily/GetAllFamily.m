//
//  GetAllFamily.m
//  钦家
//
//  Created by 殷易辰 on 16/6/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "GetAllFamily.h"

@implementation GetAllFamily

-(void)startRequest:(HCAllFamilyBlock)requestBlock{
    
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    //
    return @"Family/getAllFamilies.do";
}
-(id)requestArgument{
    
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{};
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{
    
    return responseObject;
}

@end
