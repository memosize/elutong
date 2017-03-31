//
//  EditAddressViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/16.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "EditAddressViewController.h"
#import "EidtAddTableViewCell.h"
#import "YSLnavgationbar.h"
#import "PubDefine.h"
@interface EditAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * letfItemArr;
    NSMutableArray * rightItemArr;
}

@end

@implementation EditAddressViewController
- (void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.navigationBarHidden = YES;
//    YSLnavgationbar  * nav = [[YSLnavgationbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
//    [nav.leftBtn setImage:[UIImage imageNamed:@"nav (7)"] forState:UIControlStateNormal];
//    [nav.rightBtn setImage:[UIImage imageNamed:@"add.jpg"] forState:UIControlStateNormal];
//    [self.view addSubview:nav];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    self.EditAddTB.delegate = self;
    self.EditAddTB.dataSource = self;
}
- (void)initData
{
    letfItemArr = [[NSArray alloc] initWithObjects:@"收货人:",@"联系方式:", @"所在地区:", @"详细地址:", @"邮政编码:",  nil];
    rightItemArr = [[NSMutableArray alloc] initWithObjects:@"张三", @"1898989", @"成都", @"双流天府大道", @"667888", nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"edit";
    EidtAddTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
       cell =  [[[NSBundle mainBundle]loadNibNamed:@"EidtAddTableViewCell" owner:nil options:nil]lastObject];
        cell.nameLab.text = letfItemArr[indexPath.row];
        [cell.addressTF setBorderStyle:UITextBorderStyleNone];
        
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return letfItemArr.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
