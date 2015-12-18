//
//  HCEditCommentView.h
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCEditCommentViewDelegate <NSObject>

- (void)hceditCommentViewWithButtonIndex:(NSInteger)index;

- (void)hceditCommentViewWithimageButton:(NSInteger)index;

- (void)hceditCommentViewWithDeleteImageButton:(NSInteger)index;

@end

@interface HCEditCommentView : UIView

@property (nonatomic, strong) UIScrollView *imageScrollView;

@property (nonatomic, strong) id<HCEditCommentViewDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *imageArr;

@end
