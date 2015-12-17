//
//  HCHomeMoreImgView.h
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCHomeMoreImgViewDelegate <NSObject>

- (void)hchomeMoreImgView:(NSInteger)index;

@end

@interface HCHomeMoreImgView : UIScrollView

@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, weak) id<HCHomeMoreImgViewDelegate>delegate;

- (void)hchomeMoreImgViewWithUrlStringArray:(NSArray *)array;


@end
