//
//  HCUserApi.m
//  Project
//
//  Created by 陈福杰 on 15/11/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCUserApi.h"

@implementation HCUserApi

- (id)requestArgument
{
    return @{@"t": @"User,info", @"uid": [HCAccountMgr manager].loginInfo.uid};
}

- (void)startRequest:(HCUserBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)formatResponseObject:(id)responseObject
{
    HCUserInfo *info = [HCUserInfo mj_objectWithKeyValues:responseObject[@"data"]];
    
    NSString *album = responseObject[@"data"][@"album"];
    if (!IsEmpty(album))
    {
        NSArray *array = [album componentsSeparatedByString:@","];
        info.album = [NSMutableArray arrayWithArray:array];
    }
    
    return info;
}


- (NSString *)formatMessage:(HCRequestStatus)statusCode
{
    NSString *msg = nil;
    if (statusCode == HCRequestStatusFailure)
    {
        msg = @"加载失败";
    }
    return msg;
}

@end
