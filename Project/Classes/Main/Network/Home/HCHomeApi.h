//
//  HCHomeApi.h
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCHomeBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface HCHomeApi : HCRequest

@property (nonatomic, assign) NSInteger Start;
@property (nonatomic, assign) NSInteger Count;

- (void)startRequest:(HCHomeBlock)requestBlock;

@end
