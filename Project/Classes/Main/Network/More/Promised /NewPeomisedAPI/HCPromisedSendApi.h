//
//  HCPromisedSendApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/21.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void (^HCPromisedSendBlock) (HCRequestStatus request,NSString *message,id respone);

@class HCNewTagInfo;
@interface HCPromisedSendApi : HCRequest

@property (nonatomic,strong) NSString *lossTime;
@property (nonatomic,strong) NSString *callLocation; // 经纬度
@property (nonatomic,strong) NSString *lossAddress;
@property (nonatomic,strong) NSString *lossDesciption;
@property (nonatomic,strong) NSString *lossImageName;
@property (nonatomic,strong) NSArray *tagArr;
@property (nonatomic,strong) NSArray *ContractArr;
@property (nonatomic,copy)NSString *lossCityId;//走失城市id

@property (nonatomic,strong) HCNewTagInfo *info;


-(void)startRequest:(HCPromisedSendBlock)requestBlock;

@end
