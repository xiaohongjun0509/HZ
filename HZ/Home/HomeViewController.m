//
//  HomeViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/25.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeBannerModel.h"
#import "MbEnterpriseViewController.h"
#import "HZJobHuntViewController.h"
#import "HZResumeViewController.h"
#import "HZEnterpriseViewController.h"
#import "MbTenderViewController.h"
#import "MbCityListViewController.h"
@interface HomeViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) NSArray *scrollImageModels;
@property (nonatomic, strong) UIPageControl *pageController;
@property (nonatomic, strong) UIButton *cityButton;
@property (nonatomic, strong) NSMutableArray *modelArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = YES;
    }];
    self.modelArray = [NSMutableArray array];
    [self customScrollview];
    [self customButtons];
    [self  requestBanner];
    self.cityName = [[NSUserDefaults standardUserDefaults] stringForKey:@"cityname"];
    if(!self.cityName){
        self.cityName = @"北京市";
        [[NSUserDefaults standardUserDefaults] setObject:@"北京市" forKey:@"cityname"];
    }
    [self attachCity:self.cityName];
}


- (void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"cityname"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.cityButton setTitle:cityName forState:UIControlStateNormal];
}
- (void)requestBanner{
    WEAKSELF
    [[NetworkManager manager] startRequest:banner completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dict = responseObject;
            weakSelf.scrollImageModels = [HomeBannerModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"data" ]];
            weakSelf.scrollView.contentSize = CGSizeMake(ScreenWidth * self.scrollImageModels.count,0);
            [weakSelf.scrollImageModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.frame = CGRectMake(ScreenWidth*idx, 0, ScreenWidth, ScreenWidth/2);
                HomeBannerModel *model = obj;
                [weakSelf.modelArray addObject:model];
                [imageView setImageUrl:model.image];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump:)];
                imageView.tag = 1001 + idx;
                imageView.userInteractionEnabled = YES;
                [imageView addGestureRecognizer:tap];
                [weakSelf.scrollView addSubview:imageView];
            }];
            self.pageController.numberOfPages = self.scrollImageModels.count;
        }
    }];
}


- (void)jump:(UITapGestureRecognizer *)rec{
    UIImageView *im = (UIImageView *)rec.view;
    NSInteger index =im.tag - 1001;
    HomeBannerModel *model = self.modelArray[index];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
}

- (void)customScrollview{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/2)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
    
    self.pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(ScreenWidth/2-50, CGRectGetMaxY(self.scrollView.frame) - 15, 100, 0)];
    self.pageController.currentPageIndicatorTintColor = [UIColor colorWithRed:57/255.0 green:141/255.0 blue:227/255.0 alpha:1];
    self.pageController.pageIndicatorTintColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    self.pageController.numberOfPages = self.scrollImageModels.count;
    self.pageController.currentPage = 0;
    [self.view addSubview:self.pageController];
}

- (UIButton *)makeMenuButton:(NSString *)imageName title:(NSString *)title selector:(SEL)selector color:(UIColor *)color frame:(CGRect)frame{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectZero];
    [button setBackgroundColor:color];
    button.frame = frame;
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    [self.view addSubview:button];
    //图片
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(button.frame.size.width/2-button.frame.size.height/6, button.frame.size.height/5.4, button.frame.size.height/3, button.frame.size.height/3)];
    imageView.image = [UIImage imageNamed:imageName];
    [button addSubview:imageView];
    //找工作
    UILabel* label = [[UILabel alloc]init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:labelText+3];
    label.textColor = [UIColor whiteColor];
    label.frame = CGRectMake(button.frame.size.width/2 - 50, CGRectGetMaxY(imageView.frame)+12, 100, 30);
    [label sizeToFit];
    label.frame = CGRectMake(button.frame.size.width/2 - label.frame.size.width/2, CGRectGetMaxY(imageView.frame)+12, label.frame.size.width, label.frame.size.height);
    [button addSubview:label];
    return button;
}


-(void)customButtons{
    UIButton *jobButton = [self makeMenuButton:@"home_1_icon1.png" title:@"找工作" selector:@selector(findWork) color:[UIColor colorWithRed:43/255.0 green:223/255.0 blue:252/255.0 alpha:1] frame:CGRectMake(15, CGRectGetMaxY(self.scrollView.frame)+15, (ScreenWidth-45)/2, (ScreenWidth-45)/3.1)];
    [jobButton setNeedsLayout];
    [jobButton layoutIfNeeded];
    
    
    UIButton *resumeButton = [self makeMenuButton:@"home_1_icon2.png" title:@"看简历" selector:@selector(resume) color:[UIColor colorWithRed:70/255.0 green:214/255.0 blue:202/255.0 alpha:1] frame:CGRectMake((ScreenWidth-45)/2+30, CGRectGetMaxY(self.scrollView.frame)+15, (ScreenWidth-45)/2, (ScreenWidth-45)/3.1)];
    [resumeButton setNeedsLayout];
    [resumeButton layoutIfNeeded];
    
    UIButton *enterpriseButton = [self makeMenuButton:@"home_1_icon3.png" title:@"企业通" selector:@selector(enterprise) color:[UIColor colorWithRed:72/255.0 green:119/255.0 blue:255/255.0 alpha:1] frame:CGRectMake(15, CGRectGetMaxY(resumeButton.frame)+15, (ScreenWidth-45)/2, (ScreenWidth-45)/3.1)];
    [enterpriseButton setNeedsLayout];
    [enterpriseButton layoutIfNeeded];
    
    UIButton *zhaobiaoButton = [self makeMenuButton:@"home_1_icon4.png" title:@"商脉通" selector:@selector(zhaibiao) color:[UIColor colorWithRed:255/255.0 green:84/255.0 blue:0 alpha:1] frame:CGRectMake((ScreenWidth-45)/2+30, CGRectGetMaxY(resumeButton.frame)+15, (ScreenWidth-45)/2, (ScreenWidth-45)/3.1)];
    zhaobiaoButton.backgroundColor = HEXCOLOR(0x999999);
    [zhaobiaoButton setNeedsLayout];
    [zhaobiaoButton layoutIfNeeded];
}

- (void)findWork{
    HZJobHuntViewController *controller = [[HZJobHuntViewController alloc] init];
    controller.cityName = self.cityName;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:nil];
    
}

- (void)enterprise{
    MbEnterpriseViewController *controller = [MbEnterpriseViewController new];
    controller.cityName = self.cityName;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)resume{
    HZResumeViewController *controller = [HZResumeViewController new];
    controller.cityName = self.cityName;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)zhaibiao{
//    MbTenderViewController * tenderVC = [[MbTenderViewController alloc]init];
//    [self presentVC:tenderVC];
//        [self.navigationController pushViewController:self.tenderVC animated:YES];

}


#pragma mark delegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
   self.pageController.currentPage = (int) scrollView.contentOffset.x / ScreenWidth;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageController.currentPage = (int) scrollView.contentOffset.x / ScreenWidth;
}




#pragma merk - 
- (void)attachCity:(NSString *)city{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cityButton = backButton;
    [backButton setTitle:city forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(showLictController)
         forControlEvents:UIControlEventTouchUpInside];
    CGFloat space = 5.0;
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
    [backButton sizeToFit];
    CGRect frame = backButton.frame;
    frame.size.width += space;
    backButton.frame = frame;
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}

- (void)showLictController{
    MbCityListViewController *vc = [[MbCityListViewController alloc] init];
    vc.homeVC = self;
    [self presentVC:vc];
}

@end
