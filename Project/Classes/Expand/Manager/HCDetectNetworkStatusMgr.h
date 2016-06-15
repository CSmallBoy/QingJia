//
//  HCDetectNetworkStatusMgr.h
//  钦家
//
//  Created by Tony on 16/6/14.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HCDetectNetworkStatusBlock) (AFNetworkReachabilityStatus networkStatus);

@interface HCDetectNetworkStatusMgr : NSObject

/**
 *  网络状态管理类
 */
+ (HCDetectNetworkStatusMgr *)shareManager;

/**
 *  监测网络状态
 *
 *  @return 网络状态
 */
- (void)detectNetworkStatus:(HCDetectNetworkStatusBlock)statusBlock;

@end
