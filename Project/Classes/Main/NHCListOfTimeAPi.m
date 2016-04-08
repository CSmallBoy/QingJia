//
//  NHCListOfTimeAPi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCListOfTimeAPi.h"

@implementation NHCListOfTimeAPi
-(void)startRequest:(NHCListTime)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    // 时光列表
    return @"Times/listTimes.do";
}
-(id)requestArgument{
    NSDictionary *dict = [readUserInfo getReadDic];
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":dict[@"UserInf"][@"uuid"]};
    NSDictionary *para = @{@"rangeType":@"0",
                           @"start":@"0",
                           @"count":@"20",
                           @"rangeId":dict[@"UserInf"][@"createFamilyId"]};
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject{
    NSArray *arr = responseObject[@"Data"][@"rows"];
    return arr;
}
@end
