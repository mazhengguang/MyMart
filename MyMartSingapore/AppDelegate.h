//
//  AppDelegate.h
//  MyMartSingapore
//
//  Created by xthink3 on 2017/1/13.
//  Copyright © 2017年 xxkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

