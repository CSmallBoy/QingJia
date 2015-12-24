//
//  HCJoinGradeFunctionView.h
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HCJoinGradeFunctionViewButtonStypeScan,
    HCJoinGradeFunctionViewButtonStypeJoin
}HCJoinGradeFunctionViewButtonStype;

@protocol HCJoinGradeFunctionViewDelegate <NSObject>

- (void)hcjoinGradeFunctionViewSelectedType:(HCJoinGradeFunctionViewButtonStype)type;

@end

@interface HCJoinGradeFunctionView : UIView

@property (nonatomic, weak) id<HCJoinGradeFunctionViewDelegate>delegate;

@end
