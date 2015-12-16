//
//  HCDataMgr.h
//  HealthCloud
//
//  Created by Vincent on 15/9/16.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDataMgr : NSObject

@property (nonatomic, assign) BOOL needUpdate;
@property (nonatomic, assign) BOOL needRequesUpdate;

//创建单例
+ (instancetype)manager;
+ (void)clean;

@end
