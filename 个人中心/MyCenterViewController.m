//
//  MyCenterViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/20.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "MyCenterViewController.h"
#import "MyCenterTableViewCell.h"
#import "RescueRecViewController.h"
#import "OrderViewController.h"
#import "PubDefine.h"
#import "LoginState.h"
#import <UIImageView+WebCache.h>
@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * imagesArr;
    NSArray * itemsArr;
}
@end

@implementation MyCenterViewController
- (void)viewWillAppear:(BOOL)animated
{
    [self initIcon];
    [self initUsername];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _iconImageView.layer.cornerRadius = 80/2;
    [_iconImageView.layer setMasksToBounds:YES];
    // Do any additional setup after loading the view from its nib.

    [self initDataSource];
   
    
    self.myTab.delegate = self;
    self.myTab.dataSource = self;
    self.myTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_myTab];
    
}
- (void)initIcon
{
    
    if ([LoginState LoginedPerson].iconStr && [LoginState LoginedPerson].isLogin) {
        NSLog(@"initIcon");
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[LoginState LoginedPerson].iconStr]];
    }else{
        [_iconImageView setImage:[UIImage imageNamed:@"mainnav(1)@2x"]];
    }
}
- (void)initUsername
{
    
    if ([LoginState LoginedPerson].nameStr && [LoginState LoginedPerson].isLogin) {
        
        _nameLab.text =  [LoginState LoginedPerson].nameStr;
    }
    else{
        _nameLab.text = @"未登录";
    }
    
}

- (void)initDataSource
{
    imagesArr = [NSMutableArray array];
    itemsArr = [NSArray array];
    for (int i = 0; i < 4; i++) {
        [imagesArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"left-%d@2x",i+1]]];
    }
    itemsArr  = [NSArray arrayWithObjects:@"救援记录", @"我的订单",@"店铺管理",@"分享",nil];
}
#pragma mark -- UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"mycenter";
    MyCenterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyCenterTableViewCell" owner:nil options:nil]lastObject];
        cell.iconImageView.image = imagesArr[indexPath.row];
        cell.itemsLab.text = itemsArr[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemsArr count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            RescueRecViewController * rescVC = [[RescueRecViewController alloc] init];
            [self.navigationController pushViewController:rescVC animated:YES];
            
        }
            break;
            case 1:
        {
            OrderViewController * orderVC = [[OrderViewController alloc] init];
            [self.navigationController pushViewController:orderVC animated:YES];
        }
            break;
            
        default:
            break;
    

    
}
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
