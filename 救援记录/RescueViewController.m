//
//  RescueViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/14.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "RescueViewController.h"
#import <AFNetworking.h>
#import "RescueTableViewCell.h"
#import "LoginState.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import <UIImageView+WebCache.h>
#import <MapKit/MapKit.h>
#import "PubDefine.h"
@interface RescueViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UISearchBarDelegate>
{
    UITableView * rescuelistTB;//救援列表
    NSMutableArray * shopNameArray;//店铺名称
    NSMutableArray * positionArray;//位置名称
    NSMutableArray * telNumArray;//电话号码
    UISearchBar * searchbar;
    NSMutableArray * disArr;//距离
    NSMutableArray * iconUrl;
    NSMutableArray * shopIdArr;
    NSMutableArray * lonArr;
    NSMutableArray * latArr;
    
    
}

@end

@implementation RescueViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    if ([LoginState LoginedPerson].isLogin) {
        [self initData];
    }else{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请先登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"nav (5)"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem =    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(375*0.5, 2, 100, 30)];
    searchbar.center = CGPointMake(0.5*SCREEN_WIDTH, 17);
    searchbar.delegate = self;
    searchbar.placeholder = @"搜索店铺";
    [self.navigationController.navigationBar addSubview:searchbar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    [self initView];

}
- (void)initView
{
    rescuelistTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) style:UITableViewStylePlain];
    rescuelistTB.dataSource = self;
    rescuelistTB.delegate =self;
    rescuelistTB.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:rescuelistTB];
}
- (void)initData
{
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=member&c=rescueApi&a=getStoreDis";
    NSDictionary * parm = [[NSDictionary alloc] initWithObjectsAndKeys:@"30.560971",@"lat", @"104.074918",@"lon",nil];
     [session POST:urlStr parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求数据");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response = %@",responseObject);
        disArr = [NSMutableArray array];
        iconUrl = [NSMutableArray array];
        shopNameArray = [NSMutableArray array];
        positionArray  = [NSMutableArray array];
        telNumArray = [NSMutableArray array];
        shopIdArr  = [NSMutableArray array];
        latArr = [NSMutableArray array];
        lonArr = [NSMutableArray array];
    

        [disArr addObject:[responseObject[0] valueForKey:@"distance"]];
        [iconUrl addObject:[responseObject[0] valueForKey:@"avatar"]];
        [shopNameArray addObject:[responseObject[0] valueForKey:@"shopName"]];
        [positionArray addObject:[responseObject[0] valueForKey:@"address"]];
        [telNumArray addObject:[responseObject[0] valueForKey:@"phone"]];
        [lonArr addObject:[responseObject[0] valueForKey:@"lat"]];
        [latArr addObject:[responseObject[0] valueForKey:@"lng"]];
        [shopIdArr addObject:[responseObject[0] valueForKey:@"id"]];
        NSLog(@"positionArr = %@",positionArray);
        NSLog(@"disarr = %@",disArr);
        [rescuelistTB reloadData];
        [self initView];
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"rescue";
    RescueTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RescueTableViewCell" owner:nil options:nil]lastObject];
        cell.chargeLab.layer.cornerRadius = 3;
        cell.chargeLab.layer.borderWidth = 1;
        cell.chargeLab.layer.borderColor = [UIColor colorWithRed:99/255.0 green:161/255.0 blue:70/255.0 alpha:1].CGColor;
        cell.chargeLab.textColor = [UIColor colorWithRed:99/255.0 green:161/255.0 blue:70/255.0 alpha:1];
        cell.elecCarLab.layer.cornerRadius = 3;
        cell.elecCarLab.layer.borderWidth = 1;
        cell.elecCarLab.layer.borderColor = [UIColor colorWithRed:99/255.0 green:161/255.0 blue:70/255.0 alpha:1].CGColor;
        cell.elecCarLab.textColor = [UIColor colorWithRed:99/255.0 green:161/255.0 blue:70/255.0 alpha:1];
        cell.motoBycleLab.layer.cornerRadius = 3;
        cell.motoBycleLab.layer.borderWidth = 1;
//        cell.motoBycleLab.layer.borderColor = [UIColor colorWithRed:99/255.0 green:161/255.0 blue:70/255.0 alpha:1].CGColor;
//        cell.motoBycleLab.textColor = [UIColor colorWithRed:99/255.0 green:161/255.0 blue:70/255.0 alpha:1];
        cell.motoBycleLab.layer.borderColor = [UIColor grayColor].CGColor;
        cell.motoBycleLab.textColor = [UIColor grayColor];
        cell.openLab.layer.cornerRadius = 3;
        cell.openLab.layer.borderWidth = 1;
        cell.openLab.layer.borderColor = [UIColor colorWithRed:99/255.0 green:161/255.0 blue:70/255.0 alpha:1].CGColor;
        cell.openLab.textColor = [UIColor colorWithRed:99/255.0 green:161/255.0 blue:70/255.0 alpha:1];
        [cell.rescueBtn addTarget:self action:@selector(rescue:) forControlEvents:UIControlEventTouchUpInside];
        [cell.navigateBtn addTarget:self action:@selector(navigate:) forControlEvents:UIControlEventTouchUpInside];
        cell.carLab.text = shopNameArray[indexPath.row];
        [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl[indexPath.row]]];
        cell.addLab.text = positionArray[indexPath.row];
        cell.addLab.numberOfLines = 2;
        cell.addLab.font = [UIFont systemFontOfSize:10];
//        cell.addLab.adjustsFontSizeToFitWidth = YES;
        cell.disLab.text = [NSString stringWithFormat:@"距离您%@km",disArr[indexPath.row]];

        cell.numLaB.text = telNumArray[indexPath.row];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [disArr count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 195;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex == 0) {
//        LoginViewController * loginVC = [[LoginViewController alloc] init];
//        [self presentViewController:loginVC animated:YES completion:nil];
//    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    SearchViewController * searchVC = [[SearchViewController alloc] init];
    searchVC.keywordStr = searchBar.text;
    
    [self.navigationController pushViewController:searchVC animated:YES];
    
    [searchBar resignFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [searchbar resignFirstResponder];
}

- (void)rescue:(UIButton *)sender
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的订单正在救援中" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
//    NSLog(@"shopidarr = %@",shopIdArr);
//    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
//    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
//    session.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
//    session.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
//    
//    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=member&c=rescueApi&a=computeMoney";
//    RescueTableViewCell * resCell = [(RescueTableViewCell *)[sender superview] superview];
//    NSIndexPath *resIndex  = [rescuelistTB indexPathForCell:resCell];
//    NSInteger resRow = resIndex.row;
//    NSDictionary * parm = @{@"id":shopIdArr[resRow]};
//    [session GET:urlStr parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//             NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"string = %@",string);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error = %@",error);
//    }];
}
- (void)navigate:(UIButton *)sender
{
        RescueTableViewCell * resCell = [(RescueTableViewCell *)[sender superview] superview];
        NSIndexPath *resIndex  = [rescuelistTB indexPathForCell:resCell];
        NSInteger resRow = resIndex.row;

    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([lonArr[resRow] floatValue], [latArr[resRow] floatValue]);
    
//    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(30.584755,104.069754);
//   104.073264,30.63111
//    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(104.118263, 30.664883);
     CLLocationCoordinate2D form = CLLocationCoordinate2DMake(30.0533811, 101.976814);
    NSLog(@"loc = %f %f",loc.latitude,loc.longitude);
    MKMapItem * currentLoc = [MKMapItem mapItemForCurrentLocation];
    NSLog(@"CURRENT = %f",currentLoc.placemark.coordinate.latitude);
    MKMapItem * toLoc = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
    toLoc.name = [NSString stringWithFormat:@"%@",shopNameArray[resRow]];
     MKMapItem * fromLoc = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:form addressDictionary:nil]];
    [MKMapItem openMapsWithItems:@[currentLoc,toLoc] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES], MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard]}];
//    NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=bd09ll&region=成都",loc.latitude,loc.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString * uu = @"baidumap://map/direction?origin=latlng:39.980195,116.311766|name:当前位置&destination=latlng:39.982258,116.317164|name:中石化中关村加油站 &mode=driving&region=北京";
////NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:104.09184f,30.637728|name:我的位置&destination=latlng:104.079912,30.565987|name:终点&mode=driving"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
//    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [searchbar removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
