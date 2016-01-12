//
//  HCHomeDetailApi.h
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@class HCHomeDetailInfo;

typedef void(^HCHomeDetailBlock)(HCRequestStatus requestStatus, NSString *message, HCHomeDetailInfo *info);

@interface HCHomeDetailApi : HCRequest

@property (nonatomic, strong) NSString *FTID;
@property (nonatomic, strong) NSString *ParentId;
@property (nonatomic, strong) NSString *ItemId;

- (void)startRequest:(HCHomeDetailBlock)requestBlock;

@end
