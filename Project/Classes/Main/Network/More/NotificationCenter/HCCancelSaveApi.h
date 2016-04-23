//
//  HCCancelSaveApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void (^HCCancelSaveBlock) (HCRequestStatus  requestStatus,NSString *message,id respone);

@interface HCCancelSaveApi : HCRequest

@property (nonatomic,strong) NSString *callId;

-(void)startRequest:(HCCancelSaveBlock)requestBlock;

@end
