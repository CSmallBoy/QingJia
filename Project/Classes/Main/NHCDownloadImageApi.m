//
//  NHCDownloadImageApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCDownloadImageApi.h"

@implementation NHCDownloadImageApi
- (void)startRequest:(NHCDownImage)requestBlock{
    [super startRequest:requestBlock];
}
- (NSString *)requestUrl{
    return @"photo/downloadOne.do";
}
- (id)requestArgument{
    NSDictionary *dict = [readUserInfo getReadDic];
    NSDictionary *head = @{@"UUID":dict[@"UserInf"][@"uuid"],
                           @"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token};
    NSDictionary *para = @{@"type":_type,
                           @"id":@"2000"};
    NSDictionary *body = @{@"Para":para,
                           @"Head":head};
    return body;
}
-(id)formatResponseObject:(id)responseObject{
    return responseObject;
}
@end
