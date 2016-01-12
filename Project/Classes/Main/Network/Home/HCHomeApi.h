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

@property (nonatomic, strong) NSString *Start;

- (void)startRequest:(HCHomeBlock)requestBlock;

@end
