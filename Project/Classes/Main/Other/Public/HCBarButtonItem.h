//
//  HCBarButtonItem.h
//  HealthCloud
//
//  Created by Vincent on 15/9/11.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCBarButtonItem : UIBarButtonItem

//返回按钮
- (id)initWithBackTarget:(id)target action:(SEL)action;
//
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
