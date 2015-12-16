//
//  PMNavTabBar.m
//  PMedical
//
//  Created by Vincent on 15/6/23.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

#import "HCNavTabBar.h"


@interface HCNavTabBar ()
{
    UIScrollView    *_navgationTabBar;      // all items on this scroll view
    
    UIView          *_line;                 // underscore show which item selected
    
    NSMutableArray  *_items;                // PMNavTabBar pressed item
}

@end


@implementation HCNavTabBar

- (id)initWithFrame:(CGRect)frame showItemTitles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.itemTitles = titles;
        [self initConfig];
    }
    return self;
}

#pragma mark -
#pragma mark - Private Methods

- (void)initConfig
{
    _items = [@[] mutableCopy];
    [self viewConfig];
}

- (void)viewConfig
{
    _navgationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, DOT_COORDINATE, SCREEN_WIDTH, NAV_TAB_BAR_HEIGHT)];
    _navgationTabBar.showsHorizontalScrollIndicator = NO;
    [self addSubview:_navgationTabBar];
    
    [self contentWidthAndAddNavTabBarItems];
    [self viewShowShadow:self shadowRadius:1.0f shadowOpacity:1.0f];
}

- (void)showLineWithButtonWidth:(CGFloat)width
{
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_TAB_BAR_HEIGHT - 3.0f, SCREEN_WIDTH/2, 3.0f)];
    _line.backgroundColor = kHCNavBarColor;
    [_navgationTabBar addSubview:_line];
}

- (CGFloat)contentWidthAndAddNavTabBarItems
{
    CGFloat buttonX = DOT_COORDINATE;
    int width = SCREEN_WIDTH / _itemTitles.count;
    for (NSInteger index = 0; index < [_itemTitles count]; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, DOT_COORDINATE, width, NAV_TAB_BAR_HEIGHT);
        [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_navgationTabBar addSubview:button];
        if (index == 0) {
            [button setTitleColor:kHCNavBarColor forState:UIControlStateNormal];
        }
        
        [_items addObject:button];
        buttonX += width;
    }
    
    [self showLineWithButtonWidth:width];
    return buttonX;
}

- (void)itemPressed:(UIButton *)button
{
    NSInteger index = [_items indexOfObject:button];
    [_delegate itemDidSelectedWithIndex:index];
}

- (void)viewShowShadow:(UIView *)view shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity
{
    view.layer.shadowRadius = shadowRadius;
    view.layer.shadowOpacity = shadowOpacity/10;
    view.layer.shadowOffset = CGSizeMake(0, 2);
}


#pragma mark -
#pragma mark - Public Methods

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    NSInteger lastIndex = _currentItemIndex;
    UIButton *lastBtn = _items[lastIndex];
    [lastBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

    _currentItemIndex = currentItemIndex;
    UIButton *button = _items[currentItemIndex];
    [button setTitleColor:kHCNavBarColor forState:UIControlStateNormal];

    int width = SCREEN_WIDTH / _itemTitles.count;
    [UIView animateWithDuration:0.2f animations:^{
        _line.frame = CGRectMake(button.frame.origin.x , _line.frame.origin.y, width, _line.frame.size.height);
    }];
}


@end
