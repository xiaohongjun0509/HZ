//
//  HZPublishViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/27.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZPublishViewController.h"
#import "HZPublishJobViewController.h"
#import "HZPublishResumeViewController.h"
#import "HZPublishEnterpriseViewController.h"
#import "HZSegmentView.h"
@interface HZPublishViewController ()
@property (nonatomic, strong) HZSegmentView *segmentView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation HZPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.requestOfPublish ? @"我的发布" : @"我的收藏";
    [self customScrollView];
    [self attachSegmentView];
    [self attachBackButton];
}

- (void)customScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
     self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollView.contentSize = CGSizeMake(3 * ScreenWidth, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    
    HZPublishJobViewController *jobVC = [HZPublishJobViewController new];
    jobVC.requestOfPublish = YES;
    [self addChildViewController:jobVC];
    jobVC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
    [self.scrollView addSubview:jobVC.view];
    
    HZPublishResumeViewController *resumeVC = [HZPublishResumeViewController new];
    resumeVC.requestOfPublish = YES;
    [self addChildViewController:resumeVC];
    resumeVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 64);
    [self.scrollView addSubview:resumeVC.view];
    
    HZPublishEnterpriseViewController *enterpriseVC = [HZPublishEnterpriseViewController new];
    enterpriseVC.requestOfPublish = YES;
    [self addChildViewController:enterpriseVC];
    enterpriseVC.view.frame = CGRectMake(ScreenWidth * 2, 0, ScreenWidth, ScreenHeight - 64);
    [self.scrollView addSubview:enterpriseVC.view];
    
    
}

- (void)attachSegmentView{
    self.segmentView = [[HZSegmentView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    self.segmentView.titleArray = @[@"找工作",@"看简历",@"企业通"];
    WEAKSELF
    self.segmentView.positionBlock = ^{
        [weakSelf.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    };
    weakSelf.segmentView.locationBlock = ^{
        [weakSelf.scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
    };
    
    weakSelf.segmentView.salaryBlock = ^{
        [weakSelf.scrollView setContentOffset:CGPointMake(ScreenWidth * 2, 0) animated:YES];

    };
    [self.view addSubview:self.segmentView];
}



@end
