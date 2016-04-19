//
//  HCTagUserFindApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/19.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void (^HCTagUserFindBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCTagUserFindApi : HCRequest

@property (nonatomic,strong) NSString *objectId;

-(void)startRequest:(HCTagUserFindBlock)requestBlock;

@end
