//
//  MeViewController.m
//  MyMartSingapore
//
//  Created by xthink3 on 2017/1/14.
//  Copyright © 2017年 xxkj. All rights reserved.
//

#import "MeViewController.h"
#import "MeHeadView.h"
#import "UIView+Extension.h"
//#import "UIViewController+NavBarHidden.h"


@interface MeViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@end
@implementation MeViewController{
    NSArray * _arr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的";
    [self.view addSubview:self.tableView];
    MeHeadView * view = [MeHeadView viewFromXib];
    [self.tableView setTableHeaderView:view];

    _arr = @[@"收藏",@"关注",@"我发布的",@"资料",@"设置"];
    
    //1.设置当有导航栏自动添加64的高度的属性为NO
//    self.automaticallyAdjustsScrollViewInsets = NO;
    //2.设置导航条内容
//    [self setUpNavBar];
//    [self setKeyScrollView:self.tableView scrolOffsetY:600 options:HYHidenControlOptionTitle | HYHidenControlOptionLeft];
    
    
}

//设置头部视图
- (void)setHeaderView{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"欢迎页03-白送" ofType:nil];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 250)];
    imageView.image = image;
    [self.tableView addSubview:imageView];
}


//- (void)viewDidDisappear:(BOOL)animated {
//    
//    [super viewDidDisappear:animated];
//    [self hy_viewDidDisappear:animated];
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    [self hy_viewWillAppear:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    
//    [super viewWillDisappear:animated];
//    [self hy_viewWillDisappear:animated];
//}
//
//#pragma mark - UI设置
//
//- (void)setUpNavBar{
//    
//    [self setNavBarBackgroundImage:[UIImage imageNamed:@"欢迎页02-义拍"]];
//    UILabel * titleLabel =[[UILabel alloc]init];
//    titleLabel.text = @"我的";
//    [titleLabel sizeToFit];
//    self.navigationItem.titleView = titleLabel;
//}
//


#pragma mark - TableViewCell 代理方法
// 每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:[LoginAndRegisterController new]];
    [self.navigationController presentViewController:navi animated:YES completion:nil];

}


@end
