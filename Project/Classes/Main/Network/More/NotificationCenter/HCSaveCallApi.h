//
//  HCSaveCallApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
// ------------------收藏 -----------------------------

typedef void (^HCSaveCallBlock) (HCRequestStatus  requestStatus,NSString *message,id respone);
@interface HCSaveCallApi : HCRequest

@property (nonatomic,copy) NSString *callId;

-(void)startRequest:(HCSaveCallBlock)requestBlock;

@end
