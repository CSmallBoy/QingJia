//
//  NHCHomeCommentListApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCHomeCommentListApi.h"
#import "HCHomeDetailUserInfo.h"
#import "HCHomeInfo.h"
#import "HCHomeDetailInfo.h"
@implementation NHCHomeCommentListApi
-(void)startRequest:(NHCHomeDetailBlock)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    // 发表评论
    return @"Times/listComments.do";
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para;
    if (IsEmpty(_imageName)) {
        para = @{@"timesId":_TimeID};
    }else{
        para = @{@"timesId":_TimeID,
                 @"imageName":_imageName};
    }
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject
{
    NSArray *arr = responseObject[@"Data"][@"rows"];
//    NSMutableArray *userArr = [NSMutableArray array];
//    for (int i = 0; i < _arring.count; i ++) {
//        //点赞显示的
//        HCHomeDetailUserInfo *userInfo = [[HCHomeDetailUserInfo alloc] init];
//        userInfo.nickName = arr[i];
//        [userArr addObject:arr[i]];
//        
//
//    }
    //去重方法
//    NSSet *sab = [NSSet setWithArray:userArr];
//    userArr= [sab allObjects];
    NSMutableArray *commentsArr = [NSMutableArray array];
    for (NSInteger i = 0; i <arr.count; i++)
    {
        HCHomeInfo *info = [[HCHomeInfo alloc] init];
        // info.HeadImg = @"http://xiaodaohang.cn/2.jpg";
        info.NickName = arr[i][@"from"];
        info.CreateTime = [NSString stringWithFormat:@"%@",arr[i][@"createTime"]];
        info.FTContent = arr[i][@"content"];
        info.subRows = arr[i][@"subRows"];
        info.fromImageName = arr[i][@"fromImageName"];
        info.ParentId = arr[i][@"parentId"];
        info.commentId = arr[i][@"commentId"];
        info.TOUSER = arr[i][@"from"];
        [commentsArr addObject:info];
    }
    HCHomeDetailInfo *info = [[HCHomeDetailInfo alloc] init];
    //点赞用户
    info.praiseArr = _arring;
    info.commentsArr = commentsArr;
    
    return info;
}

@end
