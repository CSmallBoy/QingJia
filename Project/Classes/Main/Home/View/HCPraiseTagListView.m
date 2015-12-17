//
//  HCPraiseTagListView.m
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPraiseTagListView.h"

@interface HCPraiseTagListView()

@property (nonatomic, assign) NSInteger totalHeight; // 整个view的高度
@property (nonatomic, assign) CGRect previousFrame;

@property (nonatomic, strong) NSMutableArray *tagArray;

@end

@implementation HCPraiseTagListView

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
        
        if ([key integerValue] != dictionary.count - 1)
        {
            value = [NSString stringWithFormat:@"%@、", value];
        }
        btn.tag = [key integerValue];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [btn setTitle:value forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(handleTagButton:) forControlEvents:UIControlEventTouchUpInside];
        
        NSDictionary *attriDic = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        CGSize size_value = [value sizeWithAttributes:attriDic];
        size_value.width ++;
        size_value.height ++;
        
        CGRect newRect = CGRectZero;
        
        if (_previousFrame.origin.x+_previousFrame.size.width+size_value.width > self.bounds.size.width)
        {
            newRect.origin = CGPointMake(0, _previousFrame.origin.y + size_value.height);
            _totalHeight += size_value.height ;
        }
        else
        {
            newRect.origin = CGPointMake(_previousFrame.origin.x+_previousFrame.size.width, _previousFrame.origin.y);
        }
        
        newRect.size = size_value;
        btn.frame = newRect;
        _previousFrame = newRect;
        
        [self setupTotalHeightWithHeight:_totalHeight+size_value.height];
        
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
    DLog(@"点击了---%@", @(button.tag));
}




@end
