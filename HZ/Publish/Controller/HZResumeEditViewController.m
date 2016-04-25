//
//  MbResumeViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/27.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "HZResumeEditViewController.h"
#import "HZPlaceModel.h"
#import "HZPositionModel.h"
#import "HZEducationalExperienceViewController.h"
#import "HZEditSingleSelectionViewController.h"
@interface HZResumeEditViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate>
{
    CGSize textSize;
    CGSize textSize1;
    CGSize textSize2;
}
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UITableView* tableView1;
@property(nonatomic,strong)UITableView* tableView2;
@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,strong)UILabel* titleLabel;           //标题
@property(nonatomic,strong)UITextField* titleDetail;      //具体标题
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UITextField* name;                 //姓名
@property(nonatomic,strong)UILabel* sex;                  //性别
@property(nonatomic,strong)UIButton* manBtn;              //男
@property(nonatomic,strong)UIButton* womenBtn;            //女
@property(nonatomic,strong)UILabel* age;                  //年龄
@property(nonatomic,strong)UITextField* ageField;         //岁数
@property(nonatomic,strong)UIButton* ageBtn;
@property(nonatomic,strong)UILabel* dateLabel;            //日期
@property(nonatomic,strong)UILabel* workingExperience;    //工作经验
@property(nonatomic,strong)UILabel* years;                //年限
@property(nonatomic,strong)UIButton* yearsBtn;
@property(nonatomic,strong)UILabel* educationRequirement; //学历要求
@property(nonatomic,strong)UILabel* education;            //学历
@property(nonatomic,strong)UIButton* educationBtn;
@property(nonatomic,strong)UILabel* educationLevel;       //学历类别
@property(nonatomic,strong)UILabel* jobIntention;         //求职意向
@property(nonatomic,strong)UILabel* type;                 //建造师
@property(nonatomic,strong)UIButton* typeBtn;
@property(nonatomic,strong)UILabel* salary;               //薪资
@property(nonatomic,strong)UILabel* money;                //工资
@property(nonatomic,strong)UIButton* moneyBtn;
@property(nonatomic,strong)UILabel* telephone;            //电话
@property(nonatomic,strong)UILabel* telephoneNumber;      //电话号码
@property(nonatomic,strong)UITextField* telephoneField;
@property(nonatomic,strong)UILabel* yeartoyear;           //教育时间
@property(nonatomic,strong)UILabel* worktoyear;           //工作时间
@property(nonatomic,strong)UILabel* school;               //学校
@property(nonatomic,strong)UILabel* schoolLabel;          //学校名称
@property(nonatomic,strong)UILabel* professional;         //专业
@property(nonatomic,strong)UILabel* professionalType;     //什么专业
@property(nonatomic,strong)UIButton* workExperience;      //工作经历
@property(nonatomic,strong)UIButton* educationExperience; //教育经历
@property(nonatomic,strong)UILabel* workExperienceDetail; //工作经历描述
@property(nonatomic,strong)UILabel* selfIntroduction;     //自我介绍
@property(nonatomic,strong)UITextField* introduction;     //具体介绍
@property(nonatomic,strong)UIButton* releaseBtn;          //发布按钮




@property(nonatomic,strong)UILabel* company;              //公司
@property(nonatomic,strong)UILabel* companyLabel;
@property(nonatomic,strong)UILabel* typeLabel;
@property(nonatomic,strong)UILabel* workContent;          //工作内容
@property(nonatomic,strong)UILabel* workContentLabel;


@property(nonatomic,strong)UILabel* line1;                 //竖线
@property(nonatomic,strong)UILabel* line2;
@property(nonatomic,strong)UILabel* line3;
@property(nonatomic,strong)UILabel* line4;
@property(nonatomic,strong)UILabel* line5;
@property(nonatomic,strong)UILabel* line6;
@property(nonatomic,strong)UILabel* line7;
@property(nonatomic,strong)UILabel* line8;
@property(nonatomic,strong)UILabel* line9;


@property(nonatomic,strong)UILabel* horizontal1;          //横线
@property(nonatomic,strong)UILabel* horizontal2;
@property(nonatomic,strong)UILabel* horizontal3;
@property(nonatomic,strong)UILabel* horizontal4;
@property(nonatomic,strong)UILabel* horizontal5;
@property(nonatomic,strong)UILabel* horizontal6;
@property(nonatomic,strong)UILabel* horizontal7;
@property(nonatomic,strong)UILabel* horizontal8;
@property(nonatomic,strong)UILabel* horizontal9;
@property(nonatomic,strong)UILabel* horizontal10;

@property(nonatomic,strong)UIButton* btn1;                 //提示界面
@property(nonatomic,strong)UIButton* btn2;
@property(nonatomic,strong)UIView* view3;
@property(nonatomic,strong)UIButton* sureBtn;             //确定按钮
@property(nonatomic,strong)UIButton* cancleBtn;           //取消按钮
@property(nonatomic,strong)UIButton* addBtn;              //添加按钮
@property(nonatomic,strong)UIButton* downBtn;             //向下箭头
@property(nonatomic,strong)UIButton* choiceBtn;           //选填按钮
@property(nonatomic,strong)UILabel* text;
@property(nonatomic,strong)UILabel* text2;
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,assign)NSInteger tag1;
@property(nonatomic,strong)NSArray* ageArray;
@property(nonatomic,strong)NSArray* moneyArray;
@property(nonatomic,strong)NSArray* xueli;
@property(nonatomic,strong)NSArray* workArray;
@property(nonatomic,strong)NSArray* jobs;
@property(nonatomic,strong)UIImageView* titleImage;
@property(nonatomic,strong)HZEducationalExperienceViewController* edVC;   //添加教育经历页面
//@property(nonatomic,strong)HZWorkExperienceViewController* workVC;        //添加教育经历
@property(nonatomic,strong)UIButton* deleteBtn;                           //教育删除按钮
@property(nonatomic,strong)UIButton* deleteBtn1;                          //工作删除按钮
@property(nonatomic,strong)NSString* userid;
@property(nonatomic,assign)int sexing;
@property(nonatomic,strong)NSMutableDictionary* dic;                      //暂时保存数据
@property(nonatomic,assign)NSInteger deleteTag;
@property(nonatomic,assign)NSInteger deleteTag1;
@property(nonatomic,strong)NSMutableArray* placeList;                     //地区数组
@property(nonatomic,strong)NSMutableArray* educationList;                 //教育数组
@property(nonatomic,strong)NSMutableArray* experienceList;                //经验数组
@property(nonatomic,strong)NSMutableArray* positionList;                  //职位数组
@property(nonatomic,strong)NSMutableArray* salaryList;                    //薪资数组
@property(nonatomic,strong)NSString* str;
//@property(nonatomic,strong)MbCenterViewController* centerView;            //个人中心
@property(nonatomic,assign)CGFloat heit;

@property (nonatomic, strong) HZEditSingleSelectionViewController *selectionController;
@end

@implementation HZResumeEditViewController

- (HZEditSingleSelectionViewController *)selectionController{
    if (_selectionController == nil) {
        _selectionController = [[HZEditSingleSelectionViewController alloc] init];
        [self.view addSubview:_selectionController.view];
        _selectionController.view.hidden = YES;
    }
    return _selectionController;
}

- (void)customArray{
    self.addeduArray = [NSMutableArray array];
    self.addworkArray = [NSMutableArray array];
    self.addeduArrayStr = [NSMutableArray array];
    self.addworkArrayStr = [NSMutableArray array];
    self.mutDic = [[NSMutableDictionary alloc]init];
    self.workDic = [[NSMutableDictionary alloc]init];
    self.dic = [[NSMutableDictionary alloc]init];
    self.userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    self.placeList = [NSMutableArray array];
    self.educationList = [NSMutableArray array];
    self.experienceList = [NSMutableArray array];
    self.positionList = [NSMutableArray array];
    self.salaryList = [NSMutableArray array];
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 16; i < 71; i ++) {
        NSString *iS = [NSString stringWithFormat:@"%d",i];
        [array addObject:iS];
        
    }
    self.ageArray = array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写简历信息";
    [self customArray];
    [self getExperience];
    [self getEducation];
    [self getPosition];
    [self getSalary];
}
//地区
-(void)requestPlace{
    
    [[NetworkManager manager] postRequest:hopeplace completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        self.placeList = [HZPlaceModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
         [self.tableView1 reloadData];
    }];
}
////学历
-(void)getEducation{
    [[NetworkManager manager] postRequest:hopeeducation completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        self.educationList = [HZPlaceModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        [self.tableView1 reloadData];
    }];
}
////工作经验
-(void)getExperience{
    
    [[NetworkManager manager] postRequest:hopeexperience completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        self.experienceList = [HZPlaceModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        [self.tableView1 reloadData];
    }];
}
////应聘职位
-(void)getPosition{
//    NSURL *url = [NSURL URLWithString:hopeposition];
    [[NetworkManager manager] postRequest:hopeposition completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        self.positionList = [HZPositionModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        [self.tableView1 reloadData];
    }];
}
////期望薪资
-(void)getSalary{

    [[NetworkManager manager] postRequest:hopesalary completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        self.salaryList = [HZPlaceModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        [self.tableView1 reloadData];
    }];
}
//



//初始化控件
-(void)setup{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.scrollView.delegate = self;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    titleLabel.text = @"自我介绍";
    titleLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:labelText];
    CGSize titleSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    titleLabel.frame = CGRectMake(15, 15, titleSize.width, titleSize.height);
    [self.scrollView addSubview:titleLabel];
    
    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+15, 10, 1, titleLabel.frame.size.height+10)];
    self.line1.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    
    [self.scrollView addSubview:self.line1];
    
    self.titleDetail = [[UITextField alloc]init];
    self.titleDetail.placeholder = @"一句话介绍自己";
    self.titleDetail.delegate = self;
    self.titleDetail.returnKeyType = UIReturnKeyDone;
    self.titleDetail.text = [self.dic objectForKey:@"jieshao"];
    
    if (self.titleDetail.text.length!=0) {
        [self.dic setObject:self.titleDetail.text forKey:@"jieshao"];
        //姓名
    }
    self.titleDetail.delegate = self;
    self.titleDetail.font = [UIFont systemFontOfSize:labelText];
    self.titleDetail.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.titleDetail.frame = CGRectMake(CGRectGetMaxX(self.line1.frame)+15, 15, ScreenWidth-61-titleSize.width, titleSize.height);
    [self.scrollView addSubview:self.titleDetail];
    //横线1
    self.horizontal1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+15, ScreenWidth, 0.5)];
    self.horizontal1.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal1];
    
    
    
    //姓名
    self.nameLabel = [UILabel new];
    self.nameLabel.text = @"       姓名";
    self.nameLabel.font = [UIFont systemFontOfSize:labelText];
    self.nameLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    CGSize nameLabelSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.nameLabel.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal1.frame) + 15, nameLabelSize.width, nameLabelSize.height);
    [self.scrollView addSubview:self.nameLabel];
    
    
    self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+15, CGRectGetMaxY(self.horizontal1.frame) + 10, 1, self.nameLabel.frame.size.height+10)];
    self.line2.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line2];
    //名字
    self.name = [UITextField new];
    self.name.placeholder = @"请填写名字";
    
    self.name.text = [self.dic objectForKey:@"xingming"];
    if (self.name.text.length!=0) {
        [self.dic setObject:self.name.text forKey:@"xingming"];
        //姓名
    }
    self.name.font = [UIFont systemFontOfSize:labelText];
    self.name.delegate = self;
    self.name.returnKeyType = UIReturnKeyDone;
    self.name.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    
    self.name.frame = CGRectMake(CGRectGetMaxX(self.line2.frame) + 15, CGRectGetMaxY(self.horizontal1.frame) + 15, nameLabelSize.width*1.5, nameLabelSize.height);
    [self.scrollView addSubview:self.name];
    
    
    //男
    self.manBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-15-nameLabelSize.width/3*4, CGRectGetMaxY(self.horizontal1.frame) + 9, nameLabelSize.width/1.5, nameLabelSize.height+12)];
    [self.manBtn setBackgroundImage:[UIImage imageNamed:@"kuangz.png"] forState:UIControlStateNormal];
    [self.manBtn setBackgroundImage:[UIImage imageNamed:@"kuangd.png"] forState:UIControlStateSelected];
    [self.manBtn addTarget:self action:@selector(man:) forControlEvents:UIControlEventTouchUpInside];
    self.manBtn.selected = YES;
    self.sexing=1;
    [self.manBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.manBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
    self.manBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.manBtn setTitle:@"男" forState:UIControlStateNormal];
    self.manBtn.layer.cornerRadius = 3;
    self.manBtn.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.manBtn];
    //女
    self.womenBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.manBtn.frame), CGRectGetMaxY(self.horizontal1.frame) + 9, nameLabelSize.width/1.5, nameLabelSize.height+12)];
    [self.womenBtn setBackgroundImage:[UIImage imageNamed:@"kuangy.png"] forState:UIControlStateNormal];
    [self.womenBtn setBackgroundImage:[UIImage imageNamed:@"kuangd.png"] forState:UIControlStateSelected];
    [self.womenBtn addTarget:self action:@selector(woman:) forControlEvents:UIControlEventTouchUpInside];
    [self.womenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.womenBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
    self.womenBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.womenBtn setTitle:@"女" forState:UIControlStateNormal];
    
    [self.scrollView addSubview:self.womenBtn];
    
    //横线2
    self.horizontal2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame)+15, ScreenWidth, 0.5)];
    self.horizontal2.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal2];
    
    //年龄
    self.age = [[UILabel alloc]init];
    self.age.text = @"       年龄";
    self.age.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.age.font = [UIFont systemFontOfSize:labelText];
    CGSize ageSize = [self.age.text sizeWithFont:self.age.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.age.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal2.frame) + 15, ageSize.width, ageSize.height);
    [self.scrollView addSubview:self.age];
    
    self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.age.frame)+15, CGRectGetMaxY(self.horizontal2.frame) + 10, 1, self.age.frame.size.height+10)];
    self.line3.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line3];
    
    self.ageBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line3.frame)+15, CGRectGetMaxY(self.horizontal2.frame) + 15, ScreenWidth-80-ageSize.width, ageSize.height)];
    if (![self.dic objectForKey:@"nianling"]) {
        [self.ageBtn setTitle:@"请选择年龄" forState:UIControlStateNormal];
        [self.ageBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        [self.ageBtn setTitle:[self.dic objectForKey:@"nianling"] forState:UIControlStateNormal];
        
        if ([[self.dic objectForKey:@"nianling"] isEqualToString:@"请选择年龄"]) {
            [self.ageBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] forState:UIControlStateNormal];
        }else{
            [self.ageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        
    }
    
    self.ageBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    
    //这句无效
    //        self.ageBtn.titleLabel.textAlignment =NSTextAlignmentLeft;
    self.ageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.ageBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.ageBtn.tag=1000 + 1;
    [self.scrollView addSubview:self.ageBtn];
    
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-35,CGRectGetMaxY(self.horizontal2.frame) + 15+ self.age.frame.size.height/8, self.age.frame.size.height/4*3, self.age.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.tag = 1;
    [self.scrollView addSubview:self.downBtn];
    
    
    
    //横线3
    self.horizontal3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.age.frame)+15, ScreenWidth, 0.5)];
    self.horizontal3.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal3];
    
    
    //学历
    self.educationRequirement = [[UILabel alloc]init];
    self.educationRequirement.text = @"       学历";
    self.educationRequirement.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.educationRequirement.font = [UIFont systemFontOfSize:labelText];
    CGSize educationRequirementSize = [self.educationRequirement.text sizeWithFont:self.educationRequirement.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.educationRequirement.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal3.frame) + 15, educationRequirementSize.width, educationRequirementSize.height);
    [self.scrollView addSubview:self.educationRequirement];
    
    self.line4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.educationRequirement.frame)+15, CGRectGetMaxY(self.horizontal3.frame) + 10, 1, self.educationRequirement.frame.size.height+10)];
    self.line4.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line4];
    
    self.educationBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line4.frame)+15, CGRectGetMaxY(self.horizontal3.frame) + 15, ScreenWidth-80-educationRequirementSize.width, educationRequirementSize.height)];
    if ([self.dic objectForKey:@"xueli"]==nil) {
        [self.educationBtn setTitle:@"请选择学历" forState:UIControlStateNormal];
        [self.educationBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        
        
        [self.educationBtn setTitle:[self.dic objectForKey:@"xueli"] forState:UIControlStateNormal];
        if ([[self.dic objectForKey:@"xueli"] isEqualToString:@"请选择学历"]) {
            [self.educationBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] forState:UIControlStateNormal];
            
        }else{
            [self.educationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    self.educationBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.educationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.educationBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.educationBtn.tag = 1000 + 2;
    [self.scrollView addSubview:self.educationBtn];
    
    
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-35, self.educationRequirement.frame.origin.y + self.educationRequirement.frame.size.height/8,self.age.frame.size.height/4*3 ,self.age.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.tag = 2;
    [self.scrollView addSubview:self.downBtn];
    
    
    //横线4
    self.horizontal4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.educationRequirement.frame)+15, ScreenWidth, 0.5)];
    self.horizontal4.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal4];
    
    //工作经验
    self.workingExperience = [[UILabel alloc]init];
    self.workingExperience.text = @"工作经验";
    self.workingExperience.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.workingExperience.font = [UIFont systemFontOfSize:labelText];
    CGSize workingExperienceSize = [self.workingExperience.text sizeWithFont:self.workingExperience.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.workingExperience.frame = CGRectMake(15,CGRectGetMaxY(self.horizontal4.frame) + 15, workingExperienceSize.width, workingExperienceSize.height);
    [self.scrollView addSubview:self.workingExperience];
    
    self.line5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.workingExperience.frame)+15, CGRectGetMaxY(self.horizontal4.frame) + 10, 1, self.workingExperience.frame.size.height+10)];
    self.line5.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line5];
    
    
    
    
    self.yearsBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line4.frame)+15, CGRectGetMaxY(self.horizontal4.frame) + 15, ScreenWidth-80-workingExperienceSize.width, workingExperienceSize.height)];
    if ([self.dic objectForKey:@"jingyan"]==nil) {
        [self.yearsBtn setTitle:@"请选择工作年限" forState:UIControlStateNormal];
        [self.yearsBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        [self.yearsBtn setTitle:[self.dic objectForKey:@"jingyan"] forState:UIControlStateNormal];
        if ([[self.dic objectForKey:@"jingyan"] isEqualToString:@"请选择工作年限"]) {
            [self.yearsBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] forState:UIControlStateNormal];
        }else{
            [self.yearsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    self.yearsBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    
    
    self.yearsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.yearsBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.yearsBtn.tag = 1000 + 3;
    [self.scrollView addSubview:self.yearsBtn];
    
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-35, self.workingExperience.frame.origin.y + self.workingExperience.frame.size.height/8, self.age.frame.size.height/4*3, self.age.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.tag = 3;
    [self.scrollView addSubview:self.downBtn];
    
    
    
    
    
    //横线5
    self.horizontal5 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.workingExperience.frame)+15, ScreenWidth, 0.5)];
    self.horizontal5.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal5];
    
    
    //求职意向
    self.jobIntention = [[UILabel alloc]init];
    self.jobIntention.text = @"意向职位";
    self.jobIntention.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.jobIntention.font = [UIFont systemFontOfSize:labelText];
    CGSize jobIntentionSize = [self.jobIntention.text sizeWithFont:self.jobIntention.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.jobIntention.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal5.frame)+15, jobIntentionSize.width, jobIntentionSize.height);
    [self.scrollView addSubview:self.jobIntention];
    
    self.line6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.jobIntention.frame)+15, CGRectGetMaxY(self.horizontal5.frame)+10, 1, self.jobIntention.frame.size.height+10)];
    self.line6.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line6];
    
    
    
    
    self.typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line6.frame)+15, CGRectGetMaxY(self.horizontal5.frame)+15, ScreenWidth-80-jobIntentionSize.width, jobIntentionSize.height)];
    if ([self.dic objectForKey:@"zhiwei"]==nil) {
        [self.typeBtn setTitle:@"请选择职位意向" forState:UIControlStateNormal];
        [self.typeBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        [self.typeBtn setTitle:[self.dic objectForKey:@"zhiwei"] forState:UIControlStateNormal];
        if ([[self.dic objectForKey:@"zhiwei"] isEqualToString:@"请选择职位意向"]) {
            [self.typeBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] forState:UIControlStateNormal];
        }else{
            [self.typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    self.typeBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.typeBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.typeBtn.tag = 1000 + 4;
    [self.scrollView addSubview:self.typeBtn];
    
    
    
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-35, self.jobIntention.frame.origin.y+self.jobIntention.frame.size.height/8, self.age.frame.size.height/4*3, self.age.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.tag = 4;
    [self.scrollView addSubview:self.downBtn];
    
    
    //横线6
    self.horizontal6 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.jobIntention.frame)+15, ScreenWidth, 0.5)];
    self.horizontal6.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal6];
    
    //期望薪资
    self.salary = [[UILabel alloc]init];
    self.salary.text = @"期望薪资";
    self.salary.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.salary.font = [UIFont systemFontOfSize:labelText];
    CGSize salarySize = [self.salary.text sizeWithFont:self.salary.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.salary.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal6.frame)+15, salarySize.width, salarySize.height);
    [self.scrollView addSubview:self.salary];
    
    self.line7 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.salary.frame)+15, CGRectGetMaxY(self.horizontal6.frame)+10, 1, self.salary.frame.size.height+10)];
    self.line7.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line7];
    
    
    
    self.moneyBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line7.frame)+15, CGRectGetMaxY(self.horizontal6.frame)+15, ScreenWidth-80-salarySize.width, salarySize.height)];
    if ([self.dic objectForKey:@"xinzi"]==nil) {
        [self.moneyBtn setTitle:@"请选择期望薪资" forState:UIControlStateNormal];
        [self.moneyBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        [self.moneyBtn setTitle:[self.dic objectForKey:@"xinzi"] forState:UIControlStateNormal];
        if ([[self.dic objectForKey:@"xinzi"] isEqualToString:@"请选择期望薪资"]) {
            [self.moneyBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] forState:UIControlStateNormal];
        }else{
            
            [self.moneyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    
    self.moneyBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.moneyBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.moneyBtn.tag = 1000 + 5;
    self.moneyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.scrollView addSubview:self.moneyBtn];
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-35, self.salary.frame.origin.y + self.salary.frame.size.height/8, self.age.frame.size.height/4*3, self.age.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.tag = 5;
    [self.scrollView addSubview:self.downBtn];
    
    
    
    //横线7
    self.horizontal7 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.salary.frame)+15, ScreenWidth, 0.5)];
    self.horizontal7.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal7];
    
    
    //列表
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.horizontal7.frame), ScreenWidth, textSize.height*2+80+ (textSize.height*4+60)*self.addeduArray.count + (textSize.height*4+60)*self.addworkArray.count)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView reloadData];
    [self.scrollView addSubview:self.tableView];
    //横线8
    self.horizontal8 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), ScreenWidth, 0.5)];
    self.horizontal8.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal8];
    
    
    
    //自我介绍
    self.selfIntroduction = [UILabel new];
    self.selfIntroduction.text = @"详细介绍";
    self.selfIntroduction.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.selfIntroduction.font = [UIFont systemFontOfSize:labelText];
    CGSize selfIntroductionSize = [self.selfIntroduction.text sizeWithFont:self.selfIntroduction.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.selfIntroduction.frame = CGRectMake(15,CGRectGetMaxY(self.horizontal8.frame) + 15, selfIntroductionSize.width, selfIntroductionSize.height);
    [self.scrollView addSubview:self.selfIntroduction];
    
    
    self.line8 = [[UILabel alloc]init];
    self.line8.frame = CGRectMake(CGRectGetMaxX(self.selfIntroduction.frame)+15, CGRectGetMaxY(self.horizontal8.frame)+10, 1, self.selfIntroduction.frame.size.height+10);
    self.line8.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line8];
    //自我具体介绍
    self.introduction = [[UITextField alloc]init];
    self.introduction.placeholder = @"详细描述自身的工作能力等等";
    self.introduction.text = [self.dic objectForKey:@"xiangxijieshao"];
    self.introduction.font = [UIFont systemFontOfSize:labelText];
    self.introduction.delegate = self;
    self.introduction.userInteractionEnabled = YES;
    self.introduction.textColor = [UIColor blackColor];
    [self.introduction setReturnKeyType:(UIReturnKeyDone)];
    self.introduction.keyboardAppearance=UIKeyboardAppearanceDefault;
    self.introduction.returnKeyType=UIReturnKeyDone;
    self.introduction.frame = CGRectMake(CGRectGetMaxX(self.line8.frame)+15,CGRectGetMaxY(self.tableView.frame) + 10, ScreenWidth-61-selfIntroductionSize.width, selfIntroductionSize.height+10);
    [self.scrollView addSubview:self.introduction];
    
    //横线9
    self.horizontal9 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selfIntroduction.frame)+15, ScreenWidth, 0.5)];
    self.horizontal9.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal9];
    
    
    
    
    
    //电话
    
    self.telephone = [[UILabel alloc]init];
    self.telephone.text = @"       电话";
    self.telephone.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.telephone.font = [UIFont systemFontOfSize:labelText];
    CGSize telephoneSize = [self.telephone.text sizeWithFont:self.telephone.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.telephone.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal9.frame)+15, telephoneSize.width, telephoneSize.height);
    [self.scrollView addSubview:self.telephone];
    
    self.line9 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.telephone.frame)+15, CGRectGetMaxY(self.horizontal9.frame)+10, 1, self.telephone.frame.size.height+10)];
    self.line9.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line9];
    
    
    
    self.telephoneField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line9.frame)+15, CGRectGetMaxY(self.horizontal9.frame)+15, ScreenWidth-80-telephoneSize.width, telephoneSize.height)];
    self.telephoneField.placeholder = @"请填写手机或固话";
    self.telephoneField.text = [self.dic objectForKey:@"dianhua"];
    self.telephoneField.delegate = self;
    self.telephoneField.returnKeyType = UIReturnKeyDone;
    self.telephoneField.textColor = [UIColor blackColor];
    self.telephoneField.font = [UIFont systemFontOfSize:labelText];
    self.telephoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.telephoneField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.telephoneField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.scrollView addSubview:self.telephoneField];
    
    
    //横线10
    self.horizontal10 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.telephoneField.frame)+15, ScreenWidth, 0.5)];
    self.horizontal10.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal10];
    
    
    //发布按钮
    self.releaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4,CGRectGetMaxY(self.horizontal10.frame) + 15, ScreenWidth/2, 40)];
    //[self.releaseBtn setBackgroundColor:[UIColor colorWithRed:52/255.0 green:142/255.0 blue:221/255.0 alpha:1]];
    [self.releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.releaseBtn setBackgroundImage:[UIImage imageNamed:@"home_7_btn.png"] forState:UIControlStateNormal];
    [self.releaseBtn setBackgroundImage:[UIImage imageNamed:@"home_7_btn_col.png"] forState:UIControlStateSelected];
    [self.releaseBtn addTarget:self action:@selector(release:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.releaseBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    //    self.releaseBtn.layer.cornerRadius = 20;
    //    self.releaseBtn.layer.masksToBounds = YES;
    
    
    [self.scrollView addSubview:self.releaseBtn];
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.releaseBtn.frame)+15);
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.jsonString1.length==0) {
    }else if(self.jsonString1.length>0){
        if ([self.addeduArrayStr containsObject:self.jsonString1]) {
            
        }else{
            
            if (self.addeduArrayStr.count<=3) {
                [self.addeduArrayStr insertObject:self.jsonString1 atIndex:0];
                
            }else{
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"教育经历最多添加4个" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                self.jsonString1 = nil;
                
            }
            
            NSString* str = [self.addeduArrayStr componentsJoinedByString:@","];
            NSString* string1 = @"[";
            NSString* string2 = @"]";
            self.str1 = [NSString stringWithFormat:@"%@%@%@",string1,str,string2];
            
        }
        
    }
    if (self.jsonString2.length==0) {
        
    }else if(self.jsonString2.length>0){
        if ([self.addworkArrayStr containsObject:self.jsonString2]) {
            
        }else{
            if (self.addworkArrayStr.count<=4) {
                [self.addworkArrayStr insertObject:self.jsonString2 atIndex:0];
                
            }else{
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"工作经历最多添加5个" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                self.jsonString2 = nil;
                
            }
            NSString* str = [self.addworkArrayStr componentsJoinedByString:@","];
            NSString* string1 = @"[";
            NSString* string2 = @"]";
            self.str2 = [NSString stringWithFormat:@"%@%@%@",string1,str,string2];
        }
    }
    
    
    if ([self.mutDic count]==0) {
        
    }else{
        //        [self.addeduArray addObject:self.mutDic];
        if (self.addeduArray.count<=3) {
            [self.addeduArray insertObject:self.mutDic atIndex:0];
        }else{
            
        }
    }
    if ([self.workDic count]==0) {
        
    }else{
        if (self.addworkArray.count<=4) {
            [self.addworkArray insertObject:self.workDic atIndex:0];
        }else{
            
            
        }
    }
    
    [self.scrollView removeFromSuperview];
    [self setup];
    
    
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.mutDic =nil;
    self.workDic = nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==self.tableView) {
        return 2;
    }else
        return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.tableView) {
        if (section==0) {
            return self.addeduArray.count+1;
        }else if (section==1){
            return self.addworkArray.count+1;
            
            
        }
    }else if (tableView==self.tableView1){
        if (self.tag==1) {
            return self.ageArray.count;
        }else if (self.tag==2){
            return self.educationList.count;
            
        }else if (self.tag==3){
            return self.experienceList.count;
            
        }else if (self.tag==4){
            
            return self.positionList.count;
        }else if (self.tag==5){
            
            return self.salaryList.count;
        }
        
        
    }else if (tableView==self.tableView2){
        
//        MbUserInfo* info = [self.positionList objectAtIndex:self.tag1];
//        
//        
//        return info.positionArray.count;
    }
    
    return 0;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifire = @"Cell";
    UITableViewCell* cell = nil;
    if (tableView==self.tableView) {
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
    }else if (tableView==self.tableView1){
        cell = [self.tableView1 cellForRowAtIndexPath:indexPath];
        
    }else if (tableView==self.tableView2){
        
        cell = [self.tableView2 cellForRowAtIndexPath:indexPath];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        
    }
    
    if (tableView==self.tableView) {
        if (indexPath.section==0){
            if (indexPath.row==0) {
                //教育经历
                self.educationExperience = [[UIButton alloc]initWithFrame:CGRectMake(15, 8, ScreenWidth/5*3-20, self.telephone.frame.size.height + 24)];
                [self.educationExperience setBackgroundColor:[UIColor colorWithRed:52/255.0 green:142/255.0 blue:221/255.0 alpha:1]];
                [self.educationExperience setTitle:@"教育经历（选填）" forState:UIControlStateNormal];
                self.educationExperience.titleLabel.font = [UIFont systemFontOfSize:labelText];
                [self.educationExperience addTarget:self action:@selector(addeducation:) forControlEvents:UIControlEventTouchUpInside];
                self.educationExperience.layer.cornerRadius = self.telephone.frame.size.height/2+12;
                self.educationExperience.layer.masksToBounds = YES;
                
                [cell addSubview:self.educationExperience];
            }else if (self.addeduArray.count>0){
                NSDictionary* dic = [self.addeduArray objectAtIndex:indexPath.row-1];
                
                //教育时间
                self.yeartoyear = [UILabel new];
                self.yeartoyear.text = [NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"startTime"],[dic objectForKey:@"endTime"]];
                self.yeartoyear.font = [UIFont systemFontOfSize:labelText];
                self.yeartoyear.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize yeartoyearSize = [self.yeartoyear.text sizeWithFont:self.yeartoyear.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.yeartoyear.frame = CGRectMake(15, 15, yeartoyearSize.width, yeartoyearSize.height);
                [cell addSubview:self.yeartoyear];
                //学校
                self.school = [UILabel new];
                self.school.text = @"学校";
                self.school.font = [UIFont systemFontOfSize:labelText];
                self.school.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize schoolSize = [self.school.text sizeWithFont:self.school.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.school.frame = CGRectMake(15, CGRectGetMaxY(self.yeartoyear.frame)+10, schoolSize.width, schoolSize.height);
                [cell addSubview:self.school];
                
                self.schoolLabel = [UILabel new];
                self.schoolLabel.text = [dic objectForKey:@"school"];
                self.schoolLabel.font = [UIFont systemFontOfSize:labelText];
                self.schoolLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize schoolLabelSize = [self.schoolLabel.text sizeWithFont:self.schoolLabel.font constrainedToSize:CGSizeMake(ScreenWidth - schoolSize.width  - 110, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.schoolLabel.frame = CGRectMake(CGRectGetMaxX(self.school.frame) + 15, CGRectGetMaxY(self.yeartoyear.frame)+10, schoolLabelSize.width, schoolSize.height);
                [cell addSubview:self.schoolLabel];
                //学历
                self.education = [UILabel new];
                self.education.text = @"学历";
                self.education.font = [UIFont systemFontOfSize:labelText];
                self.education.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize educationSize = [self.education.text sizeWithFont:self.education.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.education.frame = CGRectMake(15, CGRectGetMaxY(self.school.frame)+10, educationSize.width, educationSize.height);
                [cell addSubview:self.education];
                
                self.educationLevel = [UILabel new];
                self.educationLevel.text = [dic objectForKey:@"degree"];
                
                self.educationLevel.font = [UIFont systemFontOfSize:labelText];
                self.educationLevel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize educationLevelSize = [self.educationLevel.text sizeWithFont:self.educationLevel.font constrainedToSize:CGSizeMake(ScreenWidth-110-educationSize.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.educationLevel.frame = CGRectMake(CGRectGetMaxX(self.education.frame) + 15, CGRectGetMaxY(self.schoolLabel.frame)+10, educationLevelSize.width, schoolSize.height);
                [cell addSubview:self.educationLevel];
                //专业
                self.professional = [UILabel new];
                self.professional.text = @"专业";
                self.professional.font = [UIFont systemFontOfSize:labelText];
                self.professional.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize professionalSize = [self.professional.text sizeWithFont:self.professional.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.professional.frame = CGRectMake(15, CGRectGetMaxY(self.education.frame)+10, professionalSize.width, professionalSize.height);
                [cell addSubview:self.professional];
                
                self.professionalType = [UILabel new];
                self.professionalType.text = [dic objectForKey:@"professional"];
                self.professionalType.font = [UIFont systemFontOfSize:labelText];
                self.professionalType.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize professionalTypeSize = [self.professionalType.text sizeWithFont:self.professionalType.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.professionalType.frame = CGRectMake(CGRectGetMaxX(self.professional.frame) + 15, CGRectGetMaxY(self.educationLevel.frame)+10, professionalTypeSize.width, professionalTypeSize.height);
                [cell addSubview:self.professionalType];
                
                
                //删除按钮
                self.deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 65, (textSize.height*4+60)/2-10, 50, 20)];
                [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
                [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
                self.deleteBtn.backgroundColor = [UIColor redColor];
                self.deleteBtn.layer.cornerRadius = 4;
                self.deleteBtn.layer.masksToBounds = YES;
                //            self.deleteBtn.layer.borderColor = [UIColor blackColor].CGColor;
                //            self.deleteBtn.layer.borderWidth = 1;
                self.deleteBtn.tag = indexPath.row-1;
                
                [self.deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:self.deleteBtn];
                
            }
            
            
            
            
        }else if (indexPath.section==1){
            if (indexPath.row==0) {
                UILabel* line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
                line.backgroundColor = [UIColor lightGrayColor];
                [cell addSubview:line];
                
                //工作经历
                self.workExperience = [[UIButton alloc]initWithFrame:CGRectMake(15, 8, ScreenWidth/5*3-20, self.telephone.frame.size.height+24)];
                [self.workExperience setBackgroundColor:[UIColor colorWithRed:52/255.0 green:142/255.0 blue:221/255.0 alpha:1]];
                [self.workExperience setTitle:@"工作经历（选填）" forState:UIControlStateNormal];
                self.workExperience.titleLabel.font = [UIFont systemFontOfSize:labelText];
                [self.workExperience addTarget:self action:@selector(addwork:) forControlEvents:UIControlEventTouchUpInside];
                self.workExperience.layer.cornerRadius = self.telephone.frame.size.height/2+12;
                self.workExperience.layer.masksToBounds = YES;
                
                [cell addSubview:self.workExperience];
                
            }else if (self.addworkArray.count>0){
                NSDictionary* dic = [self.addworkArray objectAtIndex:indexPath.row-1];
                //工作时间
                self.worktoyear = [UILabel new];
                self.worktoyear.text = [NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"startTime"],[dic objectForKey:@"endTime"]];
                self.worktoyear.font = [UIFont systemFontOfSize:labelText];
                self.worktoyear.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize worktoyearSize = [self.worktoyear.text sizeWithFont:self.worktoyear.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.worktoyear.frame = CGRectMake(15, 15, worktoyearSize.width, worktoyearSize.height);
                [cell addSubview:self.worktoyear];
                //公司
                self.company = [UILabel new];
                self.company.text = @"公司";
                self.company.font = [UIFont systemFontOfSize:labelText];
                self.company.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize companySize = [self.company.text sizeWithFont:self.company.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.company.frame = CGRectMake(15, CGRectGetMaxY(self.worktoyear.frame)+10, companySize.width, companySize.height);
                [cell addSubview:self.company];
                
                self.companyLabel = [UILabel new];
                self.companyLabel.text = [dic objectForKey:@"company"];
                self.companyLabel.font = [UIFont systemFontOfSize:labelText];
                self.companyLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize companyLabelSize = [self.companyLabel.text sizeWithFont:self.companyLabel.font constrainedToSize:CGSizeMake(ScreenWidth - companySize.width - 110, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.companyLabel.frame = CGRectMake(CGRectGetMaxX(self.company.frame) + 15, CGRectGetMaxY(self.worktoyear.frame)+10, companyLabelSize.width, companySize.height);
                [cell addSubview:self.companyLabel];
                //职位
                self.type = [UILabel new];
                self.type.text = @"职位";
                self.type.font = [UIFont systemFontOfSize:labelText];
                self.type.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize typeSize = [self.type.text sizeWithFont:self.type.font constrainedToSize:CGSizeMake(ScreenWidth - companySize.width - 110, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.type.frame = CGRectMake(15, CGRectGetMaxY(self.company.frame)+10, typeSize.width, companySize.height);
                [cell addSubview:self.type];
                
                self.typeLabel = [UILabel new];
                self.typeLabel.text = [dic objectForKey:@"position"];
                self.typeLabel.font = [UIFont systemFontOfSize:labelText];
                self.typeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize typeLabelSize = [self.typeLabel.text sizeWithFont:self.typeLabel.font constrainedToSize:CGSizeMake(ScreenWidth - typeSize.width - 45, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.typeLabel.frame = CGRectMake(CGRectGetMaxX(self.type.frame) + 15, CGRectGetMaxY(self.companyLabel.frame)+10, typeLabelSize.width, typeLabelSize.height);
                [cell addSubview:self.typeLabel];
                
                
                //工作内容
                self.workContentLabel = [UILabel new];
                self.workContentLabel.text = @"工作内容";
                self.workContentLabel.font = [UIFont systemFontOfSize:labelText];
                self.workContentLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize workContentLabelSize = [self.workContentLabel.text sizeWithFont:self.workContentLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.workContentLabel.frame = CGRectMake(15, CGRectGetMaxY(self.type.frame)+10, workContentLabelSize.width, workContentLabelSize.height);
                [cell addSubview:self.workContentLabel];
                
                self.workContent = [UILabel new];
                
                self.workContent.text = [dic objectForKey:@"infor"];
                self.workContent.numberOfLines = 0;
                self.workContent.font = [UIFont systemFontOfSize:labelText];
                self.workContent.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                CGSize workContentSize = [self.workContent.text sizeWithFont:self.workContent.font constrainedToSize:CGSizeMake(ScreenWidth - workContentLabelSize.width - 45, 300) lineBreakMode:NSLineBreakByWordWrapping];
                self.workContent.frame = CGRectMake(CGRectGetMaxX(self.workContentLabel.frame) + 15, CGRectGetMaxY(self.typeLabel.frame)+10, workContentSize.width, workContentSize.height);
                [cell addSubview:self.workContent];
                
                
                //删除按钮
                self.deleteBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 65, (textSize.height*4+60)/2-10, 50, 20)];
                [self.deleteBtn1 setTitle:@"删除" forState:UIControlStateNormal];
                [self.deleteBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.deleteBtn1.titleLabel.font = [UIFont systemFontOfSize:labelText];
                self.deleteBtn1.backgroundColor = [UIColor redColor];
                self.deleteBtn1.layer.cornerRadius = 4;
                self.deleteBtn1.layer.masksToBounds = YES;
                //            self.deleteBtn.layer.borderColor = [UIColor blackColor].CGColor;
                //            self.deleteBtn.layer.borderWidth = 1;
                self.deleteBtn1.tag = indexPath.row-1;
                
                [self.deleteBtn1 addTarget:self action:@selector(delete1:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:self.deleteBtn1];
                
            }
            
        }
    }else if (tableView==self.tableView1){
        if (self.tag==1) {
            cell.textLabel.text = [self.ageArray objectAtIndex:indexPath.row];
            
        }else if (self.tag==2){
            HZPlaceModel* info = [self.educationList objectAtIndex:indexPath.row];
            cell.textLabel.text = info.diploma;
            
            
        }else if (self.tag==3){
            HZPlaceModel* info = [self.experienceList objectAtIndex:indexPath.row];
            cell.textLabel.text = info.suffer;
            
            
        }else if (self.tag==4){
            HZPlaceModel* info = [self.positionList objectAtIndex:indexPath.row];
            cell.textLabel.text = info.positioname;
            
        }else if (self.tag==5){
            HZPlaceModel* info = [self.salaryList objectAtIndex:indexPath.row];
            cell.textLabel.text = info.pay;
            
        }
        
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (tableView==self.tableView2){
        cell = [self.tableView2 cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        }
        
//        MbUserInfo* info = [self.positionList objectAtIndex:self.tag1];
//        NSDictionary* dic = [info.positionArray objectAtIndex:indexPath.row];
//        cell.textLabel.text = [dic objectForKey:@"positioname"];
//        
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.textLabel.font = [UIFont systemFontOfSize:labelText];
        
        
    }
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:labelText];
    
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                return textSize.height+40;
            }else
                return textSize.height*4+60;
            
            
        }else if (indexPath.section==1){
            if (indexPath.row==0) {
                return textSize.height+40;
            }else
                return textSize.height*4+60;
            
        }
    }else{
        return 44;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.000001;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.000000001;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView==self.tableView1){
        if (self.tag==1) {
            
            NSString* string = [self.ageArray objectAtIndex:indexPath.row];
            [self.ageBtn setTitle:string forState:UIControlStateNormal];
            [self.ageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }else if (self.tag==2){
            HZPlaceModel* info = [self.educationList objectAtIndex:indexPath.row];
            [self.educationBtn setTitle:info.diploma forState:UIControlStateNormal];
            [self.educationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else if (self.tag==3){
            HZPlaceModel* info = [self.experienceList objectAtIndex:indexPath.row];
            [self.yearsBtn setTitle:info.suffer forState:UIControlStateNormal];
            [self.yearsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }else if (self.tag==4){
            
            self.tag1 = indexPath.row;
            
            self.btn1.hidden = YES;
            [self create];
            
        }else if (self.tag==5){
            
            HZPlaceModel* info = [self.salaryList objectAtIndex:indexPath.row];
            [self.moneyBtn setTitle:info.pay forState:UIControlStateNormal];
            [self.moneyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        self.btn1.hidden = YES;
        
    }else if (tableView==self.tableView2){
        
        HZPlaceModel* info = [self.positionList objectAtIndex:self.tag1];
//        NSDictionary* dic = [info.positionArray objectAtIndex:indexPath.row];
//        
//        NSString* string = [dic objectForKey:@"positioname"];
//        [self.typeBtn setTitle:string forState:UIControlStateNormal];
//        [self.typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        
//        [self.btn2 removeFromSuperview];
    }
    
    self.tableView.scrollEnabled = YES;
    
}


-(void)create{
    [self requestPlace];
    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //图层透明，控件不透明
    UIColor *color = [UIColor blackColor];
    self.btn2.backgroundColor = [color colorWithAlphaComponent:0.5];
    //    self.view1.backgroundColor = [UIColor blackColor];
    //    self.view1.alpha = 0.7;
    self.btn2.userInteractionEnabled = YES;
    [self.btn2 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn2];
    
    
    //标题
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"职位类别";
    self.titleLabel.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.frame = CGRectMake(15, (ScreenHeight - 344)/2, ScreenWidth - 30, 40);
    [self.btn2 addSubview:self.titleLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 0, 0)];
    [button setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [button sizeToFit];
    
    button.frame = CGRectMake(20, CGRectGetMinY(self.titleLabel.frame) + 5, 30, 30);
    [button addTarget:self action:@selector(dismissBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addSubview:button];
    //列表
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), ScreenWidth - 30, 240)];
    self.tableView2.dataSource = self;
    self.tableView2.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView2 reloadData];
    [self.btn2 addSubview:self.tableView2];
    
}

-(void)dismissBtn2{
    [self.btn2 removeFromSuperview];
    self.btn1.hidden = NO;
}


//添加教育经历
-(void)addeducation:(UIButton*)sender{
    //自我介绍
    //if (self.titleDetail.text.length!=0) {
    [self.dic setObject:self.titleDetail.text forKey:@"jieshao"];
    //姓名
    //}else if (self.name.text.length!=0){
    
    
    
    [self.dic setObject:self.name.text forKey:@"xingming"];
    //年龄
    //}else if (self.ageBtn.currentTitle.length!=0){
    
    [self.dic setObject:self.ageBtn.titleLabel.text forKey:@"nianling"];
    //学历
    //}else if (self.educationBtn.titleLabel.text.length!=0){
    [self.dic setObject:self.educationBtn.titleLabel.text forKey:@"xueli"];
    //工作经验
    //}else if (self.yearsBtn.titleLabel.text.length!=0){
    [self.dic setObject:self.yearsBtn.titleLabel.text forKey:@"jingyan"];
    //职位
    //}else if (self.typeBtn.titleLabel.text.length!=0){
    [self.dic setObject:self.typeBtn.titleLabel.text forKey:@"zhiwei"];
    //薪资
    //}else if (self.moneyBtn.titleLabel.text.length!=0){
    [self.dic setObject:self.moneyBtn.titleLabel.text forKey:@"xinzi"];
    //电话
    //}else if (self.telephoneField.text.length!=0){
    [self.dic setObject:self.telephoneField.text forKey:@"dianhua"];
    //详细介绍
    //}else if (self.introduction.text.length!=0){
    [self.dic setObject:self.introduction.text forKey:@"xiangxijieshao"];
    
    //}
    
    
    self.edVC = [[HZEducationalExperienceViewController alloc]init];
//    self.edVC.resumeVC = self;
    [self presentVC:self.edVC];
}
//添加工作经历
-(void)addwork:(UIButton*)sender{
    
    //自我介绍
    //if (self.titleDetail.text.length!=0) {
    [self.dic setObject:self.titleDetail.text forKey:@"jieshao"];
    //姓名
    //}else if (self.name.text.length!=0){
    [self.dic setObject:self.name.text forKey:@"xingming"];
    //年龄
    //}else if (self.ageBtn.titleLabel.text.length!=0){
    [self.dic setObject:self.ageBtn.titleLabel.text forKey:@"nianling"];
    //学历
    //}else if (self.educationBtn.titleLabel.text.length!=0){
    [self.dic setObject:self.educationBtn.titleLabel.text forKey:@"xueli"];
    //工作经验
    //}else if (self.yearsBtn.titleLabel.text.length!=0){
    [self.dic setObject:self.yearsBtn.titleLabel.text forKey:@"jingyan"];
    //职位
    //}else if (self.typeBtn.titleLabel.text.length!=0){
    [self.dic setObject:self.typeBtn.titleLabel.text forKey:@"zhiwei"];
    //薪资
    //}else if (self.moneyBtn.titleLabel.text.length!=0){
    [self.dic setObject:self.moneyBtn.titleLabel.text forKey:@"xinzi"];
    //电话
    //}else if (self.telephoneField.text.length!=0){
    [self.dic setObject:self.telephoneField.text forKey:@"dianhua"];
    //详细介绍
    //}else if (self.introduction.text.length!=0){
    [self.dic setObject:self.introduction.text forKey:@"xiangxijieshao"];
    
    //}
    
//    self.workVC = [[HZWorkExperienceViewController alloc]init];
//    self.workVC.resumeVC = self;
//    [self.navigationController pushViewController:self.workVC animated:YES];
}


//发布
-(void)release:(UIButton*)sender{
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag = 200;
        [alertView show];
    }else if(self.titleDetail.text.length==0||self.name.text.length==0||!self.sexing||self.educationBtn.titleLabel.text.length==0||self.yearsBtn.titleLabel.text.length==0||self.typeBtn.titleLabel.text.length==0||self.moneyBtn.titleLabel.text.length==0||self.telephoneField.text.length==0||self.introduction.text.length==0){
        
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }else if (self.titleDetail.text.length>10||self.name.text.length>6||self.introduction.text.length>100){
        if (self.titleDetail.text.length>10) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"自我介绍字数不能大于10" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else if (self.name.text.length>6){
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"姓名字数不能大于6" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else if (self.introduction.text.length>100){
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"详细介绍字数不能大于100" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
    }else{
        
        
        int age = [self.ageBtn.titleLabel.text intValue];
        
        
//        [MbPaser sendResumeInformationByUserid:self.userid area:self.cityName introduces:self.titleDetail.text name:self.name.text sex:self.sexing age:age education:self.educationBtn.titleLabel.text experience:self.yearsBtn.titleLabel.text position:self.typeBtn.titleLabel.text salary:self.moneyBtn.titleLabel.text telephone:self.telephoneField.text addeduArray:self.str1 addworkArray:self.str2 jieshao:self.introduction.text result:^(ResumeSaveResponse *response, NSError *error) {
//            
//            self.str = [NSString stringWithFormat:@"%d",response.turn];
//            
//            if (response.turn == 200) {
//                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//            }else{
//                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//                
//            }
//            
//        }];
    }
}

//取消
-(void)cancle:(UIButton*)sender{
    [self.btn1 removeFromSuperview];
    
    
}
//确定
-(void)sure:(UIButton*)sender{
    [self.btn1 removeFromSuperview];
    
}
//向下箭头
-(void)down:(UIButton*)sender{
    
    self.tag = sender.tag;
    
    HZEditType type = sender.tag - 1000;
    //标题
    self.titleLabel = [[UILabel alloc]init];
    if (type == 1) {
        self.selectionController.label.text = @"年龄";
        
    }else if (type ==2){
        self.selectionController.label.text = @"学历";
        
    }else if (type ==3){
        self.selectionController.label.text = @"工作经验";
        
    }else if (type ==4){
        self.selectionController.label.text = @"意向职位";
        
    }else if (type==5){
        self.selectionController.label.text = @"期望薪资";
        
    }
    self.selectionController.type = type;
    [self.selectionController.tableView reloadData];
    self.selectionController.view.hidden = NO;
    [self.view resignFirstResponder];
    
    
}
//男
-(void)man:(UIButton*)sender{
    self.sexing=1;
    if (sender.selected==YES) {
        self.manBtn.selected = YES;
        
    }else{
        sender.selected = !sender.selected;
        self.womenBtn.selected = !self.womenBtn.selected;
    }
}
//女
-(void)woman:(UIButton*)sender{
    self.sexing=2;
    if (sender.selected==YES) {
        self.womenBtn.selected = YES;
        
    }else{
        sender.selected = !sender.selected;
        self.manBtn.selected = !self.manBtn.selected;
    }
}

-(void)btn1:(UIButton*)sender{
    [self.btn1 removeFromSuperview];
    self.tableView.scrollEnabled = YES;
}
-(void)btn2:(UIButton*)sender{
    [self.btn2 removeFromSuperview];
    self.tableView.scrollEnabled = YES;
}

-(void)delete:(UIButton*)sender{
    
    self.deleteTag = sender.tag+1;
    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除这条数据" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
    
}

-(void)delete1:(UIButton*)sender{
    
    self.deleteTag1 = sender.tag+1;
    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除这条数据" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex==1) {
        if (self.deleteTag!=0) {
            [self.addeduArray removeObjectAtIndex:self.deleteTag-1];//移除数据源的数据
            [self.addeduArrayStr removeObjectAtIndex:self.deleteTag-1];
        }else if (self.deleteTag1!=0){
            
            [self.addworkArray removeObjectAtIndex:self.deleteTag1-1];//移除数据源的数据
            [self.addworkArrayStr removeObjectAtIndex:self.deleteTag1-1];
        }
        self.deleteTag = 0;
        self.deleteTag1 = 0;
        [self.scrollView removeFromSuperview];
        [self setup];
    }else if (buttonIndex==0){
        if ([self.str isEqualToString:@"200"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
        
        
    }
    
    
    
}

#pragma mark 触摸屏幕回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark textfield收起键盘方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.titleDetail isEditing]||[self.name isEditing]) {
        
    }else{
        
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.20];
        [UIView setAnimationBeginsFromCurrentState: YES];
        self.scrollView.frame = CGRectMake(self.view.frame.origin.x, self.scrollView.frame.origin.y - 216, self.scrollView.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}
#pragma mark 编辑之后frame弹回
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    if (self.scrollView.frame.origin.y!=0) {
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.20];
        [UIView setAnimationBeginsFromCurrentState: YES];
        self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y + 216, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [UIView commitAnimations];
    }
    
    
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    [self.introduction resignFirstResponder];
    [self.telephoneField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==self.telephoneField) {
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




@end
