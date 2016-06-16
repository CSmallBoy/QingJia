//
//  HCMemberApi.m
//  钦家
//
//  Created by 殷易辰 on 16/6/14.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMemberApi.h"

@implementation HCMemberApi
- (void)startRequest:(NHCGetMemerinfo)requestBlock{
    [super startRequest:requestBlock];
}
- (NSString*)requestUrl{
    return @"Family/getMemberInfo.do";
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm": [readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"memberId":_memberId};
    return @{@"Head": head, @"Para": para};
    
}
-(id)formatResponseObject:(id)responseObject{
    
    return responseObject;
}
@end
