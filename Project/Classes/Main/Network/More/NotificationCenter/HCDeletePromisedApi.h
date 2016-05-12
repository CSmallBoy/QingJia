//
//  HCDeletePromisedApi.h
//  钦家
//
//  Created by Tony on 16/5/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCReportBlock) (HCRequestStatus requestStatus,NSString*message,id respone);

@interface HCDeletePromisedApi : HCRequest

@property (nonatomic, copy)NSString *callId;

-(void)startRequest:(HCReportBlock)requestBlock;

@end
