//
//  UIViewController+AttachBack.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "UIViewController+AttachBack.h"

@implementation UIViewController (AttachBack)
- (void)attachBackButton
{
    UIButton *backButton = [self backButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}


- (UIButton *)backButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *image = [UIImage imageNamed:@"nav_back"];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    CGFloat space = 5.0;
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
    [backButton sizeToFit];
    CGRect frame = backButton.frame;
    frame.size.width += space + image.size.width;
    backButton.frame = frame;
    
 
    
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    return backButton;
    
}

- (void)backButtonPressed{
    [self dismissModalViewControllerAnimated:YES];
}

@end
