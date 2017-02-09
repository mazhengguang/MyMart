//
//  TestViewController.m
//  MyMartSingapore
//
//  Created by xthink3 on 2017/1/14.
//  Copyright © 2017年 xxkj. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
