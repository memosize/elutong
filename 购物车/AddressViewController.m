//
//  AddressViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/16.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "AddressViewController.h"
#import "PubDefine.h"
#import "AddressTableViewCell.h"
#import "EditAddressViewController.h"
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * addressTB;
}

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    addressTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    addressTB.delegate = self;
    addressTB.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:addressTB];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"address";
    AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AddressTableViewCell" owner:nil options:nil]lastObject];
        cell.nameLab.text = @"张三";
        cell.phoneLab.text = @"17766236237";
        cell.addressLab.text = @"成都市天府二街";
        [cell.editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)edit
{
    EditAddressViewController * editVC = [[EditAddressViewController alloc] initWithNibName:@"EditAddressViewController" bundle:nil];
    [self.navigationController pushViewController:editVC animated:YES];
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
