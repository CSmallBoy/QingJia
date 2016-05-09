//
//  HCReportApi.h
//  钦家
//
//  Created by Tony on 16/5/8.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCReportBlock) (HCRequestStatus requestStatus,NSString*message,id respone);

@interface HCReportApi : HCRequest

@property (nonatomic, copy)NSString *callId;
@property (nonatomic, copy)NSString *imageNames;
@property (nonatomic, copy)NSString *content;
-(void)startRequest:(HCReportBlock)requestBlock;

@end
