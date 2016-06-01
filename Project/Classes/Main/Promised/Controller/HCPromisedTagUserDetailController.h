//
//  HCTagUserDetailController.h
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTableViewController.h"

@interface HCPromisedTagUserDetailController : HCTableViewController

@property (nonatomic, assign)BOOL isObj;//是否有编辑按钮编辑

@property (nonatomic, assign)BOOL isNextStep;//是否有下一步按钮

@property (nonatomic, copy)NSString *objId;//对象id

@end
