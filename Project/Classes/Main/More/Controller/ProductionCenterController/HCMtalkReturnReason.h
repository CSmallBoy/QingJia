//
//  HCMtalkReturnReason.h
//  Project
//
//  Created by 朱宗汉 on 16/3/18.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTableViewController.h"

typedef void(^changeReasonBlock) (NSString *str);

@interface HCMtalkReturnReason : HCTableViewController

@property (nonatomic,strong) changeReasonBlock block;

@end
