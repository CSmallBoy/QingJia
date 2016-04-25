//
//  NHCHomeSingleFigureApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/18.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@interface NHCHomeSingleFigureApi : HCRequest
@property (nonatomic,copy) NSString * TimeID;
@property (nonatomic,copy) NSString * ToimageName;
@property (nonatomic,copy) NSString * Content;
@property (nonatomic,copy) NSString * CoreateLocation;
@property (nonatomic,copy) NSString * createAddrSmall;
@property (nonatomic,copy) NSString * createAddr;
@property (nonatomic,copy) NSString * toUser;



@property (nonatomic,copy) NSString *parentCommentId;
@end
