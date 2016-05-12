//
//  HCGetCityInfoApi.h
//  钦家
//
//  Created by Tony on 16/5/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCReportBlock) (HCRequestStatus requestStatus,NSString*message,id respone);

@interface HCGetCityInfoApi : HCRequest

-(void)startRequest:(HCReportBlock)requestBlock;

@end
