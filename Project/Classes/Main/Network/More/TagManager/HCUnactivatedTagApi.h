//
//  HCUnactivatedTagApi.h
//  Project
//
//  Created by 朱宗汉 on 15/12/28.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


@class HCTagManagerInfo;

typedef void(^HCUnactivatedTagBlock)(HCRequestStatus requestStatus, NSString *message, HCTagManagerInfo *info);


@interface HCUnactivatedTagApi : HCRequest

- (void)startRequest:(HCUnactivatedTagBlock)requestBlock;

@property (nonatomic,strong) NSString *LabelStatus;
@property (nonatomic,assign) int Start;
@property (nonatomic,assign) int Count;


@end
