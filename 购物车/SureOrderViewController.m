//
//  SureOrderViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/15.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "SureOrderViewController.h"
#import "PubDefine.h"
#import "YSLSureOrderTableViewCell.h"
@interface SureOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * orderTableView;
}

@end

@implementation SureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) style:UITableViewStylePlain];
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    [self.view addSubview:orderTableView];
    // 创建底部视图
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"order";
    YSLSureOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YSLSureOrderTableViewCell" owner:nil options:nil]lastObject];
        cell.nameLab.text = @"杨森林";
        cell.addressLab.text = @"天府二街";
        cell.phoneLab.text = @"188873232";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;        
       }
     return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91;
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
