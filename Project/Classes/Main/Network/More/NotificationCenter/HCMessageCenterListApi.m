//
//  HCMessageCenterListApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/21.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMessageCenterListApi.h"

@implementation HCMessageCenterListApi

-(void)startRequest:(HCMessageCenterListBlock)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    //
    return @"CallReply/listInfoCenter.do";
}
-(id)requestArgument{
    
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"key":_key,@"start":__start,@"count":__count};
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{
    
    return responseObject;
}


@end
