//
//  HCGetCityInfoVersionApi.h
//  钦家
//
//  Created by Tony on 16/5/16.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCReportBlock) (HCRequestStatus requestStatus,NSString*message,id respone);

@interface HCGetCityInfoVersionApi : HCRequest

-(void)startRequest:(HCReportBlock)requestBlock;

@end
