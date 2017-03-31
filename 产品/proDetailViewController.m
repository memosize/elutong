//
//  proDetailViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/10.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "proDetailViewController.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
@interface proDetailViewController ()

@end

@implementation proDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",self.proImageUrl);
    self.priceLab.text = [NSString stringWithFormat:@"价格:%@",self.proPrice];
    [self.proImageView sd_setImageWithURL:[NSURL URLWithString:self.proImageUrl]];
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
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
