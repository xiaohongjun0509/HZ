//
//  MbCityListViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/27.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbCityListViewController.h"
#import "HZHotCityCell.h"
#import "ChineseString.h"
#import "MbPaser.h"
#import "MbUserInfo.h"
#import "HZLocationCell.h"
#import <CoreLocation/CoreLocation.h>
@interface MbCityListViewController ()<UITableViewDataSource,UITableViewDelegate, CLLocationManagerDelegate>
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
@property (nonatomic, strong) NSMutableDictionary *cities;
@property (nonatomic,strong)UILabel* line;
@property (nonatomic,strong)NSMutableArray* cityList;    //城市列表
@property (nonatomic, strong) NSArray *hotcity;
@property (nonatomic, strong) CLLocationManager *manager;
@end

@implementation MbCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    self.view.backgroundColor = [UIColor whiteColor];
    self.arrayCitys = [NSMutableArray array];
    [self getCityList];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight) style:UITableViewStyleGrouped];
          self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"HZHotCityCell" bundle:nil] forCellReuseIdentifier:@"HZHotCityCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HZLocationCell" bundle:nil] forCellReuseIdentifier:@"HZLocationCell"];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
    
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.distanceFilter = 10.0f;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8) {
        [self.manager requestWhenInUseAuthorization];
    }
    [self.manager startUpdatingLocation];
    

    
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
        self.indexArray = [ChineseString IndexArray:self.arrayCitys];
        
        self.letterResultArr = [ChineseString LetterSortArray:self.arrayCitys];
        [self.indexArray insertObject:@"定位城市" atIndex:0];
        [self.indexArray insertObject:@"热门城市" atIndex:1];
        
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
    return [self.letterResultArr count] + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < 2) {
        return 1;
    }
    return [[self.letterResultArr objectAtIndex:section - 2] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HZLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZLocationCell"];
        WEAKSELF
        cell.updateCity = ^(NSString *city){
            weakSelf.homeVC.cityName = city;
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        return cell;
    }
    if (indexPath.section == 1) {
        HZHotCityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZHotCityCell"];
        WEAKSELF
        cell.updateCity = ^(NSString *city){
            weakSelf.homeVC.cityName = city;
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        return cell;
    }
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }
    
    cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section - 2]objectAtIndex:indexPath.row];
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
    if (indexPath.section == 1) {
        return 160;
    }
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

    if(indexPath.section > 1){
        NSArray* array = [self.letterResultArr objectAtIndex:indexPath.section];
        NSString* str = [array objectAtIndex:indexPath.row];
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:str forKey:@"cityname"];
        [userDefaults synchronize];
        self.homeVC.cityName = str;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [self.manager stopUpdatingLocation];
    NSLog(@"location ok");
    
    NSLog(@"%@",[NSString stringWithFormat:@"经度:%3.5f\n纬度:%3.5f",newLocation.coordinate.latitude,newLocation.coordinate.longitude]);
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *test = [placemark addressDictionary];
            //  Country(国家)  State(城市)  SubLocality(区)
            NSLog(@"%@", [test objectForKey:@"State"]);
        }
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self.manager stopUpdatingLocation];
    NSLog(@"location ok");
    for(CLLocation *location in locations){
        NSLog(@"---------%@-------",location);
    }
    CLLocation *currLocation=[locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];//反向解析，根据及纬度反向解析出地址
    CLLocation *location = [locations objectAtIndex:0];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for(CLPlacemark *place in placemarks)
        {
            //取出当前位置的坐标
            NSLog(@"latitude : %f,longitude: %f",currLocation.coordinate.latitude,currLocation.coordinate.longitude);
            NSString *latStr = [NSString stringWithFormat:@"%f",currLocation.coordinate.latitude];
            NSString *lngStr = [NSString stringWithFormat:@"%f",currLocation.coordinate.longitude];
            NSDictionary *dict = [place addressDictionary];
            NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
            [resultDic setObject:dict[@"SubLocality"] forKey:@"xian"];
            [resultDic setObject:dict[@"City"] forKey:@"shi"];
            [resultDic setObject:latStr forKey:@"wei"];
            [resultDic setObject:lngStr forKey:@"jing"];
            [resultDic setObject:dict[@"State"] forKey:@"sheng"];
            [resultDic setObject:dict[@"Name"] forKey:@"all"];
            NSLog(@"------addressDictionary-%@------",dict);
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"SubLocality"] forKey:@"XianUser"];
            [[NSUserDefaults standardUserDefaults] setObject:resultDic forKey:@"LocationInfo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];

}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}
@end
