//
//  HCPraiseTagListView.m
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPraiseTagListView.h"
#import "HCHomeDetailUserInfo.h"

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

- (void)setPraiseTagListWithTagArray:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:array];
    HCHomeDetailUserInfo *info = [[HCHomeDetailUserInfo alloc] init];
    info.uid = @"242424";
    info.nickName = @"时光";
    [arrayM insertObject:info atIndex:0];
    
    for (NSInteger i = 0; i < arrayM.count; i++)
    {
        HCHomeDetailUserInfo *info = arrayM[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        NSString *title = nil;
        if (i != arrayM.count - 1 && i != 0)
        {
            title = [NSString stringWithFormat:@"%@、", info.nickName];
        }else
        {
            title = info.nickName;
        }
        
        btn.tag = [info.uid integerValue];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        if (i == 0)
        {
            [btn setImage:OrigIMG(@"Like_nor") forState:UIControlStateNormal];
        }else
        {
            [btn setTitle:title forState:UIControlStateNormal];
            //[btn setTitle:arrayM[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(handleTagButton:) forControlEvents:UIControlEventTouchUpInside];
        }

        NSDictionary *attriDic = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        CGSize size_value = [title sizeWithAttributes:attriDic];
        
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
    }
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
    if ([self.delegate respondsToSelector:@selector(hcpraiseTagListViewSelectedTag:)])
    {
        [self.delegate hcpraiseTagListViewSelectedTag:button.tag];
    }
}




@end
