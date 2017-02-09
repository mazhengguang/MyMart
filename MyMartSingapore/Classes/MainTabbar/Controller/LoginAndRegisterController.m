//
//  LoginAndRegisterController.m
//  MyMartSingapore
//
//  Created by xthink3 on 2017/2/7.
//  Copyright © 2017年 xxkj. All rights reserved.
//

#import "LoginAndRegisterController.h"

@interface LoginAndRegisterController ()

@end

@implementation LoginAndRegisterController
- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self.navigationController.navigationBar setHidden:YES];
}

@end
