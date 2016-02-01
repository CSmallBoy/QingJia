//
//  HCLeftGradeView.h
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    HCLeftGradeViewButtonTypeGradeButton,
    HCLeftGradeViewButtonTypeHead,
    HCLeftGradeViewButtonTypeSoftwareSet,
    HCLeftGradeViewFamily
}HCLeftGradeViewButtonType;

@protocol HCLeftGradeViewDelegate <NSObject>

- (void)hcleftGradeViewSelectedButtonType:(HCLeftGradeViewButtonType)type;

@end

@interface HCLeftGradeView : UIView

@property (nonatomic, weak) id<HCLeftGradeViewDelegate>delegate;

@property (nonatomic, strong) UIButton *headButton;
@property (nonatomic, strong)  UILabel *nickName;

@property (nonatomic, strong) UIButton *gradeHeadButton;
@property (nonatomic, strong) UILabel *gradeName;
//我的家族
@property (nonatomic, strong) UIButton *familyButton;

@end
