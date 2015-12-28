//
//  HCRootTabBarController.h
//  HealthCloud
//
//  Created by Vincent on 15/11/5.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCRootTabBarController : UITabBarController
{
    EMConnectionState _connectionState;
}
@property (nonatomic, assign) NSInteger selIndex;

- (void)jumpToChatList;

- (void)setupUntreatedApplyCount;

- (void)networkChanged:(EMConnectionState)connectionState;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;

@end
