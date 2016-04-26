//
//  HCClosePromisedApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCClosePromisedBlock) (HCRequestStatus requestStatus,NSString*message,id respone);

@interface HCClosePromisedApi : HCRequest

@property (nonatomic,strong) NSString *callId;

-(void)startRequest:(HCClosePromisedBlock)requestBlock;

@end
