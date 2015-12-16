//
//  HCViewController.h
//  HealthCloud
//
//  Created by Vincent on 15/9/11.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCRequest.h"

@interface HCViewController : UIViewController
{
    HCRequest    *_baseRequest;
}

@property (nonatomic, strong) NSDictionary *data;

//设置返回按钮
- (void)setupBackItem;
- (void)backBtnClick;

/**
 *  请求请求系统错误提示
 *
 *  @param error 错误内容
 */
- (void)showErrorHint:(NSError *)error;
- (void)showHUDText:(NSString *)content;
- (void)showHUDView:(NSString *)text;
- (void)showHUDError:(NSString *)error;
- (void)showHUDSuccess:(NSString *)success;
- (void)hideHUDView;
@end
