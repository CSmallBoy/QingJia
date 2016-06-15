//
//  HCAboutMeApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCAboutMeApi.h"

@implementation HCAboutMeApi

-(void)startRequest:(HCAboutMeBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"CallReply/listMine.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"key":_key,@"start":__start,@"count":__count};

    
    return @{@"Head":head,@"Para":para};
     
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

//开启YTK缓存,默认缓存是关闭的(返回大于0是开启)
- (NSInteger)cacheTimeInSeconds
{
    return 1;
}

@end
