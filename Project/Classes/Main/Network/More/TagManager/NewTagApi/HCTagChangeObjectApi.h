//
//  HCTagChangeObjectApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

// -------------------变更对象----------------------

@class HCNewTagInfo;

typedef void(^HCTagChangeObjectBlock) (HCRequestStatus requestStautus,NSString *message,id respone);

@interface HCTagChangeObjectApi : HCRequest

@property (nonatomic,strong) HCNewTagInfo *info;

@property (nonatomic,strong) NSString *objectId;

-(void)startRequest:(HCTagChangeObjectBlock)requestBlock;

@end

