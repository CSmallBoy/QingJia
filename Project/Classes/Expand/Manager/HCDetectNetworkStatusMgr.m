//
//  HCDetectNetworkStatusMgr.m
//  钦家
//
//  Created by Tony on 16/6/14.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCDetectNetworkStatusMgr.h"

static HCDetectNetworkStatusMgr *_shareManager = nil;

@implementation HCDetectNetworkStatusMgr

+ (HCDetectNetworkStatusMgr *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[HCDetectNetworkStatusMgr alloc] init];
    });
    return _shareManager;
}

- (void)detectNetworkStatus:(HCDetectNetworkStatusBlock)statusBlock
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (statusBlock)
        {
            statusBlock(status);
        }
    }];
    
}


@end
