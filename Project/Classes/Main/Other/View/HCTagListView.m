//
//  HCTagListView.m
//  HCTagListView
//
//  Created by bsoft on 15/10/27.
//  Copyright © 2015年 bsoft. All rights reserved.
//

#import "HCTagListView.h"

@interface HCTagListView()

@property (nonatomic, assign) NSInteger totalHeight; // 整个view的高度
@property (nonatomic, assign) CGRect previousFrame;

@property (nonatomic, strong) NSMutableArray *tagArray;

@end

@implementation HCTagListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _totalHeight = 0;
        _previousFrame = CGRectZero;
    }
    return self;
}

// tag为数组形式

- (void)setTagListWithTagArray:(NSArray *)array
{
    NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithCapacity:1];
    for (NSInteger i = 0; i < array.count; i++)
    {
        [dicM setObject:array[i] forKey:@(i)];
    }
    [self setTagListWithTagDictionary:dicM];
}

// tag为字典形式

- (void)setTagListWithTagDictionary:(NSDictionary *)dictionary
{
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = [key integerValue];
        btn.backgroundColor = self.tagListBGColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        
        [btn setTitle:value forState:UIControlStateNormal];
        [btn setTitleColor:self.tagListTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:self.tagListTitleSelectedColor forState:UIControlStateSelected];
        
        btn.userInteractionEnabled = self.canTouch;
        [btn addTarget:self action:@selector(handleTagButton:) forControlEvents:UIControlEventTouchUpInside];
        ViewBorderRadius(btn, self.radius, self.width, self.radiusColor);
        
        NSDictionary *attriDic = @{NSFontAttributeName: [UIFont systemFontOfSize:self.fontSize]};
        CGSize size_value = [value sizeWithAttributes:attriDic];
        size_value.width += self.valueWidthPadding;
        size_value.height += self.valueHeightPadding;
        
        CGRect newRect = CGRectZero;
        
        if (_previousFrame.origin.x+_previousFrame.size.width+size_value.width+self.tagMargin > self.bounds.size.width)
        {
            newRect.origin = CGPointMake(self.leftMargin, _previousFrame.origin.y + size_value.height+self.bottomMargin);
            _totalHeight += size_value.height + self.bottomMargin;
        }
        else
        {
            newRect.origin = CGPointMake(_previousFrame.origin.x+_previousFrame.size.width+ self.leftMargin, _previousFrame.origin.y);
        }
        
        newRect.size = size_value;
        btn.frame = newRect;
        _previousFrame = newRect;
        
        [self setupTotalHeightWithHeight:_totalHeight+size_value.height+self.bottomMargin];
        
        [self addSubview:btn];
    }];
}


#pragma mark - private methods

// 设置整个view的高度

- (void)setupTotalHeightWithHeight:(CGFloat)height
{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}

// 处理按钮的点击

- (void)handleTagButton:(UIButton *)button
{
    if (self.selectedTagDicBlock)
    {
        self.selectedTagDicBlock(button.titleLabel.text);
    }
}

#pragma mark - setter or getter

// 设置整个标签的背景颜色，如果为空设置默认

- (UIColor *)tagListBGColor
{
    if (!_tagListBGColor)
    {
        _tagListBGColor = [UIColor clearColor];
    }
    return _tagListBGColor;
}

// 设置整个标签的普通文字颜色

- (UIColor *)tagListTitleColor
{
    if (!_tagListTitleColor)
    {
        _tagListTitleColor = RGB(179, 179, 179);
    }
    return _tagListTitleColor;
}

// 设置整个标签的选中文字颜色

- (UIColor *)tagListTitleSelectedColor
{
    if (!_tagListTitleSelectedColor)
    {
        _tagListTitleSelectedColor = [UIColor whiteColor];
    }
    return _tagListTitleSelectedColor;
}

// 边框颜色

- (UIColor *)radiusColor
{
    if (!_radiusColor)
    {
        return RGB(179, 179, 179);
    }
    return _radiusColor;
}

// 字体大小

- (CGFloat)fontSize
{
    if (!_fontSize)
    {
        return 13;
    }
    return _fontSize;
}

// 边框宽度

- (CGFloat)width
{
    if (!_width)
    {
        return 1;
    }
    return _width;
}

// 圆角radius

- (CGFloat)radius
{
    if (!_radius)
    {
        return 3;
    }
    return _radius;
}

// 按钮是否可点击

- (BOOL)canTouch
{
    if (!_canTouch)
    {
        return YES;
    }
    return NO;
}

// 文字横向距边框的间距

- (CGFloat)valueWidthPadding
{
    if (!_valueWidthPadding)
    {
        return 15.0f;
    }
    return _valueWidthPadding;
}

// 文字竖向距边框的间距

- (CGFloat)valueHeightPadding
{
    if (!_valueHeightPadding)
    {
        return 10.0f;
    }
    return _valueHeightPadding;
}

// 最左边按钮距左屏幕边框的间距

- (CGFloat)leftMargin
{
    if (!_leftMargin)
    {
        return 20.0f;
    }
    return _leftMargin;
}

// 每个tag横向之间的间距

- (CGFloat)tagMargin
{
    if (!_tagMargin)
    {
        return 15.0f;
    }
    return _tagMargin;
}

// 每个tag竖向之间的间距

- (CGFloat)bottomMargin
{
    if (!_bottomMargin)
    {
        return 10.0f;
    }
    return _bottomMargin;
}


@end
