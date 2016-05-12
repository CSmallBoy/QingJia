//
//  PMPickerView.m
//  PMedical
//
//  Created by Vincent on 15/6/3.
//  Copyright (c) 2015年 Vincent. All rights reserved.
//

#import "HCPickerView.h"
#import "HCBarButtonItem.h"

@interface HCPickerView ()
{
    UIToolbar       *_toolbar;
    //UIDatePicker    *_datePicker;
    NSDictionary    *_dataDic;

    NSDate          *_defaulDate;
    
    BOOL            _isHaveNavControler;
    NSInteger       _pickerViewHeight;
    
    NSDictionary    *_resultData;
}

/*
@property(nonatomic,copy)NSString *plistName;
@property(nonatomic,strong)NSArray *plistArray;
@property(nonatomic,assign)BOOL isLevelArray;
@property(nonatomic,assign)BOOL isLevelString;
@property(nonatomic,assign)BOOL isLevelDic;
@property(nonatomic,strong)NSDictionary *levelTwoDic;
@property(nonatomic,assign)NSInteger pickeviewHeight;
@property(nonatomic,copy)NSString *resultString;
@property(nonatomic,strong)NSMutableArray *componentArray;
@property(nonatomic,strong)NSMutableArray *dicKeyArray;
@property(nonatomic,copy)NSMutableArray *state;
@property(nonatomic,copy)NSMutableArray *city;
*/
@end

#define PMToobarHeight 44

@implementation HCPickerView
@synthesize pickerView = _pickerView;

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpToolBar];
        
    }
    return self;
}

//加载单数组
-(instancetype)initPickViewWithNavControler:(BOOL)isHaveNavControler {
    self = [super init];
    if (self) {
        [self setUpPickView];
        [self setFrameWith:isHaveNavControler];
    }
    return self;
}

//时间选择器
-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler{
    
    self=[super init];
    if (self) {
        _defaulDate=defaulDate;
        [self setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode];
        [self setFrameWith:isHaveNavControler];
    }
    return self;
}


#pragma mark - Layout

-(void)setFrameWith:(BOOL)isHaveNavControler{
    CGFloat toolViewX = 0;
    CGFloat toolViewH = _pickerViewHeight + PMToobarHeight;
    CGFloat toolViewY ;
    if (_isHaveNavControler) {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH - 50;
    }else {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH;
    }
    CGFloat toolViewW = [UIScreen mainScreen].bounds.size.width;
    self.frame = CGRectMake(toolViewX, toolViewY, toolViewW, toolViewH);
}

-(void)setUpPickView
{
    UIPickerView *pickView = [[UIPickerView alloc] init];
    pickView.backgroundColor = [UIColor lightGrayColor];
    _pickerView = pickView;
    //pickView.delegate = self;
    //pickView.dataSource = self;
    pickView.backgroundColor = [UIColor colorWithWhite:0.88 alpha:0.9];
    pickView.frame = CGRectMake(0, PMToobarHeight, SCREEN_WIDTH, pickView.frame.size.height);
    _pickerViewHeight = pickView.frame.size.height;
    [self addSubview:pickView];
}


-(void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.datePickerMode = datePickerMode;
    datePicker.backgroundColor = [UIColor colorWithWhite:0.88 alpha:0.9];
    if (_defaulDate) {
        [datePicker setDate:_defaulDate];
    }
    _datePicker = datePicker;
    datePicker.frame = CGRectMake(0, PMToobarHeight, SCREEN_WIDTH, datePicker.frame.size.height);
    _pickerViewHeight = datePicker.frame.size.height;
    [self addSubview:datePicker];
}

-(void)setUpToolBar {
    
    _toolbar = [self setToolbarStyle];
    [self setToolbarWithPickViewFrame];
    [self addSubview:_toolbar];
}

-(UIToolbar *)setToolbarStyle {
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    
    UIBarButtonItem *lefttem = [[UIBarButtonItem alloc] initWithTitle:@"    取消" style:UIBarButtonItemStyleDone target:self action:@selector(remove)];
    [lefttem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:BOLDSYSTEMFONT(16.0)} forState:UIControlStateNormal];
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定    " style:UIBarButtonItemStyleDone target:self action:@selector(doneClick)];
    [right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:BOLDSYSTEMFONT(16.0)} forState:UIControlStateNormal];
    toolbar.items = @[lefttem,centerSpace,right];
    
    return toolbar;
}

-(void)setToolbarWithPickViewFrame{
    _toolbar.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, PMToobarHeight);
}


#pragma mark piackView 数据源方法

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    NSArray *keys = [_dataDic allKeys];
    return keys.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *keys = [_dataDic allKeys];
    NSString *key = keys[component];
    NSArray *list = _dataDic[key];
    return list.count;
}

#pragma mark UIPickerViewdelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *rowTitle=nil;

    return rowTitle;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
}


#pragma mark - Action

-(void)remove{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeDatePicker" object:nil];
    [self removeFromSuperview];
}
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}
-(void)doneClick
{
    if (_datePicker) {
        _resultData = @{@"date":_datePicker.date};
        NSLog(@"%@",_datePicker.date);
    }
    
    if ([self.delegate respondsToSelector:@selector(doneBtnClick:result:)]) {
        [self.delegate doneBtnClick:self result:_resultData];
    }
    [self removeFromSuperview];
}
/**
 *  设置PickView的颜色
 */
-(void)setPickViewColer:(UIColor *)color {
    _pickerView.backgroundColor=color;
}
/**
 *  设置toobar的文字颜色
 */
-(void)setTintColor:(UIColor *)color {
    
    _toolbar.tintColor=color;
}
/**
 *  设置toobar的背景颜色
 */
-(void)setToolbarTintColor:(UIColor *)color {
    
    _toolbar.barTintColor=color;
}

@end
