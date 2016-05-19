//
//  NHCHomeTimeDeleteApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/8.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCHomeTimeDeleteApi.h"

@implementation NHCHomeTimeDeleteApi
-(void)startRequest:(NHCDeleteTime)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    // 时光列表
    return @"Times/delete.do";
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"timesId":_timeID};
    
    
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end


