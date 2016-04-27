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
    NSMutableArray *userArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i ++) {
        //点赞显示的
        HCHomeDetailUserInfo *userInfo = [[HCHomeDetailUserInfo alloc] init];
        userInfo.uid = [NSString stringWithFormat:@"%d", i];
        userInfo.nickName = arr[i][@"from"];
        [userArr addObject:userInfo];
        

    }
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
        //info.FTContent = @"#李嬷嬷#回复:TableViewgithu@撒旦 哈哈哈哈#九歌#九邮m旦旦/:dsad旦/::)sss/::~啊是大三的拉了/::B/::|/:8-)/::</::$/链接:http://baidu.com dudl@qq.com";
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
    info.praiseArr = userArr;
    info.commentsArr = commentsArr;
    
    return info;
}

@end
