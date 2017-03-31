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
#import "AddressViewController.h"
#import "PayMethodTableViewCell.h"
@interface SureOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * payTB;
    UIButton * sureBtn;
    NSArray * payMethodArr;
    NSMutableArray * selectArr;
    
}

@end

@implementation SureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
    _sureOrderTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200) style:UITableViewStylePlain];
    _sureOrderTB.delegate = self;
    _sureOrderTB.dataSource = self;
    [self.view addSubview:_sureOrderTB];
    _sureOrderTB.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    payTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, 200) style:UITableViewStylePlain];
    payTB.editing = YES;
    payTB.delegate = self;
    payTB.dataSource = self;
    [self.view addSubview:payTB];
    

    
}
- (void)initData
{
    payMethodArr = @[@"支付宝",@"微信",@"银联"];
    selectArr = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0", nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"order";
    NSString * cellID2 = @"pay";
    if (tableView == _sureOrderTB) {
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
    else{
        PayMethodTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PayMethodTableViewCell" owner:nil options:nil]lastObject];
            cell.payMethodNameLab.text = payMethodArr[indexPath.row];
         
        }
          return cell;
}

   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _sureOrderTB) {
        return 1;
    }
    else{
        return 3;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _sureOrderTB) {
        return 91;
    }
    else{
        return 57;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _sureOrderTB) {
        AddressViewController * addressVC = [[AddressViewController alloc] init];
        [self.navigationController pushViewController:addressVC animated:YES];
    }
    else{
        NSIndexPath * index1 = [NSIndexPath indexPathForRow:0 inSection:0];
        NSIndexPath * index2 = [NSIndexPath indexPathForRow:1 inSection:0];
        NSIndexPath * index3 = [NSIndexPath indexPathForRow:2 inSection:0];
        PayMethodTableViewCell *cell1 = (PayMethodTableViewCell *)[tableView cellForRowAtIndexPath:index1];
        PayMethodTableViewCell *cell2 = (PayMethodTableViewCell *)[tableView cellForRowAtIndexPath:index2];
        PayMethodTableViewCell *cell3 = (PayMethodTableViewCell *)[tableView cellForRowAtIndexPath:index3];
        NSInteger row = indexPath.row;
        if (row == 0) {
            if (cell1.selected == NO) {
                cell1.selected = YES;
               
            }
            else{
                cell1.selected = YES;
                cell2.selected = NO;
                cell3.selected = NO;
            }
        }
        if (row == 1) {
            if (cell2.selected == NO) {
                cell2.selected = YES;
              
            }
            else{
                cell2.selected = YES;
                cell1.selected = NO;
                cell3.selected = NO;
            }
        }
        if (row == 2) {
            if (cell3.selected == NO) {
                cell3.selected = YES;
             
            }
            else{
                cell3.selected = YES;
                cell2.selected = NO;
                cell1.selected = NO;
            }
        }
        NSLog(@"row = %d",row);
        
        }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sure:(id)sender {
}
@end
