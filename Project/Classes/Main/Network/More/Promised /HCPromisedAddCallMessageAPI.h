//
//  HCPromisedAddCallMessage.h
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@class HCPromisedDetailInfo;
@class HCPromisedMissInfo;
typedef void(^HCPromisedAddCallMessageBlock)(HCRequestStatus requestStatus, NSString *message, id data);


@interface HCPromisedAddCallMessageAPI : HCRequest
@property (nonatomic, strong) NSString *Token;
@property(nonatomic,strong) HCPromisedDetailInfo  *info;
@property(nonatomic,strong) HCPromisedMissInfo    *missInfo;

-(void)startRequest:(HCPromisedAddCallMessageBlock)requestBlock;

@end

