//
//  HCScanApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


typedef void(^HCScanBlock) (HCRequestStatus requestStatus,NSString *message,id  respone);

@interface HCScanApi : HCRequest

@property (nonatomic,strong) NSString *labelGuid;
@property (nonatomic,strong) NSString *createLocation;
-(void)startRequest:(HCScanBlock)requestBlock;

@end
