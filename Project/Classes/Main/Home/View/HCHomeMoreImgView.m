//
//  HCHomeMoreImgView.m
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCHomeMoreImgView.h"
#import "UIImageView+WebCache.h"

@interface HCHomeMoreImgView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *markLabel;

@end

@implementation HCHomeMoreImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)hchomeMoreImgViewWithUrlStringArray:(NSArray *)array
{
    CGFloat imgViewWith = (SCREEN_WIDTH-40) / 3;
    self.contentSize = CGSizeMake((SCREEN_WIDTH/3)*array.count, imgViewWith);
    for (NSInteger i = 0; i < array.count; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewWith*i+10*(i+1), 0, imgViewWith, imgViewWith)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:OrigIMG(@"publish_picture")];
        [self addSubview:imgView];
        
        if (i == 3)
        {
            self.markLabel.text = [NSString stringWithFormat:@">%@", @(array.count)];
            [imgView addSubview:self.markLabel];
        }
    }
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        CGFloat scrollViewH = (SCREEN_WIDTH-30) / 3;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, scrollViewH)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.backgroundColor = [UIColor lightGrayColor];
    }
    return _scrollView;
}

- (UILabel *)markLabel
{
    if (!_markLabel)
    {
        CGFloat height = ((SCREEN_WIDTH-40) / 3 )*0.5;
        _markLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, height, height)];
        _markLabel.font = [UIFont systemFontOfSize:30];
        _markLabel.backgroundColor = RGBA(0, 0, 0, 0);
    }
    return _markLabel;
}


@end
