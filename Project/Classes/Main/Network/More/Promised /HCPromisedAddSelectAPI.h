//
//  HCPromisedAddSelectAPI.h
//  Project
//
//  Created by 朱宗汉 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@class HCPromisedMissInfo;
typedef void(^HCPromisedSelectBlock) (HCRequestStatus requestStatus,NSString  *message,id data);

@interface HCPromisedAddSelectAPI : HCRequest

@property(nonatomic,strong)HCPromisedMissInfo  *missInfo;

-(void)startRequest:(HCPromisedSelectBlock)requestBlock;

@end
