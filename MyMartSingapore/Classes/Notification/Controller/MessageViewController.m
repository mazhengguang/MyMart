//
//  MessageViewController.m
//  MyMartSingapore
//
//  Created by xthink3 on 2017/2/7.
//  Copyright © 2017年 xxkj. All rights reserved.
//

#import "MessageViewController.h"

#import "MainNavigationController.h"


@interface MessageViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@end
@implementation MessageViewController{
    NSArray * _arr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息";
    [self.view addSubview:self.tableView];
    _arr = @[@"通知",@"聊天"];
    
    
}


#pragma mark - TableViewCell 代理方法
// 每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arr.count;
}

// cell定制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_arr[indexPath.row]];
    return cell;
}

// 选中每一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginAndRegisterController * vc= [[LoginAndRegisterController alloc] init];
    MainNavigationController * navi = [[MainNavigationController alloc] initWithRootViewController:vc];
    navi.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:navi animated:YES completion:nil];
    
}


@end
