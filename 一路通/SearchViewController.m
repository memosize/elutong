//
//  SearchViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/19.
//  Copyright © 2017年 dasousuo. All rights reserved.
//
// 搜索店铺
#import "SearchViewController.h"
#import "PubDefine.h"
#import <AFNetworking.h>
#import "SrearchOfResInShopTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ShopViewController.h"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * searchTB;
    NSMutableArray * shopIdArr;
    NSMutableArray * shopNameArr;
    NSMutableArray * imageUrlArr;
    NSString * shopId;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
//    [self performSelector:@selector(initView) withObject:self afterDelay:2];
    [self initView];
}
- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    searchTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    searchTB.delegate = self;
    searchTB.dataSource = self;
    searchTB.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:searchTB];
}
- (void)initData
{
    shopIdArr = [NSMutableArray array];
    shopNameArr = [NSMutableArray array];
    imageUrlArr = [NSMutableArray array];
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=search";
    NSLog(@"%@",self.keywordStr);
    NSDictionary * parm = [NSDictionary dictionaryWithObjectsAndKeys:self.keywordStr, @"keyword",nil];
    [session GET:urlStr parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"请求中");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"%@",responseObject);
        NSLog(@"%@",[responseObject valueForKey:@"data"]);
        if (1) {
            NSArray * array = [NSArray arrayWithArray:[[responseObject valueForKey:@"data"]valueForKey:@"seller"]];
            for (int i  = 0; i<array.count; i++) {
                [shopNameArr addObject:[array[i] valueForKey:@"shopName"]];
                [shopIdArr addObject:[array[i] valueForKey:@"id"]];
                [imageUrlArr addObject:[array[i] valueForKey:@"avatar"]];
            }
            [searchTB reloadData];
        }else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"没有这样的店铺！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
       
        NSLog(@"%d",shopNameArr.count);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"shopRes";
    SrearchOfResInShopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SrearchOfResInShopTableViewCell" owner:nil options:nil]lastObject];
        [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlArr[indexPath.row]]];
        cell.shopNameLab.text = shopNameArr[indexPath.row];
        [cell.goShopBtn addTarget:self action:@selector(goshop:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return shopNameArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)goshop:(id)sender
{
    NSInteger myRow = [searchTB indexPathForCell:((SrearchOfResInShopTableViewCell*)[[sender   superview]superview])].row;
    shopId = shopIdArr[myRow];
    ShopViewController * shopVC = [[ShopViewController alloc] init];
    shopVC.shopId = shopId;
    [self.navigationController pushViewController:shopVC animated:YES];
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
