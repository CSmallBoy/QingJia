//
//  HCJurisdictionViewController.h
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTableViewController.h"

@protocol HCJurisdictionVCDelegate <NSObject>

/*
 PermitType 权限类型 permitUserArr 不可见人的数组
 */

@optional
- (void)hcJurisdictionViewControllerWithPermitType:(NSString *)PermitType permitUserArr:(NSMutableArray *)permitUserArr;

@end

@interface HCJurisdictionViewController : HCTableViewController

@property (nonatomic, weak) id<HCJurisdictionVCDelegate>delegate;

@end
