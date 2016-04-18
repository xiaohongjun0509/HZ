//
//  MineViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "MineViewController.h"
#import "HZLoginViewController.h"
#import "HZPublishViewController.h"
#import "HZLoginedViewController.h"
@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *images;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.title = @"用户中心";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    self.titles = @[@"我的账号",@"我的发布",@"我的收藏"];
    self.images = @[@"home_7_uc1.png",@"home_7_uc2.png",@"home_7_uc3.png"];
}

#pragma  mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifire = @"Cell";
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
    }
  
    NSString *imageName = self.images[2 - indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 2) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 15;
    }
    return 0.0000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"-------");
    if (indexPath.row == 0) {
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
            HZLoginViewController *controller = [HZLoginViewController new];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navi animated:YES completion:nil];
        }else{
            HZLoginedViewController *controller = [[HZLoginedViewController alloc] init];
            [self presentVC:controller];
        }
        
    }
    if (indexPath.row == 1) {
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
            HZLoginViewController *controller = [HZLoginViewController new];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navi animated:YES completion:nil];
        }else{
        HZPublishViewController *controller = [HZPublishViewController new];
        controller.requestOfPublish = YES;
        HZNavigationController *navi = [[HZNavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navi animated:YES completion:nil];
        }
    }
    if (indexPath.row == 2) {
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
            HZLoginViewController *controller = [HZLoginViewController new];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navi animated:YES completion:nil];
        }else{
        HZPublishViewController *controller = [HZPublishViewController new];
        controller.requestOfPublish = NO;
        HZNavigationController *navi = [[HZNavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navi animated:YES completion:nil];
    }
}
}

@end
