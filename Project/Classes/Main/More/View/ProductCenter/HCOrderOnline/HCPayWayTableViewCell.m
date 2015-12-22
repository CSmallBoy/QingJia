//
//  HCPayWayTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPayWayTableViewCell.h"

@implementation HCPayWayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.payImg.image = OrigIMG(@"label");
        self.payLab.text = @"支付宝支付";
        self.payButton.backgroundColor = [UIColor clearColor];
        ViewBorderRadius(self.payButton, 1, 1, [UIColor redColor]);
        
        [self.contentView addSubview:self.payButton];
        [self.contentView addSubview:self.payImg];
        [self.contentView addSubview:self.payLab];
        
    }
    return self;
}
@end
