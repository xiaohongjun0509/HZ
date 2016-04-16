//
//  MbTenderViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/27.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbTenderViewController.h"
//#import "JZQCommon.h"
@interface MbTenderViewController ()
@property (strong,nonatomic)UISegmentedControl *segment;
@property (nonatomic,strong)UIView* view1;
@property (nonatomic,strong)UIImageView* imageView;
@property (nonatomic,strong)UILabel* label;
@property (nonatomic,strong)NSTimer* timer;
@end

@implementation MbTenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"招标通（北京市）";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 56)];
   
    [self.view addSubview:self.view1];
    
    self.segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(15, 10, viewWidth-30, 36)];
    [self.segment insertSegmentWithTitle:@"招标公示" atIndex:0 animated:NO];
    [self.segment insertSegmentWithTitle:@"中标公示" atIndex:1 animated:NO];
    //self.segment.layer.cornerRadius = 18;
    
    //self.segment.layer.masksToBounds = YES;
    [self.view1 addSubview:_segment];
    self.segment.selectedSegmentIndex =0;
//    if (self.segment.selectedSegmentIndex==0) {
//        [self.segment setBackgroundImage:[UIImage imageNamed:@"home_1_1.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [self.segment setBackgroundImage:[UIImage imageNamed:@"home_1.png"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
//        
//        
//    }else if (self.segment.selectedSegmentIndex==1){
//    
//        [self.segment setBackgroundImage:[UIImage imageNamed:@"home_2_2.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [self.segment setBackgroundImage:[UIImage imageNamed:@"home_2.png"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
//    }
    //[self.segment setDividerImage:[UIImage imageNamed:@"home_1_1.png"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [self.segment setDividerImage:[UIImage imageNamed:@"home_5_pub_l.png"] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [self.segment setDividerImage:[UIImage imageNamed:@"home_5_pub_r.png"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    


//    [self.segment addTarget:self action:@selector(switchover:) forControlEvents:UIControlEventValueChanged];
//    // 设置UIPageViewController的配置项
//    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone]
//                                                       forKey: UIPageViewControllerOptionInterPageSpacingKey];
//    // 实例化UIPageViewController对象，根据给定的属性
//    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll//滑动属性
//                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal//横向
//                                                                        options: options];
//    // 设置UIPageViewController对象的代理
//    self.pageController.dataSource = self;
//    self.pageController.delegate =self;
//    [self.pageController.view setFrame:CGRectMake(0, CGRectGetMaxY(_segment.frame), viewWidth, viewHeight - _segment.frame.size.height)];
//    // 建立俩个控制器放入page
//    self.zhaobiaoVC = [MbZhaoBiaoViewController new];
//    self.zhongbiaoVC = [MbZhongBiaoViewController new];
//    // 默认展示的是项目
//    self.viewControllers = [NSArray arrayWithObjects:self.zhaobiaoVC, nil];
//    [self.pageController setViewControllers:self.viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
//        nil;
//    }];
//    [self.view addSubview:self.pageController.view];
    //网络请求网页
//    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
//    NSURL *url = [NSURL URLWithString:@"http://www.bjztb.gov.cn/zbgg_2015/"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
//    web.scalesPageToFit = YES;
//    [web loadRequest:request];
//    [self.view addSubview:web];

    //图片
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewWidth/2-30, (viewHeight-64)/2 - 50, 60, 60)];
    self.imageView.image = [UIImage imageNamed:@"han.png"];
    [self.view addSubview:self.imageView];
    //文字
    self.label = [[UILabel alloc]init];
    self.label.text = @"努力研发中";
    self.label.font = [UIFont systemFontOfSize:labelText];
    self.label.textAlignment = NSTextAlignmentCenter;
    CGSize size = [self.label.text sizeWithFont:self.label.font constrainedToSize:CGSizeMake(viewWidth, 300) lineBreakMode:NSLineBreakByCharWrapping];
    self.label.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+5, viewWidth, size.height);
    [self.view addSubview:self.label];
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
-(void)timerFired:(NSTimer*)timer{
    NSString *stringURL = @"http://www.bjztb.gov.cn/zbgg_2015/";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
    [self.timer invalidate];
}

/*
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (viewController ==self.zhongbiaoVC)
    {
        return self.zhaobiaoVC;
    }
    return nil;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController ==self.zhaobiaoVC)
    {
        return self.zhongbiaoVC;
    }
    return nil;
}

#pragma mark UIPageViewController代理方法  滑动结束时调用
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed ==YES) {
        if (previousViewControllers[0] ==self.zhaobiaoVC)
        {
            self.segment.selectedSegmentIndex =1;
            
            
            
        }else if (previousViewControllers[0] ==self.zhongbiaoVC)
        {
            self.segment.selectedSegmentIndex =0;
            self.navigationItem.rightBarButtonItem=nil;
        }
    }
}

#pragma mark 点击切换控制器
-(void)switchover:(UISegmentedControl *)segment
{
    segment.selected = !segment.selected;
    
    
    
    NSInteger index = segment.selectedSegmentIndex;
    self.viewControllers =nil;
    
    if (index ==0)
    {
        self.viewControllers =[NSArray arrayWithObject:self.zhaobiaoVC];
        self.navigationItem.rightBarButtonItem=nil;
  
    }
    if (index ==1)
    {
        self.viewControllers =[NSArray arrayWithObject:self.zhongbiaoVC];
 
        
    }
    [self.pageController setViewControllers:self.viewControllers
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
}
*/

@end
