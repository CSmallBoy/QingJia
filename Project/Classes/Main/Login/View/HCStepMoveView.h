//
//  PMStepMoveView.h
//  PMedical
//
//  Created by Vincent on 15/6/2.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCStepMoveView : UIView
{
    
}

//当前位置
@property (nonatomic, assign) NSUInteger  currentStep;
//每一步的名称
@property (nonatomic, strong) NSArray     *stepTitles;

//移动到某一步
- (void)moveToStep:(NSUInteger)step;

@end
