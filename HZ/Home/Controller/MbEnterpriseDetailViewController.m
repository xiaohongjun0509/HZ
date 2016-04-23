//
//  MbEnterpriseDetailViewController.m
//  Recruitment
//
//  Created by tusm on 15/11/3.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbEnterpriseDetailViewController.h"

@interface MbEnterpriseDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    CGSize textSize;
    CGSize textSize1;
    
}
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UILabel* companyName;          //公司名称
@property(nonatomic,strong)UILabel* dateLabel;            //日期
@property(nonatomic,strong)UILabel* qualifications;       //资质

@property(nonatomic,strong)UILabel* region;               //区域
@property(nonatomic,strong)UILabel* regionLabel;
@property(nonatomic,strong)UILabel* place;                //地点
@property(nonatomic,strong)UILabel* workplace;            //工作地点
@property(nonatomic,strong)UILabel* details;              //描述
@property(nonatomic,strong)UILabel* detailsIntroduction;  //具体描述
@property(nonatomic,strong)UILabel* contactPerson;        //联系人
@property(nonatomic,strong)UILabel* name;                 //姓名
@property(nonatomic,strong)UILabel* telephone;            //电话
@property(nonatomic,strong)UILabel* telephoneNumber;      //电话号码
@property(nonatomic,strong)UIButton* releaseBtn;          //发布按钮

@property(nonatomic,strong)UILabel* line1;
@property(nonatomic,strong)UILabel* line2;
@property(nonatomic,strong)UILabel* line3;
@property(nonatomic,strong)UILabel* line4;
@property(nonatomic,strong)UILabel* line5;
@property(nonatomic,strong)UILabel* line6;
@property(nonatomic,strong)UILabel* horizontal1;          //横线1
@property(nonatomic,strong)UILabel* horizontal2;
@property(nonatomic,strong)UILabel* horizontal3;
@property(nonatomic,strong)UILabel* horizontal4;
@property(nonatomic,strong)UILabel* horizontal5;
@property(nonatomic,strong)UILabel* horizontal6;
@property(nonatomic,strong)UILabel* horizontal7;
@property(nonatomic,strong)UILabel* horizontal8;
@property(nonatomic,strong)UILabel* text;
@property(nonatomic,strong)UISearchBar* searchBar;        //搜索框
@property(nonatomic,strong)UILabel* shizheng;             //市政
@property(nonatomic,strong)NSString* userid;
@property(nonatomic,strong)NSArray* array;
@property(nonatomic,strong)UIButton* btn;
@property(nonatomic,strong)UIScrollView* scrollView;
@end

@implementation MbEnterpriseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业详情(北京)";
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = @[@"钢结构钢一",@"钢结构钢二"];
    self.userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    self.text = [UILabel new];
    self.text.text = @"测试详情";
    self.text.font = [UIFont systemFontOfSize:labelText];
    textSize = [self.text.text sizeWithFont:self.text.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.detailsIntroduction = [[UILabel alloc]init];
    self.detailsIntroduction.text = self.info.tedail;
    self.detailsIntroduction.font = [UIFont systemFontOfSize:labelText];
    textSize1 = [self.detailsIntroduction.text sizeWithFont:self.detailsIntroduction.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    [self initWithScrollView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    self.navigationController.navigationBarHidden = NO;
    [self judgethree];
    
}
-(void)initWithScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-64)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    
    //公司名称
    self.companyName = [[UILabel alloc]init];
    self.companyName.text = self.info.company;
    self.companyName.numberOfLines=0;
    self.companyName.font = [UIFont systemFontOfSize:labelText+2];
    CGSize companySize = [self.companyName.text sizeWithFont:self.companyName.font constrainedToSize:CGSizeMake(viewWidth-30, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.companyName.frame = CGRectMake(15, 15, companySize.width, companySize.height);
    [self.scrollView addSubview:self.companyName];
    
    
    
    //日期
    self.dateLabel = [[UILabel alloc]init];
    NSTimeInterval time=[self.info.comtime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    self.dateLabel.text = [NSString stringWithFormat:@"%@更新",currentDateStr];
    self.dateLabel.font = [UIFont systemFontOfSize:labelText-1];
    self.dateLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    CGSize dateSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.dateLabel.frame = CGRectMake(15, CGRectGetMaxY(self.companyName.frame)+10, dateSize.width, dateSize.height);
    [self.scrollView addSubview:self.dateLabel];
    
    //横线1
    self.horizontal1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dateLabel.frame)+15, viewWidth, 1)];
    self.horizontal1.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.horizontal1];
    
    //资质
    self.qualifications = [[UILabel alloc]init];
    self.qualifications.text = @"资质";
    self.qualifications.textAlignment = NSTextAlignmentRight;
    self.qualifications.font = [UIFont systemFontOfSize:labelText];
    self.qualifications.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    
    self.qualifications.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal1.frame)+13, textSize.width, textSize.height);
    [self.scrollView addSubview:self.qualifications];
    
    
    
    //按钮循环
    if (self.info.intelligence.count>0) {
        for (int i = 0; i<self.info.intelligence.count; i++) {
            self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
            
            [self.btn setTitle:[self.info.intelligence[i] objectForKey:@"aptitude"] forState:UIControlStateNormal];
            [self.btn setTitleColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1] forState:UIControlStateNormal];
            NSDictionary *attributes = nil;
            if (viewWidth==320) {
                self.btn.titleLabel.font = [UIFont systemFontOfSize:labelText-3];
                attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:labelText-3]};
            }else{
                self.btn.titleLabel.font = [UIFont systemFontOfSize:labelText-4];
                attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:labelText-4]};
            }
            
            //根据计算文字的大小
            
            
            CGFloat length = [[self.info.intelligence[i] objectForKey:@"aptitude"] boundingRectWithSize:CGSizeMake(viewWidth-self.qualifications.frame.size.width-45, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            
            
            
            CGFloat heigth = [[self.info.intelligence[i] objectForKey:@"aptitude"] boundingRectWithSize:CGSizeMake(viewWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
            
            self.btn.frame = CGRectMake(CGRectGetMaxX(self.qualifications.frame) + 21, CGRectGetMaxY(self.horizontal1.frame)+15 + (heigth+10)*i, length, heigth);
            [self.scrollView addSubview:self.btn];
        }
        
    }
    
    //竖线1
    CGFloat h = 30;
    if(self.info.intelligence == nil){
        
    }else{
      h = CGRectGetMaxY(self.btn.frame)-CGRectGetMaxY(self.horizontal1.frame)-5;
    }
    
    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.qualifications.frame)+10,CGRectGetMaxY(self.horizontal1.frame) + 10, 1,h)];
    self.line1.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line1];
    
  
    
    
    //横线2
    CGFloat y = 0;
    if(self.btn == nil){
        y = CGRectGetMaxY(self.horizontal1.frame) + 44;
    }else{
        y = CGRectGetMaxY(self.btn.frame)+15;
    }
    self.horizontal2 = [[UILabel alloc]initWithFrame:CGRectMake(0, y, viewWidth, 1)];
    self.horizontal2.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.horizontal2];
    
    //区域
    self.region = [[UILabel alloc]init];
    self.region.text = @"       区域";
    self.region.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.region.font = [UIFont systemFontOfSize:labelText];
    CGSize regionSize = [self.region.text sizeWithFont:self.region.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.region.frame = CGRectMake(15,CGRectGetMaxY(self.horizontal2.frame) + 15, regionSize.width, regionSize.height);
    [self.scrollView addSubview:self.region];
    
    self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.region.frame)+10,CGRectGetMaxY(self.horizontal2.frame) + 10, 1, self.region.frame.size.height+10)];
    self.line2.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line2];
    
    self.regionLabel = [[UILabel alloc]init];
    self.regionLabel.text = self.info.area;
    self.regionLabel.font = [UIFont systemFontOfSize:labelText];
    self.regionLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.regionLabel.frame = CGRectMake(CGRectGetMaxX(self.line2.frame)+15,CGRectGetMaxY(self.horizontal2.frame) + 15, viewWidth-61-regionSize.width, regionSize.height);
    [self.scrollView addSubview:self.regionLabel];
    
    
    //横线3
    self.horizontal3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.region.frame)+15, viewWidth, 1)];
    self.horizontal3.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.horizontal3];
    
    
    
    
    //办公地址
    self.workplace = [[UILabel alloc]init];
    self.workplace.text = @"办公地址";
    self.workplace.font = [UIFont systemFontOfSize:labelText];
    self.workplace.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    
    self.workplace.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal3.frame) + 15, textSize.width, textSize.height);
    [self.scrollView addSubview:self.workplace];
    //竖线3
    self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.workplace.frame)+10,CGRectGetMaxY(self.horizontal3.frame) + 10, 1, textSize.height+10)];
    self.line3.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line3];
    
    //地址
    self.place = [[UILabel alloc]init];
    self.place.text = self.info.address;
    
    self.place.font = [UIFont systemFontOfSize:labelText];
    self.place.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    CGSize placeSize = [self.place.text sizeWithFont:self.place.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.place.frame = CGRectMake(CGRectGetMaxX(self.line2.frame)+10,CGRectGetMaxY(self.horizontal3.frame) + 15, placeSize.width, textSize.height);
    [self.scrollView addSubview:self.place];
    //横线4
    self.horizontal4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.workplace.frame)+15, viewWidth, 1)];
    self.horizontal4.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.scrollView addSubview:self.horizontal4];
    
    
    //详情介绍
    self.details = [[UILabel alloc]init];
    self.details.text = @"详情介绍";
    self.details.font = [UIFont systemFontOfSize:labelText];
    self.details.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    CGSize detailsSize = [self.details.text sizeWithFont:self.details.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.details.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal4.frame)+15, detailsSize.width, detailsSize.height);
    [self.scrollView addSubview:self.details];
    //竖线4
    self.line4 = [[UILabel alloc]init];
    
    
    //具体描述
    self.detailsIntroduction = [[UILabel alloc]init];
    self.detailsIntroduction.text = self.info.tedail;
    self.detailsIntroduction.numberOfLines = 0;
    self.detailsIntroduction.font = [UIFont systemFontOfSize:labelText];
    self.detailsIntroduction.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    CGSize detailsIntroductionSize = [self.detailsIntroduction.text sizeWithFont:self.detailsIntroduction.font constrainedToSize:CGSizeMake(viewWidth-51-detailsSize.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    if (detailsIntroductionSize.height>detailsSize.height+30) {
        self.line4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.details.frame)+10, CGRectGetMaxY(self.horizontal4.frame) + 10, 1, detailsIntroductionSize.height-15)];
    }else{
        
        self.line4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.details.frame)+10, CGRectGetMaxY(self.horizontal4.frame) + 10, 1, detailsIntroductionSize.height+10)];
    }
    
    self.line4.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line4];
    self.detailsIntroduction.frame = CGRectMake(CGRectGetMaxX(self.line4.frame)+10, CGRectGetMaxY(self.horizontal4.frame) + 15, textSize1.width, textSize1.height);
    [self.scrollView addSubview:self.detailsIntroduction];
    
    
    //横线5
    self.horizontal5 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.detailsIntroduction.frame)+15, viewWidth, 1)];
    self.horizontal5.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.horizontal5];
    
    
    //联系人
    self.contactPerson = [[UILabel alloc]init];
    self.contactPerson.text = @"联系人";
    self.contactPerson.font = [UIFont systemFontOfSize:labelText];
    self.contactPerson.textAlignment = NSTextAlignmentRight;
    self.contactPerson.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    
    self.contactPerson.frame = CGRectMake(15,CGRectGetMaxY(self.horizontal5.frame) + 15, textSize.width, textSize.height);
    [self.scrollView addSubview:self.contactPerson];
    //竖线5
    self.line5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contactPerson.frame)+10,CGRectGetMaxY(self.horizontal5.frame) + 10, 1, textSize.height+10)];
    self.line5.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.line5];
    
    //名字
    self.name = [[UILabel alloc]init];
    self.name.text = self.info.contact;
    self.name.font = [UIFont systemFontOfSize:labelText];
    self.name.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    CGSize nameSize = [self.name.text sizeWithFont:self.name.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.name.frame = CGRectMake(CGRectGetMaxX(self.line5.frame)+10,CGRectGetMaxY(self.horizontal5.frame) + 15, nameSize.width, nameSize.height);
    [self.scrollView addSubview:self.name];
    
    //横线6
    self.horizontal6 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contactPerson.frame)+15, viewWidth, 1)];
    self.horizontal6.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    [self.scrollView addSubview:self.horizontal6];
    
    //电话
//    self.telephone = [[UILabel alloc]init];
//    self.telephone.text = @"电话";
//    self.telephone.font = [UIFont systemFontOfSize:labelText];
//    self.telephone.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
//    self.telephone.textAlignment = NSTextAlignmentRight;
//    self.telephone.frame = CGRectMake(15,CGRectGetMaxY(self.horizontal6.frame) + 15, textSize.width, textSize.height);
//    [self.scrollView addSubview:self.telephone];
    //竖线6
//    self.line6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.workplace.frame)+10,CGRectGetMaxY(self.horizontal6.frame) + 10, 1, textSize.height+10)];
//    self.line6.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
//    [self.scrollView addSubview:self.line6];
    
    //号码
//    self.telephoneNumber = [[UILabel alloc]init];
//    self.telephoneNumber.text = self.info.phone;
//    self.telephoneNumber.font = [UIFont systemFontOfSize:labelText];
//    self.telephoneNumber.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//    
//    CGSize telephoneNumberSize = [self.telephoneNumber.text sizeWithFont:self.telephoneNumber.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
//    self.telephoneNumber.frame = CGRectMake(CGRectGetMaxX(self.line6.frame)+10,CGRectGetMaxY(self.horizontal6.frame) + 15, telephoneNumberSize.width, telephoneNumberSize.height);
//    [self.scrollView addSubview:self.telephoneNumber];
    
    //横线7
//    self.horizontal7 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.telephone.frame)+15, viewWidth, 1)];
//    self.horizontal7.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
//    [self.scrollView addSubview:self.horizontal7];
    
    
    //发布
    

    self.releaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/3,CGRectGetMaxY(self.horizontal6.frame) + 10, viewWidth/3, 30)];
    [self.releaseBtn setTitle:@"洽谈合作" forState:UIControlStateNormal];
    self.releaseBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.releaseBtn setBackgroundColor:[UIColor colorWithRed:0 green:193/255.0 blue:90/255.0 alpha:1]];
    self.releaseBtn.layer.cornerRadius = 15;
    self.releaseBtn.layer.masksToBounds = YES;
    [self.releaseBtn addTarget:self action:@selector(releaseB:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.releaseBtn];
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.releaseBtn.frame)+15);
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"home_icon_call"];
    imageView.frame = CGRectMake(6, 7, 15, 15);
    [self.releaseBtn addSubview:imageView];
    self.releaseBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
}

-(void)judgethree{
    NSString* path = [NSString stringWithFormat:@"%@userid=%@&companyid=%@",judge3,self.userid,self.info.companyid];
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:path];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
    
    NSString* string = [dic objectForKey:@"collectionid"];
    if ([string isEqualToString:@"0"]) {
        UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_co_col.png"] style:UIBarButtonItemStyleDone target:self action:@selector(shoucang)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }else if ([string isEqualToString:@"1"]){
        UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_co_sel_col.png"] style:UIBarButtonItemStyleDone target:self action:@selector(shoucang1)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
}


//收藏按钮
-(void)shoucang{
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        
        
        [MbPaser sendEnterpriseCollectByUserid:self.userid companyid:self.info.companyid result:^(EnterpriseCollectResponse *response, NSError *error) {
            if (response.message) {
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                [self judgethree];
            }
            
        }];
    }
}
//已经收藏
-(void)shoucang1{
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifire = @"Cell";
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
    }
    if (indexPath.row==0) {
        //公司名称
        self.companyName = [[UILabel alloc]init];
        self.companyName.text = self.info.company;
        self.companyName.font = [UIFont systemFontOfSize:labelText+2];
        CGSize companySize = [self.companyName.text sizeWithFont:self.companyName.font constrainedToSize:CGSizeMake(viewWidth-30, 300) lineBreakMode:NSLineBreakByWordWrapping];
        self.companyName.frame = CGRectMake(15, 15, companySize.width, companySize.height);
        [cell addSubview:self.companyName];
        //日期
        self.dateLabel = [[UILabel alloc]init];
        NSTimeInterval time=[self.info.comtime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
        self.dateLabel.text = [NSString stringWithFormat:@"%@更新",currentDateStr];
        self.dateLabel.font = [UIFont systemFontOfSize:labelText-1];
        self.dateLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        CGSize dateSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        self.dateLabel.frame = CGRectMake(15, CGRectGetMaxY(self.companyName.frame)+10, dateSize.width, dateSize.height);
        [cell addSubview:self.dateLabel];
    }else if (indexPath.row==1){
        //资质
        self.qualifications = [[UILabel alloc]init];
        self.qualifications.text = @"资质";
        self.qualifications.textAlignment = NSTextAlignmentRight;
        self.qualifications.font = [UIFont systemFontOfSize:labelText];
        self.qualifications.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        
        self.qualifications.frame = CGRectMake(15, cell.frame.size.height/2-textSize.height/2, textSize.width, textSize.height);
        [cell addSubview:self.qualifications];
        
        
        
        //按钮循环
        
        
        if (self.info.intelligence.count>0) {
            CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
            CGFloat h = 10;//用来控制button距离父视图的高
            for (int i = 0; i < self.info.intelligence.count; i++) {
                self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
                self.btn.tag = 100 + i;
                
                [self.btn setTitleColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1] forState:UIControlStateNormal];
                
                
                NSDictionary *attributes = nil;
                if (viewHeight==480) {
                    self.btn.titleLabel.font = [UIFont systemFontOfSize:labelText-3];
                    attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:labelText-3]};
                }else{
                    self.btn.titleLabel.font = [UIFont systemFontOfSize:labelText-4];
                    attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:labelText-4]};
                }
                
                //根据计算文字的大小
                
                
                CGFloat length = [[self.self.info.intelligence[i] objectForKey:@"aptitude"] boundingRectWithSize:CGSizeMake(viewWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
                
                
                
                CGFloat heigth = [[self.self.info.intelligence[i] objectForKey:@"aptitude"] boundingRectWithSize:CGSizeMake(viewWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
                //为button赋值
                [self.btn setTitle:[self.self.info.intelligence[i] objectForKey:@"aptitude"] forState:UIControlStateNormal];
                //设置button的frame
                
                self.btn.frame = CGRectMake(CGRectGetMaxX(self.qualifications.frame) + w/2+16, /*h*/cell.frame.size.height/2 - heigth/2-2, length + 10 , heigth+4);
                
                //竖线1
                self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.qualifications.frame)+10, 10, 1, self.qualifications.frame.size.height+10)];
                self.line1.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
                [cell addSubview:self.line1];
                
                //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
                if(10 + w + length*i + 45 + self.qualifications.frame.size.width > viewWidth){
                    
                    w = 0; //换行时将w置为0
                    h = h + self.btn.frame.size.height + 10;//距离父视图也变化
                    
                    //CGRectGetMaxY(self.detailName.frame) + 5 + (i/3 * viewWidth/4)
                    
                    self.btn.frame = CGRectMake(CGRectGetMaxX(self.qualifications.frame) + w+16, h, length + 10, heigth+4);//重设button的frame
                    
                    
                    //竖线1
                    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.qualifications.frame)+10, 10, 1, 40)];
                    self.line1.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
                    [cell addSubview:self.line1];
                }
                
                
                w = self.btn.frame.size.width + self.btn.frame.origin.x;
                
                
                
                
                [cell addSubview:self.btn];
            }
        }else{
            //竖线1
            self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.qualifications.frame)+10, 10, 1, self.qualifications.frame.size.height+10)];
            self.line1.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
            [cell addSubview:self.line1];
            
        }
        
        
        
        
        
        
    }else if (indexPath.row==2){
        //办公地址
        self.workplace = [[UILabel alloc]init];
        self.workplace.text = @"办公地址";
        self.workplace.font = [UIFont systemFontOfSize:labelText];
        self.workplace.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        
        self.workplace.frame = CGRectMake(15, 15, textSize.width, textSize.height);
        [cell addSubview:self.workplace];
        //竖线2
        self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.workplace.frame)+10, 10, 1, textSize.height+10)];
        self.line2.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        [cell addSubview:self.line2];
        
        //地址
        self.place = [[UILabel alloc]init];
        self.place.text = self.info.address;
        self.place.font = [UIFont systemFontOfSize:labelText];
        self.place.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        CGSize placeSize = [self.place.text sizeWithFont:self.place.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
        self.place.frame = CGRectMake(CGRectGetMaxX(self.line2.frame)+10, 15, placeSize.width, placeSize.height);
        [cell addSubview:self.place];
        
    }else if (indexPath.row==3){
        //详情介绍
        self.details = [[UILabel alloc]init];
        self.details.text = @"详情介绍";
        self.details.font = [UIFont systemFontOfSize:labelText];
        self.details.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        CGSize detailsSize = [self.details.text sizeWithFont:self.details.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.details.frame = CGRectMake(15, (textSize1.height+30)/2 - detailsSize.height/2, detailsSize.width, detailsSize.height);
        [cell addSubview:self.details];
        //竖线3
        self.line3 = [[UILabel alloc]init];
        
        
        //具体描述
        self.detailsIntroduction = [[UILabel alloc]init];
        self.detailsIntroduction.text = self.info.tedail;
        self.detailsIntroduction.numberOfLines = 0;
        self.detailsIntroduction.font = [UIFont systemFontOfSize:labelText];
        self.detailsIntroduction.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        CGSize detailsIntroductionSize = [self.detailsIntroduction.text sizeWithFont:self.detailsIntroduction.font constrainedToSize:CGSizeMake(viewWidth-51-detailsSize.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
        
        
        if (detailsIntroductionSize.height>detailsSize.height+30) {
            self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.details.frame)+10, 10, 1, detailsIntroductionSize.height-15)];
        }else{
            
            self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.details.frame)+10, 10, 1, detailsIntroductionSize.height+10)];
        }
        
        self.line3.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        [cell addSubview:self.line3];
        self.detailsIntroduction.frame = CGRectMake(CGRectGetMaxX(self.line3.frame)+10, 15, textSize1.width, textSize1.height);
        [cell addSubview:self.detailsIntroduction];
        
    }else if (indexPath.row==4){
        //联系人
        self.contactPerson = [[UILabel alloc]init];
        self.contactPerson.text = @"联系人";
        self.contactPerson.font = [UIFont systemFontOfSize:labelText];
        self.contactPerson.textAlignment = NSTextAlignmentRight;
        self.contactPerson.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        
        self.contactPerson.frame = CGRectMake(15, 15, textSize.width, textSize.height);
        [cell addSubview:self.contactPerson];
        //竖线4
        self.line4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contactPerson.frame)+10, 10, 1, textSize.height+10)];
        self.line4.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        [cell addSubview:self.line4];
        
        //名字
        self.name = [[UILabel alloc]init];
        self.name.text = self.info.contact;
        self.name.font = [UIFont systemFontOfSize:labelText];
        self.name.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        CGSize nameSize = [self.name.text sizeWithFont:self.name.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
        self.name.frame = CGRectMake(CGRectGetMaxX(self.line4.frame)+10, 15, nameSize.width, nameSize.height);
        [cell addSubview:self.name];
        
    }else if (indexPath.row==5){
        
        //电话
        self.telephone = [[UILabel alloc]init];
        self.telephone.text = @"电话";
        self.telephone.font = [UIFont systemFontOfSize:labelText];
        self.telephone.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.telephone.textAlignment = NSTextAlignmentRight;
        self.telephone.frame = CGRectMake(15, 15, textSize.width, textSize.height);
        [cell addSubview:self.telephone];
        //竖线5
        self.line5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.workplace.frame)+10, 10, 1, textSize.height+10)];
        self.line5.backgroundColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        [cell addSubview:self.line5];
        
        //号码
        self.telephoneNumber = [[UILabel alloc]init];
        self.telephoneNumber.text = self.info.phone;
        self.telephoneNumber.font = [UIFont systemFontOfSize:labelText];
        self.telephoneNumber.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        
        CGSize telephoneNumberSize = [self.telephoneNumber.text sizeWithFont:self.telephoneNumber.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
        self.telephoneNumber.frame = CGRectMake(CGRectGetMaxX(self.line5.frame)+10, 15, telephoneNumberSize.width, telephoneNumberSize.height);
        [cell addSubview:self.telephoneNumber];
    }else if (indexPath.row==6){
        //发布
        
        
        self.releaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/4, 10, viewWidth/2, 40)];
        
        
        
        [self.releaseBtn setTitle:@"洽谈合作" forState:UIControlStateNormal];
        self.releaseBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
        [self.releaseBtn setBackgroundColor:[UIColor colorWithRed:0 green:193/255.0 blue:90/255.0 alpha:1]];
        self.releaseBtn.layer.cornerRadius = 20;
        self.releaseBtn.layer.masksToBounds = YES;
        [self.releaseBtn addTarget:self action:@selector(releaseB:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.releaseBtn];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return textSize.height*2+40;
    }else if (indexPath.row==1){
        
        if (self.line1.frame.size.height==textSize.height+10) {
            return textSize.height+30;
        }else{
            
            return 60;
        }
    }else if (indexPath.row==2){
        return textSize.height+30;
    }else if (indexPath.row==3){
        return textSize1.height+30;
        
    }else if (indexPath.row==4){
        return textSize.height+30;
        
    }else if (indexPath.row==5){
        return textSize.height+30;
        
    }else if (indexPath.row==6){
        
        
    }
    
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.00001;
    }else
        return 0.000001;
    
    
}
//洽谈合作
-(void)releaseB:(UIButton*)sender{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.info.phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    }
}
@end
