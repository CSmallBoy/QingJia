//
//  HCLeftView.h
//  Project
//
//  Created by 陈福杰 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    HCLeftViewButtonTypeHead,
    HCLeftViewButtonTypeCreateGrade,
    HCLeftViewButtonTypeJoinGrade,
    HCLeftViewButtonTypeSoftwareSet
}HCLeftViewButtonType;

@protocol HCLeftViewDelegate <NSObject>

- (void)hcleftViewSelectedButtonType:(HCLeftViewButtonType)type;

@end

@interface HCLeftView : UIView

@property (nonatomic, strong) UIButton *headButton;
@property (nonatomic, strong)  UILabel *nickName;

@property (nonatomic, weak) id<HCLeftViewDelegate>delegate; 

@end
