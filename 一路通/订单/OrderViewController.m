//
//  OrderViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/7.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "OrderViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "LoginState.h"
#import "AddComment.h"
#import "PubDefine.h"
#import "Orders.h"
@interface OrderViewController ()

@property (nonatomic, strong)Orders * orders;//订单模型
@end

@implementation OrderViewController
- (void)viewWillAppear:(BOOL)animated
{
    if ([LoginState LoginedPerson].isLogin) {
        [self initData];
    }else{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请先登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
- (void)initData
{
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
//    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    session.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    NSDictionary * parm = @{@"type":@1};
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=member&c=api_order&a=index";
    [session GET:urlStr parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"res = %@",responseObject);
          NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"dic = %@",dic);
//        if ([[dic valueForKey:@"error"]isEqual:@0]) {
//            NSArray * orderArr = [NSArray arrayWithArray:[responseObject valueForKey:@"orders"]];
//            for (NSDictionary * dic in orderArr) {
//                Orders * orders = [[Orders alloc] init];
//                orders.proName = [[[dic valueForKey:@"sub_order"][0] valueForKey:@"sku"] valueForKey:@"sku_name"];
//                 orders.proUrlStr = [[[dic valueForKey:@"sub_order"][0] valueForKey:@"sku"] valueForKey:@"sku_thumb"];
//                 orders.num = [[[dic valueForKey:@"sub_order"][0] valueForKey:@"sku"] valueForKey:@"sku_nums"];
//                 orders.price = [[[dic valueForKey:@"sub_order"][0] valueForKey:@"sku"] valueForKey:@"sku_price"];
//                orders.sumPrice = [[dic valueForKey:@"sub_order"][0] valueForKey:@"total_amount"];
//            }
//
//        }
                /*
         订单号 ： order_sn
         thumb:     sku_thumb
                           sku_name
                           sku_price
                           sku_nums
                           total_amount  总价
         "address_mobile" = 15902849999;
         "address_name" = 213123123123;
         "address_detail" = "\U4e2d\U56fd\U5927\U9646 \U4e0a\U6d77 \U4e0a\U6d77 \U666e\U9640  51651561";
     
         */

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}
- (Orders *)orders
{
    if (_orders == nil) {
        _orders = [[Orders alloc] init];
    }
    return _orders;
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
