//
//  HCMessageCenterListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/21.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

//
typedef void(^HCMessageCenterListBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCMessageCenterListApi : HCRequest

@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSString *_start;
@property (nonatomic,strong) NSString *_count;
//
-(void)startRequest:(HCMessageCenterListBlock)requestBlock;

@end
