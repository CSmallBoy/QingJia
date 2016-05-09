//
//  NHCScanUSerCodeApi.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/9.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCScanUSerCodeApi.h"

@implementation NHCScanUSerCodeApi
-(void)startRequest:(HCRequestBlock)requestBlock
{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    //
    return @"Chat/getChatStatusByScan.do";
}
-(id)requestArgument{
    
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"id":_userID};
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{
    NSString *str = responseObject[@"Data"][@"status"];
    return str;
}
@end
