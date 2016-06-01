//
//  HCTagUserDetailController.h
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTableViewController.h"

@interface HCAddTagUserController : HCTableViewController

@property (nonatomic,assign) BOOL  isEdit;

@property (nonatomic,assign) BOOL isEditTag;

@property (nonatomic, assign)BOOL isNewObj;//YES:新增标签使用者,NO:编辑标签使用者
@end
