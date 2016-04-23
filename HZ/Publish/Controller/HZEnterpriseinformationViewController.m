//
//  HZEducationalExperienceViewController.m
//  Recruitment
//
//  Created by tusm on 15/11/3.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "HZEnterpriseinformationViewController.h"
#import "HZZiZhiViewController.h"
#import "HZPlaceModel.h"
#import "MbPaser.h"
@interface HZEnterpriseinformationViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UITextViewDelegate>
{
    CGSize labelSize;
    
}
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UITableView* tableView1;
@property(nonatomic,strong)UIButton* btn1;
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,strong)UILabel* companyName;                  //公司名称
@property(nonatomic,strong)UILabel* qualificationsName;           //资质
@property(nonatomic,strong)UILabel* businessCooperation;          //详情介绍
@property(nonatomic,strong)UILabel* workPlace;                    //办公地段
@property(nonatomic,strong)UIButton* place;                        //地区

@property(nonatomic,strong)UILabel* contactPerson;                //联系人
@property(nonatomic,strong)UILabel* telephoneNumber;              //联系电话

@property(nonatomic,strong)UITextField* companyField;             //公司名称
@property(nonatomic,strong)UITextField* qualificationsNameField;  //资质
@property(nonatomic,strong)UITextField* businessCooperationField; //商业合作
@property(nonatomic,strong)UITextView* businessCooperationView;
@property(nonatomic,strong)UILabel* detailPlace;                  //详细地址
@property(nonatomic,strong)UITextField* workPlaceField;           //办公地址
@property(nonatomic,strong)UIButton* downBtn;
@property(nonatomic,strong)UITextField* contactPersonField;       //联系人
@property(nonatomic,strong)UITextField* telephoneNumberField;     //联系电话

@property(nonatomic,strong)UIButton* addBtn;                      //添加
@property(nonatomic,strong)UIView* view1;
@property(nonatomic,strong)UILabel* line1;                        //竖线
@property(nonatomic,strong)UILabel* line2;
@property(nonatomic,strong)UILabel* line3;
@property(nonatomic,strong)UILabel* line4;
@property(nonatomic,strong)UILabel* line5;
@property(nonatomic,strong)UILabel* line6;
@property(nonatomic,strong)UILabel* line7;

@property(nonatomic,strong)UILabel* horizontal1;                   //横线
@property(nonatomic,strong)UILabel* horizontal2;
@property(nonatomic,strong)UILabel* horizontal3;
@property(nonatomic,strong)UILabel* horizontal4;
@property(nonatomic,strong)UILabel* horizontal5;
@property(nonatomic,strong)UILabel* horizontal6;
@property(nonatomic,strong)UILabel* horizontal7;
@property(nonatomic,strong)UIButton* releaseBtn;                  //发布按钮
@property(nonatomic,strong)UILabel* searchBar;                //搜索框
@property(nonatomic,strong)UILabel* label;
@property(nonatomic,strong)NSArray* lists;
@property(nonatomic,strong)NSMutableArray* searchArray;      //搜索的数组
@property(nonatomic,assign)int count;
@property(nonatomic,strong)UIButton* zizhiBtn;
//@property(nonatomic,strong)NSMutableArray* buttonTitles;
@property(nonatomic,strong)UIButton* deleteBtn;              //删除按钮
@property(nonatomic,strong)NSString* userid;
@property(nonatomic,strong)NSMutableDictionary* dic;
@property(nonatomic,strong)NSMutableArray* placeList;
@property(nonatomic,strong)NSMutableDictionary* zidic;       //保存资质的字典
@property(nonatomic,strong)NSMutableArray* ziarray;
@property(nonatomic,strong)NSMutableString* muStr;
@property(nonatomic,strong)NSString* zizhi;
@property(nonatomic,strong)NSString* str;
@end

@implementation HZEnterpriseinformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"填写企业信息(%@)",self.cityName];
    self.view.backgroundColor = [UIColor whiteColor];
    self.userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    self.lists = @[@"市政公用施工总承包特级",@"市政公用工程总承包一级",@"市政公用工程总承包二级",@"市政公用工程总承包三级"];
    self.searchArray = [NSMutableArray array];
    self.buttonTitles = [NSMutableArray array];
    self.zidic = [[NSMutableDictionary alloc]init];
    self.ziarray = [NSMutableArray array];
    self.muStr = [[NSMutableString alloc]init];
    self.placeList = [NSMutableArray array];
    self.dic = [[NSMutableDictionary alloc]init];
    self.label = [[UILabel alloc]init];
    self.label.text = @"公司名称";
    self.label.font = [UIFont systemFontOfSize:labelText];
    labelSize = [self.label.text sizeWithFont:self.label.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    resultItems = [[NSMutableArray alloc] initWithCapacity:20];
    suggestItems = [[NSMutableArray alloc] initWithCapacity:20];
    suggestItems = @[@"市政公用施工总承包特级",@"市政公用施工总承包一级",@"市政公用施工总承包二级",@"市政公用施工总承包三级"];
 

}



//地区
-(void)getPlace{
    [[NetworkManager manager] startRequest:[NSString stringWithFormat:@"%@area=%@",threeplace,self.cityName] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dict = (NSDictionary *)responseObject;
            self.placeList = [HZPlaceModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            [self.tableView1 reloadData];
        }
    }];

}


-(void)onCreate{
    NSArray *subViews = [self.view subviews];
    [subViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        [view removeFromSuperview];
    }];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-64)];
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    //公司名称
    self.companyName = [[UILabel alloc]init];
    self.companyName.text = @"公司名称";
    self.companyName.font = [UIFont systemFontOfSize:labelText];
    self.companyName.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    
    self.companyName.frame = CGRectMake(15, 15, labelSize.width, labelSize.height);
    [self.scrollView addSubview:self.companyName];
    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.companyName.frame)+10, 8, 1, labelSize.height+14)];
    self.line1.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line1];
    
    self.companyField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line1.frame)+10, 8, viewWidth-labelSize.width*2, self.line1.frame.size.height)];
    
    if (self.companyField.text.length==0) {
        
        self.companyField.text = [self.dic objectForKey:@"company"];
    }
    self.companyField.placeholder = @"请填写公司名称";
    
    self.companyField.returnKeyType=UIReturnKeyDone;
    self.companyField.delegate = self;
    self.companyField.textColor = [UIColor blackColor];
    self.companyField.font = [UIFont systemFontOfSize:labelText];
    self.companyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.companyField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.companyField setValue:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.scrollView addSubview:self.companyField];
    
    //横线1
    self.horizontal1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.companyName.frame) + 15, viewWidth, 0.5)];
    self.horizontal1.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal1];
    
    //资质
    self.qualificationsName = [[UILabel alloc]init];
    self.qualificationsName.text = @"资质";
    self.qualificationsName.textAlignment = NSTextAlignmentRight;
    self.qualificationsName.font = [UIFont systemFontOfSize:labelText];
    self.qualificationsName.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.qualificationsName.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal1.frame) + 15, labelSize.width, labelSize.height);
    [self.scrollView addSubview:self.qualificationsName];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.companyName.frame) + 17, CGRectGetMaxY(self.horizontal1.frame) + 15, 20, 20)];
    imageView.image = [UIImage imageNamed:@"sousuo"];
    [self.scrollView addSubview:imageView];
    //搜索框
    self.searchBar = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5,CGRectGetMaxY(self.horizontal1.frame) + 8, viewWidth-labelSize.width*3.2+10, labelSize.height+14)];
    self.searchBar.font = [UIFont systemFontOfSize:labelText];
//    self.searchBar.delegate = self;
    self.searchBar.text = @"请填写资质";
    self.searchBar.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];

    self.searchBar.layer.cornerRadius = 4;
    self.searchBar.layer.masksToBounds = YES;
//    self.searchBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.searchBar.layer.borderColor = [UIColor clearColor].CGColor;
    self.searchBar.layer.borderWidth = 1;
    [self.scrollView addSubview:self.searchBar];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showZiZhi)];
    self.searchBar.userInteractionEnabled = YES;
    [self.searchBar addGestureRecognizer:tap];
    
    self.count = 0;
    
    if (self.buttonTitles.count>0) {
        for (NSString* string in self.buttonTitles) {
            //添加的资质
            self.zizhiBtn = [[UIButton alloc]init];
            [self.zizhiBtn setTitle:string forState:UIControlStateNormal];
            [self.zizhiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.zizhiBtn.titleLabel.font = [UIFont systemFontOfSize:labelText-1];
            self.zizhiBtn.frame = CGRectMake(imageView.frame.origin.x, CGRectGetMaxY(self.searchBar.frame) + 10 + self.count*(labelSize.height+20), self.searchBar.frame.size.width, labelSize.height+10);
            self.zizhiBtn.layer.cornerRadius = 3;
            self.zizhiBtn.layer.masksToBounds = YES;
            
            self.zizhiBtn.layer.borderColor = [UIColor blackColor].CGColor;
            self.zizhiBtn.layer.borderWidth = 1;
            [self.scrollView addSubview:self.zizhiBtn];
            
            
            //删除按钮
            for (int i = 0; i<self.buttonTitles.count; i++) {
                self.deleteBtn = [[UIButton alloc]init];
                self.deleteBtn.frame = CGRectMake(viewWidth - 40 , CGRectGetMaxY(self.searchBar.frame) + 10 + i*(labelSize.height+20), 30, labelSize.height+10);
                [self.deleteBtn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
                self.deleteBtn.tag = i + 1000;
                [self.deleteBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
                [self.scrollView addSubview:self.deleteBtn];
                
            }
            
            
            self.count++;
        }
        
    }
    
    self.line2 = [[UILabel alloc]init];
    
    self.line2.frame =  CGRectMake(CGRectGetMaxX(self.companyName.frame)+10, CGRectGetMaxY(self.horizontal1.frame) + 8, 1, labelSize.height+14+(labelSize.height+20)*self.count);
    
    self.line2.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line2];
    
    
    //横线2
    self.horizontal2 = [[UILabel alloc]init];
    if (self.buttonTitles.count==0) {
        self.horizontal2.frame = CGRectMake(0, CGRectGetMaxY(self.qualificationsName.frame) + 15, viewWidth, 0.5);
    }else{
        self.horizontal2.frame = CGRectMake(0, CGRectGetMaxY(self.zizhiBtn.frame) + 10, viewWidth, 0.5);
    }
    
    self.horizontal2.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal2];
    

    
    //详情介绍
    self.businessCooperation = [[UILabel alloc]init];
    self.businessCooperation.text = @"详情介绍";
    self.businessCooperation.font = [UIFont systemFontOfSize:labelText];
    self.businessCooperation.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.businessCooperation.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal2.frame) + 15, labelSize.width, labelSize.height);
    [self.scrollView addSubview:self.businessCooperation];
    
    self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.businessCooperation.frame)+10, CGRectGetMaxY(self.horizontal2.frame) +8, 1, labelSize.height+14)];
    self.line3.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line3];
    
    self.businessCooperationView = [[UITextView alloc]init];
//    self.businessCooperationView.
//    if (self.businessCooperationView.text.length==0) {
//        self.businessCooperationView.text = [self.dic objectForKey:@"textView"];
//    }
    
    if (self.businessCooperationView.text.length==0&&![self.dic objectForKey:@"textView"]) {
        
          self.businessCooperationView.frame = CGRectMake(CGRectGetMaxX(self.line3.frame)+10, CGRectGetMaxY(self.horizontal2.frame) + 8, viewWidth-labelSize.width*2, self.line3.frame.size.height);
        
    }else if (self.businessCooperationView.text.length!=0||[self.dic objectForKey:@"textView"]){
        
        self.businessCooperationView.text = [self.dic objectForKey:@"textView"];
        NSDictionary* tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:labelText],NSFontAttributeName, nil];
        CGSize acsize = [self.businessCooperationView.text boundingRectWithSize:CGSizeMake(viewWidth-labelSize.width*2, 300) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
        self.businessCooperationView.frame = CGRectMake(CGRectGetMaxX(self.line3.frame)+10, CGRectGetMaxY(self.horizontal2.frame) + 8, viewWidth-labelSize.width*2, acsize.height + 30);
    
    }
    
    self.businessCooperationView.returnKeyType = UIReturnKeyDone;
//    self.businessCooperationView.scrollEnabled = NO;
    
    self.businessCooperationView.text = @"请介绍贵公司提供的商业合作";
    self.businessCooperationView.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.businessCooperationView.delegate =self;
    self.businessCooperationView.font = [UIFont systemFontOfSize:labelText];
    [self.scrollView addSubview:self.businessCooperationView];

    //横线3
    self.horizontal3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.businessCooperation.frame) + 15, viewWidth, 0.5)];
    self.horizontal3.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal3];
    
    
    
    
    
    
    //区域
    self.workPlace = [[UILabel alloc]init];
    self.workPlace.text = @"区域";
    self.workPlace.textAlignment = NSTextAlignmentRight;
    self.workPlace.font = [UIFont systemFontOfSize:labelText];
    self.workPlace.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.workPlace.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal3.frame) + 15, labelSize.width, labelSize.height);
    [self.scrollView addSubview:self.workPlace];
    
    self.line4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.workPlace.frame)+10, CGRectGetMaxY(self.horizontal3.frame) +8, 1, labelSize.height+14)];
    self.line4.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line4];
    
    
    
    self.place = [[UIButton alloc]init];
    [self.place setTitle:@"地区" forState:UIControlStateNormal];
    self.place.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.place.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.place setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forState:UIControlStateNormal];
    CGSize placeSize = [self.place.titleLabel.text sizeWithFont:self.place.titleLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.place.frame = CGRectMake(CGRectGetMaxX(self.line4.frame)+15, CGRectGetMaxY(self.horizontal3.frame) + 15, viewWidth- labelSize.width - 80, placeSize.height);
    [self.place addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.place.tag = 2;
    [self.scrollView addSubview:self.place];
    
    
    
    
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth-35, self.workPlace.frame.origin.y + self.workPlace.frame.size.height/8, self.workPlace.frame.size.height/4*3, self.workPlace.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.tag = 2;
    [self.scrollView addSubview:self.downBtn];
    

    

    
    

    
    //横线4
    self.horizontal4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.workPlace.frame) + 15, viewWidth, 0.5)];
    self.horizontal4.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal4];
    
    
    //详细地址
    self.detailPlace = [[UILabel alloc]init];
    self.detailPlace.text = @"办公地址";
    self.detailPlace.font = [UIFont systemFontOfSize:labelText];
    self.detailPlace.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.detailPlace.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal4.frame) + 15, labelSize.width, labelSize.height);
    [self.scrollView addSubview:self.detailPlace];
    
    
    
    //
    self.line5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.detailPlace.frame)+10, CGRectGetMaxY(self.horizontal4.frame) + 8, 1, self.detailPlace.frame.size.height+14)];
    self.line5.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line5];
    
    
    
    
    
    self.workPlaceField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line5.frame)+10, CGRectGetMaxY(self.horizontal4.frame) + 8, viewWidth-45-labelSize.width, self.line4.frame.size.height)];
    if (self.workPlaceField.text.length==0) {
        
        self.workPlaceField.text = [self.dic objectForKey:@"workPlace"];
        
    }
    self.workPlaceField.delegate = self;
    self.workPlaceField.placeholder = @"请填写公司办公地址";
    self.workPlaceField.returnKeyType = UIReturnKeyDone;
    self.workPlaceField.textColor = [UIColor blackColor];
    self.workPlaceField.font = [UIFont systemFontOfSize:labelText];
    self.workPlaceField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self.workPlaceField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.workPlaceField setValue:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.scrollView addSubview:self.workPlaceField];
    
    
    
    //横线5
    self.horizontal5 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.detailPlace.frame) + 15, viewWidth, 0.5)];
    self.horizontal5.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal5];
    
    
    //联系人
    self.contactPerson = [[UILabel alloc]init];
    self.contactPerson.text = @"联系人";
    self.contactPerson.textAlignment = NSTextAlignmentRight;
    self.contactPerson.font = [UIFont systemFontOfSize:labelText];
    self.contactPerson.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.contactPerson.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal5.frame) + 15, labelSize.width, labelSize.height);
    [self.scrollView addSubview:self.contactPerson];
    
    self.line6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contactPerson.frame)+10, CGRectGetMaxY(self.horizontal5.frame) +8, 1, labelSize.height+14)];
    self.line6.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line6];
    
    self.contactPersonField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line6.frame)+10, CGRectGetMaxY(self.horizontal5.frame) + 8, viewWidth-labelSize.width*2, self.line6.frame.size.height)];
    if (self.contactPersonField.text.length==0) {
        
        self.contactPersonField.text = [self.dic objectForKey:@"contactPerson"];
    }
    self.contactPersonField.placeholder = @"请填写姓名";
    self.contactPersonField.delegate = self;
    self.contactPersonField.returnKeyType = UIReturnKeyDone;
    self.contactPersonField.textColor = [UIColor blackColor];
    self.contactPersonField.font = [UIFont systemFontOfSize:labelText];
    self.contactPersonField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
        [self.contactPersonField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
        [self.contactPersonField setValue:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        
        [self.scrollView addSubview:self.contactPersonField];
    //横线6
    self.horizontal6 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contactPerson.frame) + 15, viewWidth, 0.5)];
    self.horizontal6.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal6];
    
    
    
    
    //联系电话
    self.telephoneNumber = [[UILabel alloc]init];
    self.telephoneNumber.text = @"      电话";
    self.telephoneNumber.font = [UIFont systemFontOfSize:labelText];
    self.telephoneNumber.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.telephoneNumber.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal6.frame) + 15, labelSize.width, labelSize.height);
    [self.scrollView addSubview:self.telephoneNumber];
    
    self.line7 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.telephoneNumber.frame)+10, CGRectGetMaxY(self.horizontal6.frame) +8, 1, labelSize.height+14)];
    self.line7.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line7];
    
    self.telephoneNumberField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line7.frame)+10, CGRectGetMaxY(self.horizontal6.frame) +8, viewWidth-labelSize.width*2, self.line1.frame.size.height)];
    if (self.telephoneNumberField.text.length==0) {
        
        self.telephoneNumberField.text = [self.dic objectForKey:@"telephoneNumber"];
    }
    self.telephoneNumberField.returnKeyType = UIReturnKeyDone;
    self.telephoneNumberField.placeholder = @"请填写手机或固话";
    self.telephoneNumberField.textColor = [UIColor blackColor];
    self.telephoneNumberField.delegate = self;
    self.telephoneNumberField.font = [UIFont systemFontOfSize:labelText];
    self.telephoneNumberField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self.telephoneNumberField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.telephoneNumberField setValue:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.scrollView addSubview:self.telephoneNumberField];
    
    
    //横线7
    self.horizontal7 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.telephoneNumber.frame) + 15, viewWidth, 0.5)];
    self.horizontal7.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal7];
    
    
    //发布
    self.releaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/4,CGRectGetMaxY(self.horizontal7.frame) + 10, viewWidth/2, 40)];
    [self.releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
    self.releaseBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    //[self.releaseBtn setBackgroundColor:[UIColor colorWithRed:52/255.0 green:142/255.0 blue:221/255.0 alpha:1]];
    [self.releaseBtn setBackgroundImage:[UIImage imageNamed:@"home_7_btn.png"] forState:UIControlStateNormal];
    [self.releaseBtn setBackgroundImage:[UIImage imageNamed:@"home_7_btn_col.png"] forState:UIControlStateSelected];
    [self.releaseBtn addTarget:self action:@selector(releaseBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.releaseBtn.layer.cornerRadius = 20;
    self.releaseBtn.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.releaseBtn];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.releaseBtn.frame)+15);
    [self restore];
}

-(void)showZiZhi{
    HZZiZhiViewController *controller = [[HZZiZhiViewController alloc] init];
    controller.buttonTitles = self.buttonTitles;
    [self presentVC:controller];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self onCreate];
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   if (tableView==self.tableView){
    
        return 4;
   }else if (tableView==self.tableView1){

       return self.placeList.count;
   }
    
    
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifire = @"Cell";
    static NSString* identifire1 = @"Cell1";
    UITableViewCell* cell = nil;
    UITableViewCell* cell1 = nil;
    cell = [self.tableView dequeueReusableCellWithIdentifier:identifire];
    cell1 = [self.tableView1 dequeueReusableCellWithIdentifier:identifire1];
    if (tableView==self.tableView) {
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            
        }
        cell.userInteractionEnabled = YES;
        
        if ([self.searchBar.text isEqualToString:@"市政"]) {
            
            cell.textLabel.text = [suggestItems objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:labelText-2];
        }
        
        return cell;
    }else if (tableView==self.tableView1){
        
        if (!cell1){
            
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire1];
            HZPlaceModel* info = [self.placeList objectAtIndex:indexPath.row];
           
            cell1.textLabel.text = info.name;
        
            cell1.textLabel.font = [UIFont systemFontOfSize:labelText-2];
            
        }
        return cell1;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView){
        return 40;
    }else if (tableView==self.tableView1){
        return 44;
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView) {
        NSString* string = [suggestItems objectAtIndex:indexPath.row];
        self.searchBar.text = string;
    }else if (tableView==self.tableView1){
        HZPlaceModel* info = [self.placeList objectAtIndex:indexPath.row];
        [self.place setTitle:info.name forState:UIControlStateNormal];
        [self.place setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btn1 removeFromSuperview];
    }
 

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(self.searchBar.frame.origin.x, (labelSize.height+30)*2, self.searchBar.frame.size.width, 120)];
    self.view1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.view1];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view1.frame.size.width, self.view1.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [self.view1 addSubview:self.tableView];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
   
    if (self.searchBar.text.length==2) {
        [self.tableView reloadData];
    }

}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

    


//删除资质按钮
-(void)deleteBtn:(UIButton*)sender{
     [self.scrollView removeFromSuperview];
    [self.buttonTitles removeObjectAtIndex:sender.tag - 1000];
    [self onCreate];
    [self restore];
}

- (void)restore{
    if (self.companyField.text.length!=0) {
        [self.dic setObject:self.companyField.text forKey:@"company"];
    }else if (self.businessCooperationField.text.length!=0){
        
        [self.dic setObject:self.businessCooperationField.text forKey:@"businessCooperation"];
    }else if (self.workPlaceField.text.length != 0){
        
        [self.dic setObject:self.workPlaceField.text forKey:@"workPlace"];
    }else if (self.contactPersonField.text.length != 0){
        
        [self.dic setObject:self.contactPersonField.text forKey:@"contactPerson"];
    }else if (self.telephoneNumberField.text.length!=0){
        
        [self.dic setObject:self.telephoneNumberField.text forKey:@"telephoneNumber"];
    }else if (self.businessCooperationView.text.length!=0){
        [self.dic setObject:self.businessCooperationView.text forKey:@"textView"];
        
    }
}
//选择地区
-(void)down:(UIButton*)sender{
    [self getPlace];
    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    //图层透明，控件不透明
    UIColor *color = [UIColor blackColor];
    self.btn1.backgroundColor = [color colorWithAlphaComponent:0.5];
    //    self.view1.backgroundColor = [UIColor blackColor];
    //    self.view1.alpha = 0.7;
    self.btn1.userInteractionEnabled = YES;
    [self.btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn1];
    
    
    //标题
    self.titleLabel = [[UILabel alloc]init];
    
    self.titleLabel.text = @"地区";
    [self getPlace];
    self.titleLabel.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.frame = CGRectMake(15, (viewHeight - 344)/2, viewWidth - 30, 40);
    [self.btn1 addSubview:self.titleLabel];
    
    //列表
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), viewWidth - 30, 240)];
    self.tableView1.dataSource = self;
    self.tableView1.delegate = self;
    [self.tableView1 reloadData];
    [self.btn1 addSubview:self.tableView1];


}

-(void)btn1:(UIButton*)sender{
    [self.btn1 removeFromSuperview];
    self.tableView.scrollEnabled = YES;
}
//发布按钮
-(void)releaseBtn:(UIButton*)sender{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag=200;
        [alertView show];
    }else if(self.companyField.text.length==0||self.businessCooperationView.text.length==0||self.place.titleLabel.text.length==0||self.workPlaceField.text.length==0||self.contactPersonField.text.length==0||self.telephoneNumberField.text.length==0){
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (self.companyField.text.length>20||self.businessCooperationView.text.length>100||self.workPlaceField.text.length>15||self.contactPersonField.text.length>6){
        if (self.companyField.text.length>20) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"公司名称字数不能大于20" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else if (self.businessCooperationView.text.length>100){
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"详情介绍字数不能大于100" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else if (self.workPlaceField.text.length>15){
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"办公地址字数不能大于15" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else if (self.contactPersonField.text.length>6){
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"联系人字数不能大于6" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        
        }
        
    }else{
        
        NSString *string = [self.buttonTitles componentsJoinedByString:@","];
        [MbPaser sendInfoCompanyByUserid:self.userid company:self.companyField.text aptitude:self.zizhi range:self.businessCooperationView.text area:self.place.titleLabel.text address:self.workPlaceField.text contact:self.contactPersonField.text phone:self.telephoneNumberField.text result:^(InfoCompanySaveResponse *response, NSError *error) {
            if (response.turn==200) {
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                self.str = [NSString stringWithFormat:@"%d",response.turn];
                [alertView show];
            }else{
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alertView show];
                
            }

        }];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        if ([self.str isEqualToString:@"200"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
    }
   
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (self.businessCooperationView == textView) {
        self.businessCooperationView.text = @"";
        self.businessCooperationView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.businessCooperationView == textView) {
        if (textView.text.length == 0) {
            self.businessCooperationView.text = @"请介绍贵公司提供的商业合作";
            self.businessCooperationView.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        }
    
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    
    [self.workPlaceField resignFirstResponder];
    [self.contactPersonField resignFirstResponder];
    [self.telephoneNumberField resignFirstResponder];
    [self.place resignFirstResponder];
   
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.companyField ==textField) {
        [self.dic setObject:self.companyField.text forKey:@"company"];
    }else if (self.businessCooperationField == textField){
        
        [self.dic setObject:self.businessCooperationField.text forKey:@"businessCooperation"];
    }else if (self.workPlaceField==textField){
        
        [self.dic setObject:self.workPlaceField.text forKey:@"workPlace"];
    }else if (self.contactPersonField== textField){
        
        [self.dic setObject:self.contactPersonField.text forKey:@"contactPerson"];
    }else if (self.telephoneNumberField== textField){
        
        [self.dic setObject:self.telephoneNumberField.text forKey:@"telephoneNumber"];
    }else if (self.businessCooperationView.text.length!=0){
        [self.dic setObject:self.businessCooperationView.text forKey:@"textView"];
        
    }

    if (textField==self.telephoneNumberField) {
        return [self validateNumber:string];
    }else
        return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark 触摸屏幕回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark textfield收起键盘方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //[textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    if (self.buttonTitles.count>2) {
        if ([self.companyField isEditing]||[self.businessCooperationField isEditing]) {
            
        }else{
            
            [UIView beginAnimations:@"Animation" context:nil];
            [UIView setAnimationDuration:0.20];
            [UIView setAnimationBeginsFromCurrentState: YES];
            self.scrollView.frame = CGRectMake(self.view.frame.origin.x, self.scrollView.frame.origin.y - 216, self.scrollView.frame.size.width, self.view.frame.size.height);
            [UIView commitAnimations];
        }
 
    }else{
        if ([self.companyField isEditing]||[self.businessCooperationField isEditing]) {
            
        }else{
            
            [UIView beginAnimations:@"Animation" context:nil];
            [UIView setAnimationDuration:0.20];
            [UIView setAnimationBeginsFromCurrentState: YES];
            self.scrollView.frame = CGRectMake(self.view.frame.origin.x, self.scrollView.frame.origin.y - 166, self.scrollView.frame.size.width, self.view.frame.size.height);
            [UIView commitAnimations];
        }
    }
}
#pragma mark 编辑之后frame弹回
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.buttonTitles.count>2) {
        if (self.scrollView.frame.origin.y!=0) {
            [UIView beginAnimations:@"Animation" context:nil];
            [UIView setAnimationDuration:0.20];
            [UIView setAnimationBeginsFromCurrentState: YES];
            self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y + 216, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            [UIView commitAnimations];
        }
    }else{
        if (self.scrollView.frame.origin.y!=0) {
            [UIView beginAnimations:@"Animation" context:nil];
            [UIView setAnimationDuration:0.20];
            [UIView setAnimationBeginsFromCurrentState: YES];
            self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y + 166, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            [UIView commitAnimations];
        }
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    //计算文本的高度
    CGSize constraintSize = CGSizeMake(textView.frame.size.width, 300);
    NSDictionary* tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:labelText],NSFontAttributeName, nil];
    CGSize acsize = [textView.text boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    //重新调整textView的高度
    //[self.view setNeedsLayout];
    
    if (self.companyField.text.length!=0) {
        [self.dic setObject:self.companyField.text forKey:@"company"];
    }else if (self.businessCooperationField.text.length!=0){
        
        [self.dic setObject:self.businessCooperationField.text forKey:@"businessCooperation"];
    }else if (self.workPlaceField.text.length != 0){
        
        [self.dic setObject:self.workPlaceField.text forKey:@"workPlace"];
    }else if (self.contactPersonField.text.length != 0){
        
        [self.dic setObject:self.contactPersonField.text forKey:@"contactPerson"];
    }else if (self.telephoneNumberField.text.length!=0){
        
        [self.dic setObject:self.telephoneNumberField.text forKey:@"telephoneNumber"];
    }else if (self.businessCooperationView.text.length!=0){
        [self.dic setObject:self.businessCooperationView.text forKey:@"textView"];
        
    }

    
    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, acsize.height);

    [self.horizontal3 removeFromSuperview];
    [self.workPlace removeFromSuperview];
    [self.line4 removeFromSuperview];
    [self.place removeFromSuperview];
    [self.downBtn removeFromSuperview];
    
    [self.horizontal4 removeFromSuperview];
    [self.detailPlace removeFromSuperview];
    [self.line5 removeFromSuperview];
    [self.workPlaceField removeFromSuperview];
    [self.horizontal5 removeFromSuperview];
    [self.contactPerson removeFromSuperview];
    [self.line6 removeFromSuperview];
    [self.contactPersonField removeFromSuperview];
    [self.horizontal6 removeFromSuperview];
    [self.telephoneNumber removeFromSuperview];
    [self.line7 removeFromSuperview];
    [self.telephoneNumberField removeFromSuperview];
    [self.horizontal7 removeFromSuperview];
    [self.releaseBtn removeFromSuperview];
    
   
    if (self.line3.frame.size.height>textView.frame.size.height) {
        
    }else{
        [self.line3 removeFromSuperview];
        self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.businessCooperation.frame)+10, CGRectGetMaxY(self.horizontal2.frame) +8, 1, textView.frame.size.height+8)];
        self.line3.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        [self.scrollView addSubview:self.line3];
    }
    
    self.horizontal3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.line3.frame) + 8, viewWidth, 0.5)];
    self.horizontal3.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal3];
    
    
    //区域
    self.workPlace = [[UILabel alloc]init];
    self.workPlace.text = @"区域";
    self.workPlace.textAlignment = NSTextAlignmentRight;
    self.workPlace.font = [UIFont systemFontOfSize:labelText];
    self.workPlace.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.workPlace.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal3.frame) + 15, labelSize.width, labelSize.height);
    [self.scrollView addSubview:self.workPlace];
    
    self.line4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.workPlace.frame)+10, CGRectGetMaxY(self.horizontal3.frame) +8, 1, labelSize.height+14)];
    self.line4.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line4];
    
    
    
    self.place = [[UIButton alloc]init];
    [self.place setTitle:@"地区" forState:UIControlStateNormal];
    self.place.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.place.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.place setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forState:UIControlStateNormal];
    CGSize placeSize = [self.place.titleLabel.text sizeWithFont:self.place.titleLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.place.frame = CGRectMake(CGRectGetMaxX(self.line4.frame)+15, CGRectGetMaxY(self.horizontal3.frame) + 15, viewWidth- labelSize.width - 80, placeSize.height);
    [self.place addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.place.tag = 2;
    [self.scrollView addSubview:self.place];
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth-35, self.workPlace.frame.origin.y + self.workPlace.frame.size.height/8, self.workPlace.frame.size.height/4*3, self.workPlace.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.tag = 2;
    [self.scrollView addSubview:self.downBtn];

    
    //横线4
    self.horizontal4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.workPlace.frame) + 15, viewWidth, 0.5)];
    self.horizontal4.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal4];
    
    
    //详细地址
    self.detailPlace = [[UILabel alloc]init];
    self.detailPlace.text = @"办公地址";
    self.detailPlace.font = [UIFont systemFontOfSize:labelText];
    self.detailPlace.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.detailPlace.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal4.frame) + 15, labelSize.width, labelSize.height);
    [self.scrollView addSubview:self.detailPlace];
    
    
    
    //
    self.line5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.detailPlace.frame)+10, CGRectGetMaxY(self.horizontal4.frame) + 8, 1, self.detailPlace.frame.size.height+10)];
    self.line5.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line5];
    
    
    
    
    
    self.workPlaceField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line5.frame)+10, CGRectGetMaxY(self.horizontal4.frame) + 8, viewWidth-45-labelSize.width, self.line4.frame.size.height)];
    if (self.workPlaceField.text.length==0) {
        
        self.workPlaceField.text = [self.dic objectForKey:@"workPlace"];
        
    }
    self.workPlaceField.delegate = self;
    self.workPlaceField.placeholder = @"请填写公司办公地址";
    
    self.workPlaceField.textColor = [UIColor blackColor];
    self.workPlaceField.font = [UIFont systemFontOfSize:labelText];
    self.workPlaceField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self.workPlaceField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.workPlaceField setValue:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.scrollView addSubview:self.workPlaceField];
    
    
    
    //横线5
    self.horizontal5 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.detailPlace.frame) + 15, viewWidth, 0.5)];
    self.horizontal5.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal5];
    
    
    //联系人
    self.contactPerson = [[UILabel alloc]init];
    self.contactPerson.text = @"联系人";
    self.contactPerson.textAlignment = NSTextAlignmentRight;
    self.contactPerson.font = [UIFont systemFontOfSize:labelText];
    self.contactPerson.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.contactPerson.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal5.frame) + 15, labelSize.width, labelSize.height);
    [self.scrollView addSubview:self.contactPerson];
    
    self.line6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contactPerson.frame)+10, CGRectGetMaxY(self.horizontal5.frame) +8, 1, labelSize.height+14)];
    self.line6.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line6];
    
    self.contactPersonField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line6.frame)+10, CGRectGetMaxY(self.horizontal5.frame) + 8, viewWidth-labelSize.width*2, self.line6.frame.size.height)];
    if (self.contactPersonField.text.length==0) {
        
        self.contactPersonField.text = [self.dic objectForKey:@"contactPerson"];
    }
    self.contactPersonField.placeholder = @"请填写姓名";
    self.contactPersonField.delegate = self;
    self.contactPersonField.textColor = [UIColor blackColor];
    self.contactPersonField.font = [UIFont systemFontOfSize:labelText];
    self.contactPersonField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self.contactPersonField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.contactPersonField setValue:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.scrollView addSubview:self.contactPersonField];
    //横线6
    self.horizontal6 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contactPerson.frame) + 15, viewWidth, 0.5)];
    self.horizontal6.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal6];
    
    
    
    
    //联系电话
    self.telephoneNumber = [[UILabel alloc]init];
    self.telephoneNumber.text = @"      电话";
    self.telephoneNumber.font = [UIFont systemFontOfSize:labelText];
    self.telephoneNumber.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.telephoneNumber.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal6.frame) + 15, labelSize.width, labelSize.height);
    [self.scrollView addSubview:self.telephoneNumber];
    
    self.line7 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.telephoneNumber.frame)+10, CGRectGetMaxY(self.horizontal6.frame) +8, 1, labelSize.height+14)];
    self.line7.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line7];
    
    self.telephoneNumberField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line7.frame)+10, CGRectGetMaxY(self.horizontal6.frame) +8, viewWidth-labelSize.width*2, self.line1.frame.size.height)];
    if (self.telephoneNumberField.text.length==0) {
        
        self.telephoneNumberField.text = [self.dic objectForKey:@"telephoneNumber"];
    }
    self.telephoneNumberField.placeholder = @"请填写手机或固话";
    self.telephoneNumberField.textColor = [UIColor blackColor];
    self.telephoneNumberField.delegate = self;
    self.telephoneNumberField.font = [UIFont systemFontOfSize:labelText];
    self.telephoneNumberField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self.telephoneNumberField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.telephoneNumberField setValue:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.scrollView addSubview:self.telephoneNumberField];
    
    
    //横线7
    self.horizontal7 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.telephoneNumber.frame) + 15, viewWidth, 0.5)];
    self.horizontal7.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal7];
    
    
    //发布
    self.releaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/4,CGRectGetMaxY(self.horizontal7.frame) + 10, viewWidth/2, 40)];
    [self.releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
    self.releaseBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    //[self.releaseBtn setBackgroundColor:[UIColor colorWithRed:52/255.0 green:142/255.0 blue:221/255.0 alpha:1]];
    [self.releaseBtn setBackgroundImage:[UIImage imageNamed:@"home_7_btn.png"] forState:UIControlStateNormal];
    [self.releaseBtn setBackgroundImage:[UIImage imageNamed:@"home_7_btn_col.png"] forState:UIControlStateSelected];
    [self.releaseBtn addTarget:self action:@selector(releaseBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.releaseBtn.layer.cornerRadius = 20;
    self.releaseBtn.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.releaseBtn];
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.releaseBtn.frame)+15);
}



//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField == self.companyField) {
//        if (textField.text.length > 20) {
//            textField.text = [textField.text substringToIndex:20];
//        }
//    }else if (textField == self.businessCooperationField){
//        if (textField.text.length > 100) {
//            textField.text = [textField.text substringToIndex:100];
//        }
//    }else if (textField == self.workPlaceField){
//        if (textField.text.length > 15) {
//            textField.text = [textField.text substringToIndex:15];
//        }
//    }else if (textField == self.contactPersonField){
//        if (textField.text.length > 6) {
//            textField.text = [textField.text substringToIndex:6];
//        }
//    }
//}


//监听输入长度
//-(void)textFiledEditChanged:(NSNotification *)obj{
//    UITextField *textField = (UITextField *)obj.object;
//    NSString *toBeString = textField.text;
//    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
//    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
//        UITextRange *selectedRange = [self.workPlaceField markedTextRange];       //获取高亮部分
//        UITextPosition *position = [self.workPlaceField positionFromPosition:selectedRange.start offset:0];
//        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//        if (!position) {
//            if (toBeString.length > 10) {
//                self.workPlaceField.text = [toBeString substringToIndex:10];
//            }
//        }       // 有高亮选择的字符串，则暂不对文字进行统计和限制
//        else{
//        }
//    }   // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况   else{
//    if (toBeString.length > 10) {
//        self.workPlaceField.text = [toBeString substringToIndex:10];
//    }
//}
//#pragma mark textfield收起键盘方法
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (viewHeight==480) {
//        
//        if ([self.contactPersonField isEditing]) {
//            CGRect frame = textField.frame;
//            int offset = frame.origin.y + 32 - (viewHeight - 320.0);//键盘高度216
//        
//            NSTimeInterval animationDuration = 0.30f;
//            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//            [UIView setAnimationDuration:animationDuration];
//            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//            if(offset > 0)
//                self.scrollView.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//            
//            [UIView commitAnimations];
//        }else if ([self.telephoneNumberField isEditing]) {
//            
//            CGRect frame = textField.frame;
//            int offset = frame.origin.y + 32 - (viewHeight - 314.0);//键盘高度216
//            
//            NSTimeInterval animationDuration = 0.30f;
//            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//            [UIView setAnimationDuration:animationDuration];
//            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//            if(offset > 0)
//                self.scrollView.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//            
//            [UIView commitAnimations];
//            
//        }
//        
//        
//    }else if (viewHeight==568){
//        
//        if ([self.telephoneNumberField isEditing]){
//            
//            
//            CGRect frame = textField.frame;
//            int offset = frame.origin.y + 32 - (viewHeight - 344.0);//键盘高度216
//          
//            NSTimeInterval animationDuration = 0.30f;
//            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//            [UIView setAnimationDuration:animationDuration];
//            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//            if(offset > 0)
//                self.scrollView.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//            
//            [UIView commitAnimations];
//        }
//        
//    }
//        
//    
//}

@end
