//
//  HCTagStopUseApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

// -------------------停用标签----------------------

typedef void(^HCTagStopUseBlock) (HCRequestStatus  requestStatus,NSString *message,id respone);

@interface HCTagStopUseApi : HCRequest

@property (nonatomic,strong) NSString *labelId;

-(void)startRequest:(HCTagStopUseBlock)requestBlock;

@end
