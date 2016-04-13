//
//  NHCListOfTimeAPi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCListOfTimeAPi.h"
#import "HCHomeInfo.h"
@implementation NHCListOfTimeAPi
-(void)startRequest:(NHCListTime)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    // 时光列表
    return @"Times/listTimesForFamily.do";
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
  //  NSDictionary *para = @{@"rangeType":@"0",
//                           @"start":@"0",
//                           @"count":@"10",
//                           @"rangeId":str};
    NSDictionary *para = @{@"start":@"0",
                           @"count":@"10"};
    
    
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject{
    NSArray *arr = responseObject[@"Data"][@"rows"];
    NSMutableArray *arring = [NSMutableArray array];
    for (int i = 0 ; i < arr.count; i ++) {
        HCHomeInfo *info = [[HCHomeInfo alloc]init];
        info.FTContent = arr[i][@"content"];
        NSString *str_image = arr[i][@"imageNames"];
        NSArray *b = [str_image componentsSeparatedByString:@","];
        info.FTImages = b;
        info.CreateAddrSmall = arr[i][@"createAddrSmall"];
        info.NickName = arr[i][@"creatorName"];
        info.CreateTime = arr[i][@"createTime"];
        info.TimeID = arr[i][@"timesId"];
        info.creator = arr[i][@"creator"];
        info.isLike = arr[i][@"isLike"];
        info.fromFamily = arr[i][@"fromFamily"];
        [arring addObject:info];
    }
    return arring;
}
@end
