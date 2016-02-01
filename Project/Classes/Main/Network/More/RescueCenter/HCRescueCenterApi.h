//
//  HCRescueCenter.h
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCResCueCenterBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface HCRescueCenterApi : HCRequest

- (void)startRequest:(HCResCueCenterBlock)requestBlock;

@property (nonatomic, assign) int Start;
@property (nonatomic, assign) int Count;

@end
