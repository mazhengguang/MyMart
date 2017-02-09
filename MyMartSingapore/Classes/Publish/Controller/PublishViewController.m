//
//  PublishViewController.m
//  MyMartSingapore
//
//  Created by xthink3 on 2017/1/14.
//  Copyright © 2017年 xxkj. All rights reserved.
//

#import "PublishViewController.h"
#import "UIBarButtonItem+Extension.h"

@implementation PublishViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发布";
    
    // 设置导航条的按钮
    UIBarButtonItem *backButton = [UIBarButtonItem itemWithImageName:@"htab_back" highImageName:@"htab_back" target:self action:@selector(clickLeftBatButton)];
    self.navigationItem.leftBarButtonItem = backButton;
    
}

- (void)clickLeftBatButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
