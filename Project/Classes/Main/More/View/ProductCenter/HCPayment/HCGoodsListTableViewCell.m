//
//  HCGoodsListTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCGoodsListTableViewCell.h"
#import "KWFormViewQuickBuilder.h"
#import "KWFormView.h"

@interface HCGoodsListTableViewCell ()

@property (nonatomic,strong) NSArray *listTitleArr;

@end

@implementation HCGoodsListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        KWFormViewQuickBuilder *builder = [[KWFormViewQuickBuilder alloc]init];
        
        [builder addRecord: self.listTitleArr];
        [builder addRecord:@[@"M-Talk二维码",@"2",@"3"]];
        [builder addRecord:@[@"M-Talk烫印机",@"5",@"6"]];

        CGFloat width = (SCREEN_WIDTH-40)*0.33;
        width = (width > 90) ? width : 90;
        KWFormView *formView = [builder startCreatWithWidths:@[@(width), @(width), @(width), @(MAX(90, width))] startPoint:CGPointMake(20, 20)];
        [self.contentView addSubview:formView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
        UIView *totalView = [[UIView alloc]initWithFrame:CGRectMake(20, 20+149, width*3, 50)];
        ViewBorderRadius(totalView, 0, 1, [UIColor lightGrayColor]);
    
        UILabel *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(-1, 0, width+1, 51)];
        totalLabel.text = @"本单应付";
        totalLabel.textAlignment = NSTextAlignmentCenter;
        ViewBorderRadius(totalLabel, 0, 1, [UIColor lightGrayColor]);
        totalLabel.font = SYSTEMFONT(15);
        
        UILabel *totalNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(width, 0, width*2, 49)];
        totalNumLabel.text = @"88元";
        totalNumLabel.textAlignment = NSTextAlignmentCenter;
        totalNumLabel.font = SYSTEMFONT(15);
        
        [totalView addSubview:totalLabel];
        [totalView addSubview:totalNumLabel];
        [self.contentView addSubview:totalView];
    }
    return self;
}


- (NSArray *)listTitleArr
{
    if (!_listTitleArr)
    {
        _listTitleArr = @[@"商品", @"数量", @"单价"];
    }
    return _listTitleArr;
}

@end
