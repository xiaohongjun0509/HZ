//
//  MbPickerView.h
//  Recruitment
//
//  Created by tusm on 15/12/4.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MbPickerView : UIView
{
    UILabel* line1;
    UILabel* line2;
}
@property(nonatomic,strong)UIPickerView* pickerView;
@property(nonatomic,strong)UIButton* cancleBtn;
@property(nonatomic,strong)UIButton* sureBtn;
@property(nonatomic,strong)NSArray* list;
@end
