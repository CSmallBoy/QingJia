//
//  HCHomeInfo.h
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCHomeInfo : NSObject

@property (nonatomic, strong) NSString *KeyId;
@property (nonatomic, strong) NSString *FamilyID;
@property (nonatomic, strong) NSString *UserID;
@property (nonatomic, strong) NSString *NickName;
@property (nonatomic, strong) NSString *HeadImg;
@property (nonatomic, strong) NSArray  *FTImages;
@property (nonatomic, strong) NSString *FTContent;
@property (nonatomic, strong) NSString *FTReplyCount;
@property (nonatomic, strong) NSString *FTLikeCount;
@property (nonatomic, strong) NSString *CreateTime;
@property (nonatomic, strong) NSString *CreateLocation;
@property (nonatomic, strong) NSString *CreateAddrSmall;
@property (nonatomic, strong) NSString *CreateAddr;
@property (nonatomic, strong) NSString *TimeID;

@property (nonatomic, strong) NSString *ParentId;
@property (nonatomic, strong) NSString *FTID;
@property (nonatomic, strong) NSString *ItemId;
//创建时光的人  就是userid
@property (nonatomic, strong) NSString *creator;
@property (nonatomic, strong) NSString *isLike;
@property (nonatomic, strong) NSString *fromFamily;
//创建一个数组
@property (nonatomic, strong) NSArray *subRows;
//来自谁的头像
@property (nonatomic, copy)NSString *fromImageName;
//点赞的人
@property (nonatomic, strong) NSArray *isLikeArr;
//
@property (nonatomic, copy) NSString *commentId;
//对用户
@property (nonatomic, copy) NSString *TOUSER;
//点赞人数
@property (nonatomic, copy)NSString *likeCount;
//定位显示
@property (nonatomic, copy)NSString *openAddress;


@end
