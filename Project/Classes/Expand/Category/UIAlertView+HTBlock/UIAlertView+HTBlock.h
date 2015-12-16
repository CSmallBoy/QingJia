//
//  UIAlertView+HTBlock.h
//
//  Created by Allen Foo on 15/1/19.
//  Copyright (c) 2015年 Allen Foo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertView_block_self_index)(UIAlertView *alertView, NSInteger btnIndex);
typedef void(^UIAlertView_block_self)(UIAlertView *alertView);
typedef BOOL(^UIAlertView_block_shouldEnableFirstOtherButton)(UIAlertView *alertView);

@interface UIAlertView (HTBlock)

- (void)handlerClickedButton:(UIAlertView_block_self_index)aBlock;
- (void)handlerCancel:(UIAlertView_block_self)aBlock;
- (void)handlerWillPresent:(UIAlertView_block_self)aBlock;
- (void)handlerDidPresent:(UIAlertView_block_self)aBlock;
- (void)handlerWillDismiss:(UIAlertView_block_self_index)aBlock;
- (void)handlerDidDismiss:(UIAlertView_block_self_index)aBlock;
- (void)handlerShouldEnableFirstOtherButton:(UIAlertView_block_shouldEnableFirstOtherButton)aBlock;

@end
