//
//  HCSetPushTagApi.h
//  钦家
//
//  Created by Tony on 16/5/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCReportBlock) (HCRequestStatus requestStatus,NSString*message,id respone);

@interface HCSetPushTagApi : HCRequest

@property (nonatomic, copy)NSString *userTag;//
@property (nonatomic, copy)NSString *locationTag;//城市
@property (nonatomic, copy)NSString *currentAddress;//定位地址
@property (nonatomic, copy)NSString *currentLocation;//定位经纬度

-(void)startRequest:(HCReportBlock)requestBlock;

@end
