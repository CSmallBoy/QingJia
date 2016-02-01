//
//  HCPromisedListAPI.h
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HCPromisedListBlock) (HCRequestStatus  requestStatus,NSString  *message,NSMutableArray  *array);

@interface HCPromisedListAPI : HCRequest


@property (nonatomic,assign) int Start;

-(void)startRequest:(HCPromisedListBlock)requestBlock;
 
@end
