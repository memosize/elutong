//
//  ChangePasswordViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/10.
//  Copyright © 2017年 dasousuo. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ChangePasswordViewController.h"
#import "PubDefine.h"
#import <AFNetworking.h>
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
- (void)viewWillAppear:(BOOL)animated
{
    //    self.navigationController.navigationBar.hidden = YES;
    UIView * navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 64)];
    navigationBar.backgroundColor = [UIColor whiteColor];
    UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"nav (5)"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0.5 * SCREEN_WIDTH, 2, 100, 30)];
    titleLab.center = CGPointMake(SCREEN_WIDTH * 0.5 - 20, 40);
    titleLab.text = @"修改密码";
    titleLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:navigationBar];
    [navigationBar addSubview:titleLab];
    [navigationBar addSubview:leftBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirm:(UIButton *)sender {
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=member&c=api_account&a=resetpassword";
    NSDictionary * parm = [[NSDictionary alloc] initWithObjectsAndKeys:self.oldPwdTF.text,@"oldpassword",self.nnewPwdTF.text,@"newpassword", self.surePwdTF.text,@"newpassword1",nil];
    NSLog(@"parm  = %@",parm);
    [session POST:urlStr parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求中...");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功...");
        NSLog(@"res = %@",[responseObject valueForKey:@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}
@end
