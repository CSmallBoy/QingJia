//
//  HCTagAddObjectApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

// -------------------添加对象----------------------

@class HCNewTagInfo;

typedef void(^HCTagAddObjectBlock) (HCRequestStatus  requestStatus,NSString *message,id respone);

@interface HCTagAddObjectApi : HCRequest

@property (nonatomic,strong) HCNewTagInfo *info;

-(void)startRequest:(HCTagAddObjectBlock)requestBlock;

@end
