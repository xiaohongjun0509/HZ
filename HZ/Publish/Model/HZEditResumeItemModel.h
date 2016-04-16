//
//  HZEditResumeItemModel.h
//  HZ
//
//  Created by hongjunxiao on 16/4/10.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HZEditType) {
    HZEditTypeAge,
    HZEditTypeDilmpho,
    HZEditTypeExperience,
    HZEditTypePosition,
    HZEditTypeWage
};
@interface HZEditResumeItemModel : NSObject
@property (nonatomic, assign)  HZEditType type;
@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, copy) NSString *contentString;
@property (nonatomic, copy) NSString *btnTitle;
@property (nonatomic, copy) NSString *methodName;
@property (nonatomic, assign)  BOOL showArrow;
@property (nonatomic, assign)  BOOL showSexButton;

@property (nonatomic, strong) NSMutableArray *studyList;
@property (nonatomic, strong) NSMutableArray *studyStringList;
@property (nonatomic, strong) NSMutableArray *workList;
@property (nonatomic, copy) void (^updateBlock)(NSInteger index,NSString *);
@property (nonatomic, assign) NSInteger index;
@end
