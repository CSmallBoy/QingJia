//
//  AddFamilyMemberViewController.m
//  钦家
//
//  Created by 殷易辰 on 16/6/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "AddFamilyMemberViewController.h"

@interface AddFamilyMemberViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITextField *_search;
}
@end

@implementation AddFamilyMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"邀请成员加入";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _search = [[UITextField alloc]init];
    _search.frame = CGRectMake(0, 74,self.view.frame.size.width , 30);
    _search.backgroundColor = [UIColor clearColor];
    _search.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _search.placeholder = @"  输入好友ID号";
    _search.layer.borderWidth = 0.6;
    _search.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.80 alpha:1.00].CGColor;
    [self.view addSubview:_search];
    

    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,MaxY(_search) +20, self.view.frame.size.width, 100) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:tableview];
}


//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(10, 10, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (void)backBtnClick
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark ---------tableviewdelegate and source -------


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}
//tabview 显示问题
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplyFriendCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = @"     添加手机联系人";
    }
    
   
   
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.frame = CGRectMake(10, 0, 20, 20);
    imageview.image = [UIImage imageNamed:@"1"];
    [cell.contentView addSubview:imageview];
    imageview.center = CGPointMake(imageview.center.x, 20);
    
    if (indexPath.row == 1) {
        UIView *tempView = [[UIView alloc] init];
        tempView.layer.borderWidth = 0.5;
        tempView.layer.borderColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.80 alpha:1.00].CGColor;
        [cell setBackgroundView:tempView];
        cell.textLabel.text = @"     面对面二维码添加";
        imageview.image = [UIImage imageNamed:@"er-0"];
    }
    else
    {
        imageview.image = [UIImage imageNamed:@"sdf"];
    }
    return cell;
}




#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
