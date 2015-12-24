//
//  HCFooterView.h
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  enum
{
    HCFooterViewButtonTypeSave,
    HCFooterViewButtonTypeServer,
    HCFooterViewButtonTypePrivacy
}HCFooterViewButtonType;

@protocol HCFooterViewDelegate <NSObject>

- (void)hcfooterViewSelectedButton:(HCFooterViewButtonType)type;

@end

@interface HCFooterView : UIView

@property (nonatomic, weak) id<HCFooterViewDelegate>delegate;

@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *serverButton;
@property (nonatomic, strong) UIButton *privacyButton;

@end
