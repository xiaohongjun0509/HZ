//
//  HZTabBarViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/25.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZTabBarViewController.h"
#import "NewsViewController.h"
#import "MineViewController.h"
#import "PublishViewController.h"
#import "HomeViewController.h"
#import "HZNavigationController.h"
@interface HZTabBarViewController ()

@end

@implementation HZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeTabController:[HomeViewController new] title:@"首页" image:@"tab_h_col"];
    [self makeTabController:[NewsViewController new] title:@"新闻" image:@"news"];
    [self makeTabController:[PublishViewController new] title:@"发布" image:@"tab_p_col.png"];
    [self makeTabController:[MineViewController new] title:@"用户中心" image:@"tab_u_col.png"];
    
}

- (void)makeTabController:(UIViewController *)controller title:(NSString *)title image:(NSString *)image {
    controller.tabBarItem.title = title;
//    UIImage *origImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.image = [UIImage imageNamed:image];
//    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    HZNavigationController *nc = [[HZNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nc];
}

@end
