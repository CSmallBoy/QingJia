//
//  NHCRegionApi.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCRegionApi.h"

@implementation NHCRegionApi
- (void)startRequest:(HCRequestBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"Product/getProvince.do";
}
- (id)requestArgument
{
    NSDictionary *dict = [readUserInfo getReadDic];
    NSDictionary *head = @{@"UUID":dict[@"UserInf"][@"uuid"],
                           @"platForm":[readUserInfo GetPlatForm]};
    NSMutableDictionary *Para = [NSMutableDictionary dictionary];
    NSDictionary *body = @{@"Head":head,@"Para":Para};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
//    NSArray *arr = responseObject[@"Data"][@"rows"];
//    NSSet *sab = [NSSet setWithArray:arr];
//    arr = [sab allObjects];
    return responseObject;
}
@end
