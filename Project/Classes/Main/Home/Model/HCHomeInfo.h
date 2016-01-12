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


@end
