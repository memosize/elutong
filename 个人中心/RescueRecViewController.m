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
@interface RescueRecViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * recordTB;
    NSMutableArray * timeArr;
    NSMutableArray * resAddArr;
    NSMutableArray * destAddArr;
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
    timeArr = [NSMutableArray array];
    resAddArr = [NSMutableArray array];
    destAddArr = [NSMutableArray array];
    timeArr = [NSMutableArray arrayWithObjects:@"17:53 2016-12-31",@"17:53 2016-12-31", nil];
    resAddArr = [NSMutableArray arrayWithObjects:@"高新区环球时代中心3号楼附近",@"高新区环球时代中心3号楼附近", nil];
    destAddArr = [NSMutableArray arrayWithObjects:@"高新区环球时代中心3号楼附近",@"高新区环球时代中心3号楼附近", nil];
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=help&c=api&a=help";
    [session GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"rescord";
    RescueRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RescueRecordTableViewCell" owner:nil options:nil]lastObject];
        cell.rec_disLab.text = @"10";

    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return timeArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 266;
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
