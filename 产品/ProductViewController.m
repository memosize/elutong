	//
//  ProductViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/21.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "ProductViewController.h"
#import <UIImageView+WebCache.h>
#import "ShopViewController.h"
#import <AFNetworking.h>
#import "proDetailViewController.h"
#import "CommentViewController.h"
@interface ProductViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * itemsNameArr;
}

@end

@implementation ProductViewController
- (void)viewWillAppear:(BOOL)animated
{
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    self.navigationItem.title = @"产品详情";
//    self.navigationItem.backBarButtonItem = nil;
      [self initData];
    NSLog(@"self.sku_id = %@",self.sku_id);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initDataSource];
    [self initView];
}
- (void)initView
{
    self.proTab.delegate = self;
    self.proTab.dataSource = self;
    self.proTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.messageBtn.layer.cornerRadius = 7;
    self.goShopBtn.layer.cornerRadius = 7;
    self.addPur.layer.cornerRadius = 7;
    [self.logImageView sd_setImageWithURL:[NSURL URLWithString:self.proImageUrl]];
    [self.goShopBtn addTarget:self action:@selector(goShop) forControlEvents:UIControlEventTouchUpInside];
    [self.addPur addTarget:self action:@selector(addPurches) forControlEvents:UIControlEventTouchUpInside];
}
- (void)initDataSource
{
    int i  = 10;
    NSString * itemsStr = [NSString stringWithFormat:@"%d条评论",i];
    itemsNameArr = [[NSArray alloc] initWithObjects:@"图文详情",@"评论", nil];
    NSLog(@"%@",itemsNameArr);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"pro";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.text = itemsNameArr[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemsNameArr count];
    
}
- (void)addPurches
{
    
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=order&c=api_cart&a=cart_add";
    NSDictionary * parm = [NSDictionary dictionaryWithObjectsAndKeys:self.sku_id,@"sku_id", nil];
    NSDictionary *params = @{@"sku_id":self.sku_id,@"nums":@"1"};

    [session POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求中");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"res = %@",[responseObject valueForKey:@"data"]);
        if ([[responseObject valueForKey:@"data"]isEqualToString:@"添加购物车成功"])
        {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"添加成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"添加失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}
- (void)initData
{
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=goods_detail";
    NSDictionary * parm = [[NSDictionary alloc] initWithObjectsAndKeys:self.sku_id,@"sku_id", nil];
    [session GET:urlStr parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"请求中。。。");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"res =  %@",responseObject);
        NSString * priceStr  = [responseObject valueForKey:@"prom_price"];
        NSString * stockStr =[responseObject valueForKey:@"spu_total"];
        self.priceLab.text = [NSString stringWithFormat:@"促销价:%@",priceStr];
        self.stockLab.text = [NSString stringWithFormat:@"库存：%@",stockStr];
        self.proContentStr = [responseObject valueForKey:@"content"];
        NSLog(@"self.proContentStr = %@",self.proContentStr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        proDetailViewController * proDetailVC = [[proDetailViewController alloc] initWithNibName:@"proDetailViewController" bundle:nil];
        proDetailVC.contentStr = self.proContentStr;
        [self.navigationController pushViewController:proDetailVC animated:YES];
    }
    else{
        CommentViewController * commentVC = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
        commentVC.sku_id = self.sku_id;
        commentVC.isPro = YES;
        [self.navigationController pushViewController:commentVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)goShop
{
    NSLog(@"self.seller_id = %@",self.seller_id);
    ShopViewController * shopVC = [[ShopViewController alloc] init];
    shopVC.shopId = self.seller_id;
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
