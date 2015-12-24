
//
//  HCWelcomeJoinGradeViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCWelcomeJoinGradeViewController.h"

@interface HCWelcomeJoinGradeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;


@end

@implementation HCWelcomeJoinGradeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(0, 0, 0, 0.6);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddleSelfView)];
    [self.view addGestureRecognizer:tap];
    
    [self performSelector:@selector(hiddleSelfView) withObject:nil afterDelay:5];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.view removeFromSuperview];
}

- (void)hiddleSelfView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _welcomeLabel.text = _gradeId;
}


@end
