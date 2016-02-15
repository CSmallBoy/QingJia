//
//  HCAddPromiseViewController1.h
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTableViewController.h"

typedef void(^showRadarViewBlock)(BOOL isShow);

@interface HCPromiseDetailViewController1 : HCTableViewController

@property(nonatomic,strong)showRadarViewBlock block;
@end
