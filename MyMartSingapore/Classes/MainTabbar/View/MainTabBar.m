//
//  MainTabBar.m
//  MyMartSingapore
//
//  Created by xthink3 on 2017/1/14.
//  Copyright © 2017年 xxkj. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabBarButton.h"

@interface MainTabBar ()
@property(nonatomic, strong)NSMutableArray *tabbarBtnArray;
@property(nonatomic, weak)MainTabBarButton *writeButton;
@property(nonatomic, weak)MainTabBarButton *selectedButton;
@end

@implementation MainTabBar
- (NSMutableArray *)tabbarBtnArray{
    if (!_tabbarBtnArray) {
        _tabbarBtnArray = [NSMutableArray array];
    }
    return  _tabbarBtnArray;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self SetupWriteButton];
    }
    
    return self;
}

- (void)SetupWriteButton{
    MainTabBarButton *writeButton = [MainTabBarButton new];
    [writeButton setTitle:@"发布" forState:0];
    [writeButton setImage:[UIImage imageNamed:@"icon-2"] forState:0];
    [writeButton setImage:[UIImage imageNamed:@"icon-2.2"] forState:UIControlStateSelected];
    [writeButton addTarget:self action:@selector(ClickWriteButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:writeButton];
    _writeButton = writeButton;
    
}




- (void)layoutSubviews{
    [super layoutSubviews];
    self.writeButton.frame = CGRectMake(0, 0, self.frame.size.width/5,49);
    self.writeButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width/(self.subviews.count);
    CGFloat btnH = self.frame.size.height;
    
    for (int nIndex = 0; nIndex < self.tabbarBtnArray.count; nIndex++) {
        CGFloat btnX = btnW * nIndex;
        MainTabBarButton *tabBarBtn = self.tabbarBtnArray[nIndex];
        if (nIndex > 1) {
            btnX += btnW;
        }
        tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        tabBarBtn.tag = nIndex;
    }
}

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem{
    MainTabBarButton *tabBarBtn = [[MainTabBarButton alloc] init];
    tabBarBtn.tabBarItem = tabBarItem;
    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarBtn];
    [self.tabbarBtnArray addObject:tabBarBtn];
    
    //default selected first one
    if (self.tabbarBtnArray.count == 1) {
        [self ClickTabBarButton:tabBarBtn];
    }
}

- (void)ClickTabBarButton:(MainTabBarButton *)tabBarBtn{
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:tabBarBtn.tag];
    }
    
    self.selectedButton.selected = NO;
    tabBarBtn.selected = YES;
    self.selectedButton = tabBarBtn;
}

- (void)ClickWriteButton{
    if ([self.delegate respondsToSelector:@selector(tabBarClickWriteButton:)]) {
        [self.delegate tabBarClickWriteButton:self];
    }
}
@end
