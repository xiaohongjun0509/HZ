//
//  HZNavigationController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZNavigationController.h"

@interface HZNavigationController ()

@end

@implementation HZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *nacbar = [UINavigationBar appearance];
    UIBarButtonItem *button = [UIBarButtonItem appearance];
    [button setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    
    [nacbar setBackgroundImage:[UIImage imageNamed:@"nav_backgound"] forBarMetrics:UIBarMetricsDefault];
    //[nacbar setBackgroundColor:[UIColor colorWithRed:52/255.0 green:142/255.0 blue:221/255.0 alpha:1]];
    //导航栏文字大小和颜色
    [nacbar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
