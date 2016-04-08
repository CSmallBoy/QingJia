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
    return @"Times/listTimes.do";
}
-(id)requestArgument{
    NSDictionary *dict = [readUserInfo getReadDic];
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"rangeType":@"0",
                           @"start":@"0",
                           @"count":@"20",
                           @"rangeId":dict[@"UserInf"][@"createFamilyId"]};
    
    
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject{
    NSArray *arr = responseObject[@"Data"][@"rows"];
    NSMutableArray *arring = [NSMutableArray array];
    for (int i = 0 ; i < arr.count; i ++) {
        HCHomeInfo *info = [[HCHomeInfo alloc]init];
        info.FTContent = arr[i][@"content"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger j = 0; j < i; j++)
        {
            NSString *imageStr = [NSString stringWithFormat:@"http://img2.3lian.com/img2007/10/28/%@.jpg", @(120+j)];
            DLog(@"%@", imageStr);
            [array addObject:imageStr];
        }
        info.FTImages = array;
        info.CreateAddrSmall = arr[i][@"createAddrSmall"];
        info.NickName = arr[i][@"creatorName"];
        [arring addObject:info];
    }
    return arring;
}
@end
