//
//  HCTagUserAmostListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/19.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


typedef void(^HCTagUserAmostListBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCTagUserAmostListApi : HCRequest

-(void)startRequest:(HCTagUserAmostListBlock)requestBlock;

@end
