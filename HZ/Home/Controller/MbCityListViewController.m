//
//  MbCityListViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/27.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbCityListViewController.h"

#import "ChineseString.h"
#import "MbPaser.h"
#import "MbUserInfo.h"
@interface MbCityListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@property(nonatomic,strong)NSArray* lists;
@property(nonatomic,strong)UITableViewHeaderFooterView* hf;
@property (nonatomic, retain) NSIndexPath* checkedIndexPath;
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)NSArray *resultArray;
@property (nonatomic,strong) NSMutableDictionary *headDic;
@property (nonatomic,strong)NSArray *headArray;

@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;
@property (nonatomic, strong) NSMutableDictionary *cities;
@property (nonatomic,strong)UILabel* line;
@property (nonatomic,strong)NSMutableArray* cityList;    //城市列表
@end

@implementation MbCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    self.view.backgroundColor = [UIColor whiteColor];
    self.arrayHotCity = [NSMutableArray arrayWithObjects:@"北京市",@"天津市",@"青岛市",@"济南市",@"深圳市", nil];
    self.arrayCitys = [NSMutableArray array];
    UISearchBar* searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 10, viewWidth-40, 30)];
//    searchBar.backgroundImage = [UIImage imageNamed:@"home_btn_wh.png"];
    searchBar.placeholder = @"输入城市名或拼音查询";
    searchBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchBar];
    
    self.line = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(searchBar.frame)+2, viewWidth-40, 1)];
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.line];
   
    
    [self getCityList];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, viewWidth, viewHeight-106) style:UITableViewStyleGrouped];
          self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];

    
}
//获取城市列表
-(void)getCityList{
    NSString* path = citylist;
    NSURL* url = [NSURL URLWithString:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
       
        self.cityList = [MbPaser paserCityListByDic:dic];
        for (MbUserInfo* info in self.cityList) {
            [self.arrayCitys addObject:info.name];
            
        }
        self.indexArray = [ChineseString IndexArray:self.self.arrayCitys];
        self.letterResultArr = [ChineseString LetterSortArray:self.self.arrayCitys];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [task resume];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}


#pragma mark -
#pragma mark - UITableViewDataSource

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.letterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

#pragma mark -
#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 10)];
    //lab.backgroundColor = [UIColor grayColor];
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = [UIColor blackColor];
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSArray* array = [self.letterResultArr objectAtIndex:indexPath.section];
   
    NSString* str = [array objectAtIndex:indexPath.row];
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:str forKey:@"cityName"];
    [userDefaults synchronize];
    self.homeVC.cityName = str;
    [self dismissViewControllerAnimated:YES completion:nil];

}




@end
