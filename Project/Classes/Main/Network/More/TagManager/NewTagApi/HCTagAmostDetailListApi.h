//
//  HCTagAmostDetailListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

// -------------------标签概要信息列表----------------------

typedef void(^HCTagAmostDetailListBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCTagAmostDetailListApi : HCRequest

@property (nonatomic,strong) NSString *labelStatus;

-(void)startRequest:(HCTagAmostDetailListBlock)requestBlock;

@end
