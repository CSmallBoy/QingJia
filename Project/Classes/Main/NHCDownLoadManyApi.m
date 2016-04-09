//
//  NHCDownLoadManyApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCDownLoadManyApi.h"

@implementation NHCDownLoadManyApi
- (void)startRequest:(NHCMangDownLoad)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"Photo/downloadSummary.do";
}
- (id)requestArgument
{
    NSDictionary *dict = [readUserInfo getReadDic];
    NSDictionary *head = @{@"UUID":dict[@"UserInf"][@"uuid"],
                           @"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token};
    NSDictionary *para = @{@"type":@"6",
                           @"id":_TimeID
                           };
    NSDictionary *body = @{@"Para":para,
                           @"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    NSArray *arr = responseObject[@"Data"][@"rows"];
    NSSet *sab = [NSSet setWithArray:arr];
    arr = [sab allObjects];
    return arr;
}
@end

