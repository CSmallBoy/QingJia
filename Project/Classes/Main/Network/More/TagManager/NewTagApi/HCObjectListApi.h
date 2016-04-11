//
//  HCObjectListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

// -------------------对象列表----------------------

typedef void (^HCObjectListBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCObjectListApi : HCRequest

-(void)startRequest:(HCObjectListBlock)requestBlock;

@end
