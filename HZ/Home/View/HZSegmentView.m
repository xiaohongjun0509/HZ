//
//  HZSegmentView.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZSegmentView.h"
#import "UIView+YYAdd.h"
@interface HZSegmentView ()
@property (nonatomic, strong) UIImageView *arraw1;
@property (nonatomic, strong) UIImageView *arraw2;
@property (nonatomic, strong) UIImageView *arraw3;
@end

@implementation HZSegmentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    [self setupAppearance];
    return self;
}

- (void)setupAppearance{
   
        //职位按钮
        self.positionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3-0.5, 46)];
        self.positionBtn.userInteractionEnabled = YES;
        [self.positionBtn addTarget:self action:@selector(position) forControlEvents:UIControlEventTouchUpInside];
        self.positionBtn.tag = 1;
        [self addSubview:self.positionBtn];
        //职位label
        self.positionLabel = [[UILabel alloc]init];
        self.positionLabel.text = @"职位";
        self.positionLabel.textAlignment = NSTextAlignmentCenter;
        self.positionLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.positionLabel.font = [UIFont systemFontOfSize:labelText+1];
        CGSize size1 = [self.positionLabel.text sizeWithFont:self.positionLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        self.positionLabel.frame = CGRectMake(self.positionBtn.frame.size.width/6, self.positionBtn.frame.size.height/2-size1.height/2, size1.width*2, size1.height);
        [self.positionBtn addSubview:self.positionLabel];
        //职位下拉箭头
        UIImageView *positionImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.positionBtn.frame.size.width/1.3,self.positionBtn.frame.size.height/2 - size1.width/6, size1.width/3, size1.width/3)];
        positionImage.image = [UIImage imageNamed:@"home_arrow42_d.png"];
        self.arraw1 = positionImage;
        [self.positionBtn addSubview:positionImage];
    
        //线1
        UILabel * line1 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, 10, 1, 26)];
        line1.backgroundColor = [UIColor colorWithRed:57/255.0 green:141/255.0 blue:237/255.0 alpha:1];
        [self addSubview:line1];
        //地区按钮
        self.locationBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3+0.5, 0, ScreenWidth/3-1, 46)];
        self.locationBtn.userInteractionEnabled = YES;
        [self.locationBtn addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchUpInside];
        self.locationBtn.tag = 2;
        [self addSubview:self.locationBtn];
        
        //地区label
        self.locationLabel = [[UILabel alloc]init];
        self.locationLabel.text = @"地区";
        self.locationLabel.textAlignment = NSTextAlignmentCenter;
        self.locationLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.locationLabel.font = [UIFont systemFontOfSize:labelText+1];
        CGSize size2 = [self.locationLabel.text sizeWithFont:self.locationLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        self.locationLabel.frame = CGRectMake(self.locationBtn.frame.size.width/6, self.locationBtn.frame.size.height/2-size1.height/2, size2.width*2, size2.height);
        [self.locationBtn addSubview:self.locationLabel];
        //地区下拉箭头
        UIImageView *locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.locationBtn.frame.size.width/1.3,self.locationBtn.frame.size.height/2 - size2.width/6, size2.width/3, size2.width/3)];
        locationImage.image = [UIImage imageNamed:@"home_arrow42_d.png"];
        [self.locationBtn addSubview:locationImage];
        self.arraw2 = locationImage;
    
        
        //线2
        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3*2-0.5, 10, 1, 26)];
        line2.backgroundColor = [UIColor colorWithRed:57/255.0 green:141/255.0 blue:237/255.0 alpha:1];
        [self addSubview:line2];
        //薪资按钮
        self.salaryBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3*2+0.5, 0, ScreenWidth/3-0.5, 46)];
        self.salaryBtn.userInteractionEnabled = YES;
        [self.salaryBtn addTarget:self action:@selector(salary) forControlEvents:UIControlEventTouchUpInside];
        self.salaryBtn.tag = 3;
        [self addSubview:self.salaryBtn];
        
        //地区label
        self.salarLabel = [[UILabel alloc]init];
        self.salarLabel.text = @"薪资";
        self.salarLabel.textAlignment = NSTextAlignmentCenter;
        self.salarLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.salarLabel.font = [UIFont systemFontOfSize:labelText+1];
        CGSize size3 = [self.salarLabel.text sizeWithFont:self.salarLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        self.salarLabel.frame = CGRectMake(self.salaryBtn.frame.size.width/6, self.salaryBtn.frame.size.height/2-size1.height/2, size3.width*2, size3.height);
        [self.salaryBtn addSubview:self.salarLabel];
        //地区下拉箭头
        UIImageView *salarImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.salaryBtn.frame.size.width/1.3,self.salaryBtn.frame.size.height/2 - size3.width/6, size3.width/3, size3.width/3)];
        salarImage.image = [UIImage imageNamed:@"home_arrow42_d.png"];
         self.arraw3 = salarImage;
        [self.salaryBtn addSubview:salarImage];
        //横线
        UILabel *ling3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.positionBtn.frame) - 2, ScreenWidth, 1)];
        ling3.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [self addSubview:ling3];
        
    
}


- (void)hiddenAllArrors{
    self.arraw2.hidden = YES;
    self.arraw1.hidden = YES;
    self.arraw3.hidden = YES;
    self.positionLabel.left = self.positionLabel.left + 7;
     self.locationLabel.left = self.locationLabel.left + 7;
     self.salarLabel.left = self.salarLabel.left + 7;
    
}

- (void)setSelectedColor:(UIColor *)color{
    
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    if (titleArray.count >= 3) {
        self.positionLabel.text = titleArray[0];
        self.locationLabel.text = titleArray[1];
        self.salarLabel.text = titleArray[2];
    }
    
}

- (void)position{
    
    self.arraw1.transform = CGAffineTransformMakeRotation(M_PI);
    self.arraw2.transform = CGAffineTransformIdentity;
    self.arraw3.transform = CGAffineTransformIdentity;
    if (self.positionBlock) {
        self.positionBlock();
    }
}

- (void)location{
    self.arraw1.transform = CGAffineTransformIdentity;
    self.arraw2.transform = CGAffineTransformMakeRotation(M_PI);
    self.arraw3.transform = CGAffineTransformIdentity;
    if (self.locationBlock) {
        self.locationBlock();
    }
}

- (void)salary{
    self.arraw1.transform = CGAffineTransformIdentity;
    self.arraw3.transform = CGAffineTransformMakeRotation(M_PI);
    self.arraw2.transform = CGAffineTransformIdentity;
    if (self.salaryBlock) {
        self.salaryBlock();
    }
}
@end
