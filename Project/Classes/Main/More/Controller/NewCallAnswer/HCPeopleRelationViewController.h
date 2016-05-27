//
//  HCPeopleRelationViewController.h
//  钦家
//
//  Created by Tony on 16/5/26.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCViewController.h"

@protocol HCPeopleRelationViewControllerDelegate <NSObject>

- (void)selectedRelation:(NSString *)relation;

@end

@interface HCPeopleRelationViewController : HCViewController

@property (nonatomic, assign)id<HCPeopleRelationViewControllerDelegate> delegate;

@end
