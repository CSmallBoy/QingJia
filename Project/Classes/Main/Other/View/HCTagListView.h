//
//  HCTagListView.h
//  HCTagListView
//
//  Created by bsoft on 15/10/27.
//  Copyright © 2015年 bsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCTagListView : UIView

/**
 * 设置整个标签的背景颜色
 */
@property (nonatomic, strong) UIColor *tagListBGColor;
/**
 * 设置整个标签的选中背景颜色
 */
@property (nonatomic, strong) UIColor *tagListSelectedBGColor;

/**
 * 设置整个标签的普通文字颜色
 */
@property (nonatomic, strong)UIColor *tagListTitleColor;
/**
 * 设置整个标签的选中文字颜色
 */
@property (nonatomic, strong)UIColor *tagListTitleSelectedColor;


/*
 * 字体大小
 */
@property (nonatomic, assign) CGFloat fontSize;

/*
 * 圆角radius
 */
@property (nonatomic, assign) CGFloat radius;
/*
 * 边框宽度
 */
@property (nonatomic, assign) CGFloat width;
/*
 * 边框颜色
 */
@property (nonatomic, strong) UIColor *radiusColor;


/*
 * 文字横向距边框的间距
 */
@property (nonatomic, assign) CGFloat valueWidthPadding;
/*
 * 文字竖向距边框的间距
 */
@property (nonatomic, assign) CGFloat valueHeightPadding;
/*
 * 最左边按钮距左屏幕边框的间距
 */
@property (nonatomic, assign) CGFloat leftMargin;
/*
 * 每个tag横向之间的间距
 */
@property (nonatomic, assign) CGFloat tagMargin;
/*
 * 每个tag竖向之间的间距
 */
@property (nonatomic, assign) CGFloat bottomMargin;


/**
 * 按钮是否可点击
 */
@property (nonatomic, assign) BOOL canTouch;


/*
 点击的标签以字典的形式回调
 */
@property (nonatomic, copy) void(^selectedTagDicBlock)(NSString *);


/**
 *  标签文本赋值，以字典形式
 */
- (void)setTagListWithTagDictionary:(NSDictionary *)dictionary;

/**
 *  标签文本赋值，以数组形式
 */
- (void)setTagListWithTagArray:(NSArray *)array;


@end
