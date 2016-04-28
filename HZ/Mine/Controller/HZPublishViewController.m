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
@interface HZPublishViewController ()<UIScrollViewDelegate>
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
    self.scrollView.delegate = self;
    
     self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollView.contentSize = CGSizeMake(3 * ScreenWidth, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    
    HZPublishJobViewController *jobVC = [HZPublishJobViewController new];
    jobVC.requestOfPublish = self.requestOfPublish;
    [self addChildViewController:jobVC];
    jobVC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
    [self.scrollView addSubview:jobVC.view];
    
    HZPublishResumeViewController *resumeVC = [HZPublishResumeViewController new];
    resumeVC.requestOfPublish = self.requestOfPublish;
    [self addChildViewController:resumeVC];
    resumeVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 64);
    [self.scrollView addSubview:resumeVC.view];
    
    HZPublishEnterpriseViewController *enterpriseVC = [HZPublishEnterpriseViewController new];
    enterpriseVC.requestOfPublish = self.requestOfPublish;
    [self addChildViewController:enterpriseVC];
    enterpriseVC.view.frame = CGRectMake(ScreenWidth * 2, 0, ScreenWidth, ScreenHeight - 64);
    [self.scrollView addSubview:enterpriseVC.view];
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (index == 0) {
        self.segmentView.positionLabel.textColor = [UIColor blueColor];
        self.segmentView.salarLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.segmentView.locationLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    }else if(index == 1){
        self.segmentView.positionLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.segmentView.salarLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.segmentView.locationLabel.textColor = [UIColor blueColor] ;
    }else{
        self.segmentView.positionLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.segmentView.salarLabel.textColor = [UIColor blueColor];
        self.segmentView.locationLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] ;
        
    }
}



- (void)attachSegmentView{
    self.segmentView = [[HZSegmentView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    self.segmentView.positionLabel.textColor = [UIColor blueColor];
    self.segmentView.titleArray = @[@"找工作",@"看简历",@"企业通"];
    [self.segmentView hiddenAllArrors];
    WEAKSELF
    self.segmentView.positionBlock = ^{
        weakSelf.segmentView.positionLabel.textColor = [UIColor blueColor];
        weakSelf.segmentView.salarLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        weakSelf.segmentView.locationLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [weakSelf.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    };
    weakSelf.segmentView.locationBlock = ^{
        weakSelf.segmentView.positionLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        weakSelf.segmentView.salarLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        weakSelf.segmentView.locationLabel.textColor = [UIColor blueColor] ;
        [weakSelf.scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
    };
    
    weakSelf.segmentView.salaryBlock = ^{
        weakSelf.segmentView.positionLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        weakSelf.segmentView.salarLabel.textColor = [UIColor blueColor];
        weakSelf.segmentView.locationLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] ;
        [weakSelf.scrollView setContentOffset:CGPointMake(ScreenWidth * 2, 0) animated:YES];

    };
    [self.view addSubview:self.segmentView];
}



@end
