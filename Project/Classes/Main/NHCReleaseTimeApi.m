//
//  NHCReleaseTimeApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCReleaseTimeApi.h"
#import "HCHomeInfo.h"
@implementation NHCReleaseTimeApi
-(void)startRequest:(NHCReleaseTime)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
   // 时光列表
    return @"Times/create.do";
}
-(id)requestArgument{
    NSDictionary *dict = [readUserInfo getReadDic];
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":dict[@"UserInf"][@"uuid"]};
    NSDictionary *para = @{@"content":_content,
                           @"imageNames":_imageNames,
                           @"openAddress":@"1",
                           @"permitType":@"0",
                           @"createLocation":@"30,118",
                           @"createAddrSmall":@"上海市，闵行区",
                           @"createAddr":@"上海市,闵行区,集心路168号"};
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject{
    NSString *timeid = responseObject[@"Data"][@"TimesInf"][@"timesId"];
    NSDictionary *dict = responseObject[@"Data"];
    return timeid;
}
@end
