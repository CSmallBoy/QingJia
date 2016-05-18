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
    NSDictionary *para;
    if (IsEmpty(_imageNames)) {
        //这个是没有图片的 openAddress 为 1 代表公开地理位置 permitType 为0 对外公开 2对自己
        para = @{@"content":_content,
                 @"openAddress":_openAddress,
                 @"permitType":_permitType,
                 @"createLocation":_createLocation,
                 @"createAddrSmall":_createAddrSmall,
                 @"createAddr":_createAddr};
    }else{
        para = @{@"content":_content,
                 @"imageNames":_imageNames,
                 @"openAddress":_openAddress,
                 @"permitType":_permitType,
                 @"createLocation":_createLocation,
                 @"createAddrSmall":_createAddrSmall,
                 @"createAddr":_createAddr};
    }
    
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject{
    NSString *timeid = responseObject[@"Data"][@"TimesInf"][@"timesId"];
    NSDictionary *dict = responseObject[@"Data"];
    return timeid;
}
@end
