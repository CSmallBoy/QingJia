//
//  NHCMessageSearchUserApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/20.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCMessageSearchUserApi.h"

@implementation NHCMessageSearchUserApi
-(void)startRequest:(NHCMeaaageUser)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    // 时光列表
    return @"Chat/searchUser.do";
}
-(id)requestArgument{
    NSDictionary *dict = [readUserInfo getReadDic];
    NSString *str;
    if (IsEmpty(dict[@"UserInf"][@"createFamilyId"])) {
        if (IsEmpty(dict[@"UserInf"][@"allFamilyIds"])) {
            str = @"0";
        }else{
            str = dict[@"UserInf"][@"allFamilyIds"];
        }
    }else{
        str = dict[@"UserInf"][@"createFamilyId"];
    }
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    //    NSDictionary *para = @{@"rangeType":@"0",
    //                           @"start":@"0",
    //                           @"count":@"10",
    //                           @"rangeId":str};
    NSDictionary *para = @{@"key":@"123434"};
    
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{

    return responseObject;
}
@end
