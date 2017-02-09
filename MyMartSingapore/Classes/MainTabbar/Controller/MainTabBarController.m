//
//  MainTabBarController.m
//  MyMartSingapore
//
//  Created by xthink3 on 2017/1/14.
//  Copyright © 2017年 xxkj. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "MeViewController.h"
#import "MessageViewController.h"
#import "MessageViewController.h"
#import "CategoryViewController.h"
#import "PublishViewController.h"
#import "MainNavigationController.h"
#import "MainTabBar.h"


@interface MainTabBarController ()<MainTabBarDelegate>
@property(nonatomic, weak)MainTabBar *mainTabBar;
@property(nonatomic, strong)HomeViewController *homeVc;
@property(nonatomic, strong)CategoryViewController *subscriptionVc;
@property(nonatomic, strong)MessageViewController *notificationVc;
@property(nonatomic, strong)MeViewController *meVc;
@end

@implementation MainTabBarController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self SetupMainTabBar];
    [self SetupAllControllers];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)SetupMainTabBar{
    MainTabBar *mainTabBar = [[MainTabBar alloc] init];
    mainTabBar.frame = self.tabBar.bounds;
    mainTabBar.delegate = self;
    [self.tabBar addSubview:mainTabBar];
    _mainTabBar = mainTabBar;
}

- (void)SetupAllControllers{
    NSArray *titles = @[@"首页", @"分类", @"消息", @"我的"];
    NSArray *images = @[@"icon-4", @"icon-3", @"icon-5", @"icon-11"];
    NSArray *selectedImages = @[@"icon-44", @"icon-33", @"icon-55", @"icon-1"];
    
    HomeViewController * homeVc = [[HomeViewController alloc] init];
    self.homeVc = homeVc;
    
    CategoryViewController * subscriptionVc = [[CategoryViewController alloc] init];
    self.subscriptionVc = subscriptionVc;
    
    MessageViewController * notificationVc = [[MessageViewController alloc] init];
    self.notificationVc = notificationVc;
    
    MeViewController * meVc = [[MeViewController alloc] init];
    self.meVc = meVc;
    
    NSArray *viewControllers = @[homeVc, subscriptionVc, notificationVc, meVc];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        [self SetupChildVc:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)SetupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.title = title;
    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    [self addChildViewController:nav];
}


#pragma mark --------------------mainTabBar delegate
- (void)tabBar:(MainTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag{
    self.selectedIndex = toBtnTag;
}

- (void)tabBarClickWriteButton:(MainTabBar *)tabBar{
    PublishViewController *writeVc = [[PublishViewController alloc] init];
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:writeVc];
    
    [self presentViewController:nav animated:YES completion:nil];
}
@end
