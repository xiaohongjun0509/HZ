//
//  HZResumeDetailCell.h
//  HZ
//
//  Created by hongjunxiao on 16/3/29.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZResumeDetailModel : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * content;
@end

@interface HZResumeDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
