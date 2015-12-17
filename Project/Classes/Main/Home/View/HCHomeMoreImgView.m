//
//  HCHomeMoreImgView.m
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeMoreImgView.h"
//#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface HCHomeMoreImgView()

@end

@implementation HCHomeMoreImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)handleButton:(UIButton *)button
{
    if ([self.delegates respondsToSelector:@selector(hchomeMoreImgView:)])
    {
        [self.delegates hchomeMoreImgView:button.tag];
    }
}

- (void)hchomeMoreImgViewWithUrlStringArray:(NSArray *)array
{
    CGFloat imgViewWith = (SCREEN_WIDTH-40) / 3;
    NSInteger count =  (3 - array.count % 3)%3;
    self.contentSize = CGSizeMake((SCREEN_WIDTH/3)* (array.count + count), imgViewWith);
    [self removeAllSubviews];
    for (NSInteger i = 0; i < array.count; i++)
    {
        NSInteger page = (int)(i)/3+1;
        CGFloat imgViewX = imgViewWith*i + 10*(i) + 10 *page;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(imgViewX, 0, imgViewWith, imgViewWith);
        button.tag = i;
        [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [button sd_setImageWithURL:[NSURL URLWithString:array[i]] forState:UIControlStateNormal placeholderImage:OrigIMG(@"publish_picture")];
        [self addSubview:button];
        
        if (i == 2)
        {
            self.markLabel.text = [NSString stringWithFormat:@"%@ >", @(array.count)];
            
            NSDictionary *attriDic = @{NSFontAttributeName: [UIFont systemFontOfSize:30]};
            CGSize size_value = [self.markLabel.text sizeWithAttributes:attriDic];
            self.markLabel.frame = CGRectMake(imgViewWith-size_value.width, imgViewWith-size_value.height, size_value.width, size_value.height);
            [button addSubview:self.markLabel];
        }
    }
}

- (UILabel *)markLabel
{
    if (!_markLabel)
    {
        _markLabel = [[UILabel alloc] init];
        _markLabel.font = [UIFont systemFontOfSize:30];
        _markLabel.textColor = [UIColor whiteColor];
        _markLabel.backgroundColor = RGBA(0, 0, 0, 0.3);
    }
    return _markLabel;
}


@end
