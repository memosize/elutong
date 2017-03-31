//
//  RescueRecViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/26.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "RescueRecViewController.h"
#import "RescueRecordTableViewCell.h"
#import <AFNetworking.h>
#import "RescueRecord.h"
#import "Record.h"
#import <YYModel.h>
@interface RescueRecViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * recordTB;
    NSMutableArray * recordArr;
    RescueRecord * rescueRecord;
    
}

@end

@implementation RescueRecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initView];
}

- (void)initView
{
    recordTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    recordTB.delegate = self;
    recordTB.dataSource = self;
    [self.view addSubview:recordTB];
}
- (void)initData
{
   
    [self rescuerecord];
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=help&c=api&a=help";
    recordArr = [NSMutableArray array];
    [session GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
        if ([[responseObject valueForKey:@"error"] isEqual:@0]) {
            NSArray * dataArr = [[NSArray alloc] initWithArray:[responseObject valueForKey:@"data"]];
            for (NSDictionary * dic in dataArr) {
                RescueRecord * record = [[RescueRecord alloc] init];
                record.shopName = [dic valueForKey:@"shopName"];
                record.ordertime = [dic valueForKey:@"order_time"];
                record.distance = [[dic valueForKey:@"detail"] valueForKey:@"range"];
                  record.waittime = [[dic valueForKey:@"detail"] valueForKey:@"expect_time"];
                 record.address = [[dic valueForKey:@"detail"] valueForKey:@"address"];
                 record.chargestatus = [dic valueForKey:@"status"];
                   record.maintainer = [[dic valueForKey:@"staff"] valueForKey:@"staff"];
                record.number = [[dic valueForKey:@"staff"] valueForKey:@"mobile"];
                record.maintaincost = [[dic valueForKey:@"price"] valueForKey:@"repair_price"];
                record.sumcost = [[dic valueForKey:@"price"] valueForKey:@"total"];
                record.chargemethod = [dic valueForKey:@"pay_type"];
                record.rescue_id = [dic valueForKey:@"id"];
                [recordArr addObject:record];
            }
            [recordTB reloadData];
           NSLog(@"record = %@",recordArr);

          
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"rescord";
    RescueRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        RescueRecord * res = (RescueRecord *)recordArr[indexPath.row];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RescueRecordTableViewCell" owner:nil options:nil]lastObject];
        cell.rec_shopNameLab.text = res.shopName;
        cell.rec_submitTimeLab.text = res.ordertime;
        cell.rec_disLab.text = res.distance;
//        cell.rec_servicerLab.text = res.maintainer;
//        cell.rec_servicerNumLab.text = res.number;
        cell.rec_sumMoneyLab.text = res.sumcost;
        cell.rec_maintainMoneyLab.text = res.maintaincost;
        cell.rec_estTimeLab.text = res.waittime;
        cell.rec_chargeMothod_Lab.text = res.chargemethod;
        cell.rec_statusLab.text = res.chargestatus;
        cell.rec_addressLab.text = res.address;

    }
    [cell.cancleBtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return recordArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 266;
}
//初始化RescueRecord
- (RescueRecord *)rescuerecord
{
    
    if (rescueRecord == nil) {
        rescueRecord = [[RescueRecord alloc] init];
    }
    return rescueRecord;
}
- (void)cancle:(UIButton *)sender
{
    RescueRecordTableViewCell * resCell = [(RescueRecordTableViewCell *)[sender superview] superview];
    NSIndexPath *resIndex  = [recordTB indexPathForCell:resCell];
    NSInteger resRow = resIndex.row;
    RescueRecord * record = (RescueRecord * )recordArr[resRow];
    NSLog(@"id = %@",record.rescue_id);
    NSDictionary * parm = @{@"id":record.rescue_id};
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=help&c=api&a=cancel";
    [session GET:urlStr parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
        NSLog(@"error = %@",error);
    }];
    
    
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
