//
//  HCGetCallDetailInfoApi.m
//  钦家
//
//  Created by Tony on 16/6/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCGetCallDetailInfoApi.h"

@implementation HCGetCallDetailInfoApi

-(void)startRequest:(HCRequestBlock)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    return @"CallReply/getCallInfoById.do";
}
-(id)requestArgument{
    
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"callId":_callId};
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{
    
    return responseObject;
}

- (NSInteger)cacheTimeInSeconds
{
    return 1;
}

@end
