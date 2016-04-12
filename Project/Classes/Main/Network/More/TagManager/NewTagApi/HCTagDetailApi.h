//
//  HCTagDetailApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

// -------------------获取标签详细信息----------------------

typedef void (^HCTagDetailBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCTagDetailApi : HCRequest

@property (nonatomic,strong) NSString *labelId;

-(void)startRequest:(HCTagDetailBlock)requestBlock;


@end
