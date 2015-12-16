//
//  HCUpdateMgr.m
//  HealthCloud
//
//  Created by Vincent on 15/9/17.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCVersionMgr.h"


static HCVersionMgr *_sharedManager = nil;

@implementation HCVersionMgr

//创建单例
+ (instancetype)manager
{
    if (!_sharedManager) {
        _sharedManager = [[HCVersionMgr alloc] init];
    }
    return _sharedManager;
}

- (void)checkFirVersion
{
    NSString * url_str = [NSString stringWithFormat:@"http://zp.ysrlin.com/api?t=Frame,version"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:url_str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data = responseObject[@"data"];
        // 服务端 version 与 本地 version
        NSString * version = [data objectForKey:@"ios"];
        
        if ([APP_VERSION compare:version options:NSNumericSearch] == NSOrderedAscending) {
            
            _updateURL = data[@"update_url"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"有新版本啦"
                                                            message:data[@"changelog"]
                                                           delegate:self
                                                  cancelButtonTitle:@"立即升级"
                                                  otherButtonTitles:@"忽略", nil];
            [alert show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateURL]];
    }
}


@end
