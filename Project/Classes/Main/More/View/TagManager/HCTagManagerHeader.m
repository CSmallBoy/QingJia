//
//  HCTagManagerHeader.m
//  Project
//
//  Created by 朱宗汉 on 15/12/27.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTagManagerHeader.h"



@interface HCTagManagerHeader()

@property (nonatomic, strong) UILabel *title;

@end

@implementation HCTagManagerHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.title];
        [self addSubview:self.markImgView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.markImgView.frame = CGRectMake(10, 20, 12, 12);
    self.title.frame = CGRectMake(MaxX(self.markImgView)+10, 0, SCREEN_WIDTH-MaxX(self.markImgView)-10, 50);
}

#pragma mark - setter or getter

- (void)setTitleString:(NSString *)titleString
{
    self.title.text = [NSString stringWithFormat:@"%@的标签",titleString];
}


- (UILabel *)title
{
    if (!_title)
    {
        _title = [[UILabel alloc] init];
        _title.textColor = DarkGrayColor;
        _title.font = [UIFont systemFontOfSize:15];
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}

- (UIImageView *)markImgView
{
    if (!_markImgView)
    {
        _markImgView = [[UIImageView alloc] init];
        _markImgView.image = OrigIMG(@"list_close");
    }
    return _markImgView;
}


@end
