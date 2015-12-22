//
//  HCPraiseTagListView.h
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCPraiseTagListViewDelegate <NSObject>

- (void)hcpraiseTagListViewSelectedTag:(NSInteger)index;

@end

@interface HCPraiseTagListView : UIView

/**
 *  标签文本赋值，以数组形式
 */
- (void)setPraiseTagListWithTagArray:(NSArray *)array;

@property (nonatomic, weak) id<HCPraiseTagListViewDelegate>delegate;

@end
