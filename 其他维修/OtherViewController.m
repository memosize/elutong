//
//  OtherViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/21.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "OtherViewController.h"
#import "MaintainTableViewCell.h"
#import "PubDefine.h"
@interface OtherViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * imageArr;
    NSMutableArray * addNameArr;
    NSMutableArray * serNameArr;
    NSMutableArray * telArr;
    UITableView * serveTB;
}

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH , 200)];
    [imageView setImage:[UIImage imageNamed:@"banner4.jpg"]];
    [self.view addSubview:imageView];
    
    serveTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 210, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 100)];
    serveTB.delegate = self;
    serveTB.dataSource = self;
     [self.view addSubview:serveTB];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"maintain";
    MaintainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MaintainTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
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
