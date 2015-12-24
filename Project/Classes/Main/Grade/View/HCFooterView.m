//
//  HCFooterView.m
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCFooterView.h"

@interface HCFooterView()


@end

@implementation HCFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.saveButton];
        [self addSubview:self.label];
        [self addSubview:self.serverButton];
        [self addSubview:self.privacyButton];
    }
    return self;
}

#pragma mark - private methods

- (void)handleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(hcfooterViewSelectedButton:)])
    {
        [self.delegate hcfooterViewSelectedButton:(HCFooterViewButtonType)button.tag];
    }
}

#pragma mark - setter or getter

- (UIButton *)saveButton
{
    if (!_saveButton)
    {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.frame = CGRectMake(15, 30, WIDTH(self)-30, 44);
        ViewRadius(_saveButton, 4);
        _saveButton.tag = HCFooterViewButtonTypeSave;
        [_saveButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_saveButton setTitle:@"完成创建" forState:UIControlStateNormal];
        _saveButton.backgroundColor = RGB(251, 25, 53);
    }
    return _saveButton;
}

- (UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(self.saveButton)+20, WIDTH(self), 20)];
        _label.text = @"点击上面按钮“完成创建”即表示您同意";
        _label.textColor = RGB(200, 200, 200);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:13];
    }
    return _label;
}

- (UIButton *)serverButton
{
    if (!_serverButton)
    {
        _serverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _serverButton.frame = CGRectMake(WIDTH(self)*0.5-85, MaxY(self.label), 90, 44);
        _serverButton.tag = HCFooterViewButtonTypeServer;
        [_serverButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_serverButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _serverButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_serverButton setTitle:@"《服务协议》" forState:UIControlStateNormal];
    }
    return _serverButton;
}

- (UIButton *)privacyButton
{
    if (!_privacyButton)
    {
        _privacyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _privacyButton.tag = HCFooterViewButtonTypePrivacy;
        [_privacyButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        _privacyButton.frame = CGRectMake(WIDTH(self)*0.5, MaxY(self.label), 90, 44);
        _privacyButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_privacyButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_privacyButton setTitle:@"《服务协议》" forState:UIControlStateNormal];
    }
    return _privacyButton;
}

@end
