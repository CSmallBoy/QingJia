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

    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
   NSDictionary * para = @{@"start":_start_num,
             @"count":_home_conut};
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject{
    NSArray *arr = responseObject[@"Data"][@"rows"];
    NSMutableArray *arring = [NSMutableArray array];
    for (int i = 0 ; i < arr.count; i ++){
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
        info.FTReplyCount = arr[i][@"replyCount"];
        info.HeadImg = arr[i][@"imageName"];
        NSString *str  = arr[i][@"likeNickNames"];
        info.isLikeArr =  [str componentsSeparatedByString:@","];
        [arring addObject:info];
    }
    return arring;
}
@end
