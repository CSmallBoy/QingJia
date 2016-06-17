//
//  HCScanCardApi.h
//  钦家
//
//  Created by Tony on 16/6/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCReportBlock) (HCRequestStatus requestStatus,NSString*message,id respone);

@interface HCScanCardApi : HCRequest

@property (nonatomic, copy)NSString *labelGuid;
@property (nonatomic, copy)NSString *createLocation;

-(void)startRequest:(HCReportBlock)requestBlock;

@end
