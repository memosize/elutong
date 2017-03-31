//
//  LoginViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/8.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "LoginViewController.h"
#import "PubDefine.h"
#import <AFNetworking.h>
#import "LeftViewController.h"
#import <UIImageView+WebCache.h>
#import "LoginState.h"
@interface LoginViewController ()<UIAlertViewDelegate>
{
    UIView * loginView;
    UIView * registerView;
    UIButton * forgetBtn;
    UIButton * loginBtn;
    UIButton * resBtn;
    UIView * subView;
    UITextField * numTF;
    UITextField * pwdTF;
    UITextField * numTF_register;
    UITextField * pwdTF_register;
    UITextField * sureTF_register;
    __block NSInteger  isSuccess;// 确保不重复登陆
    __block NSString * iconImageUrl;//头像url
    __block NSString * username;// 用户名
    LeftViewController * leftVC;
    
}

@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.navigationBar.hidden = YES;
    UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"nav (5)"] forState:UIControlStateNormal];
    [self.view addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //    [self.view addSubview:registerView];
    isSuccess = 0;
    [self initView];
    
}
// 初始化视图
- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray * segmentArray = [NSArray arrayWithObjects:@"登陆",@"注册", nil];
    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:segmentArray];
    segment.frame = CGRectMake(0, 55, CGRectGetWidth(self.view.bounds), 60);
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 115, CGRectGetWidth(self.view.bounds), 96)];
    loginView.backgroundColor = [UIColor whiteColor];
    registerView = [[UIView alloc] initWithFrame:CGRectMake(0, 115, SCREEN_WIDTH, 145)];
    registerView.backgroundColor = [UIColor whiteColor];
    numTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 48)];
    numTF.placeholder = @"        请输入手机号";
    numTF.layer.borderColor = [UIColor grayColor].CGColor;
    numTF.layer.borderWidth = 1;
    //    numTF.layer.cornerRadius = 6;
    pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 48, CGRectGetWidth(self.view.bounds), 48)];
    pwdTF.placeholder = @"        请输入密码";
    pwdTF.secureTextEntry = YES;
    //    pwdTF.layer.borderColor = [UIColor grayColor].CGColor;
    //    pwdTF.layer.borderWidth = 1;
    //    pwdTF.layer.cornerRadius = 6;
    [loginView addSubview:numTF];
    [loginView addSubview:pwdTF];
    //忘记密码按钮
    forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 85, 40)];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [loginView addSubview:forgetBtn];
    subView = [[UIView alloc] initWithFrame:CGRectMake(0, 216, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 216)];
    subView.backgroundColor = [UIColor grayColor];
    //登陆按钮
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.bounds), 45)];
    [loginBtn setTitle:@"立即登陆" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.backgroundColor = [UIColor colorWithRed:59/255.0 green:183/255.0 blue:43/255.0 alpha:1.0];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    resBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.bounds), 45)];
    [resBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    resBtn.layer.cornerRadius = 7;
    resBtn.backgroundColor = [UIColor colorWithRed:59/255.0 green:183/255.0 blue:43/255.0 alpha:1.0];
    [resBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [ subView addSubview:loginBtn];
    [self.view addSubview:subView];
    [subView addSubview:forgetBtn];
    [subView addSubview:loginBtn];
    [self.view addSubview:loginView];
    numTF_register = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
    numTF_register.placeholder = @"        请设置手机号";
    numTF_register.layer.borderColor = [UIColor grayColor].CGColor;
    numTF_register.layer.borderWidth = 1;
    pwdTF_register = [[UITextField alloc] initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH, 48)];
    pwdTF_register.placeholder = @"        请设置密码";
//    pwdTF_register.layer.borderColor = [UIColor grayColor].CGColor;
//    pwdTF_register.layer.borderWidth = 1;
//    pwdTF_register.secureTextEntry = YES;

    sureTF_register = [[UITextField alloc] initWithFrame:CGRectMake(0, 96, SCREEN_WIDTH,48)];
    sureTF_register.placeholder = @"        请再次输入密码";
        sureTF_register.layer.borderColor = [UIColor grayColor].CGColor;
        sureTF_register.layer.borderWidth = 1;
        sureTF_register.secureTextEntry = YES;

    sureTF_register.secureTextEntry = YES;

    [registerView addSubview:numTF_register];
    [registerView addSubview:pwdTF_register];
    [registerView addSubview:sureTF_register];
    [registerView addSubview:resBtn];

}
// 点击segmentControl 切换视图
-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg
{
        switch (Seg.selectedSegmentIndex) {
        case 0:
                for (UIView * view in subView.subviews) {
                    [view removeFromSuperview];
                }
        [subView addSubview:forgetBtn];
        [subView addSubview:loginBtn];
        [registerView removeFromSuperview];
        [self.view addSubview:loginView];
        break;
        case 1:
                for (UIView * view in subView.subviews) {
                    [view removeFromSuperview];
                }
                [subView addSubview:resBtn];
                [loginView removeFromSuperview];
                [self.view addSubview:registerView];
            default:
            break;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [numTF resignFirstResponder];
    [pwdTF resignFirstResponder];
    [numTF_register resignFirstResponder];
    [pwdTF_register resignFirstResponder];
    [sureTF_register resignFirstResponder];
}
 - (void)login
{
    [numTF resignFirstResponder];
    [pwdTF resignFirstResponder];
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];

    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    session.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应

    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=member_login";
      NSString * numStr = numTF.text;
    NSString * pwdStr = pwdTF.text;
    NSLog(@"numStr = %@",numStr);

    NSDictionary * parm = [NSDictionary dictionaryWithObjectsAndKeys:numStr,@"username",pwdStr,@"password", nil];
     [session POST:urlStr parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求数据");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"string = %@",string);
        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"dic = %@",dic);
        username = [[dic valueForKey:@"member"] valueForKey:@"username"];
        iconImageUrl = [[dic valueForKey:@"member"] valueForKey:@"avatar"];
        leftVC.iconStr = iconImageUrl;
        leftVC.nameStr = username;
        [LoginState LoginedPerson].iconStr = iconImageUrl;
        [LoginState LoginedPerson].nameStr = username;
        
        
        
        if ([[dic valueForKey:@"data"]isEqualToString:@"登录成功"]) {
            [LoginState LoginedPerson].isLogin = YES;
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"登录提示" message:@"登录成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
           }
        else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"登录提示" message:@"用户名或者密码错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];

        }
     

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        
    }];
    
}
- (void)regist
{

    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=member_reg";
    NSString * num_registerStr = numTF_register.text;
    NSString * pwd_registerStr = pwdTF_register.text;
    
    NSDictionary * parm = [NSDictionary dictionaryWithObjectsAndKeys:num_registerStr,@"mobile",pwd_registerStr,@"password", nil];
    NSLog(@"parm = %@",parm);
    
    [session POST:urlStr parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求数据");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"请求成功");
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:responseObject]];
        NSString * str = [dic valueForKey:@"data"];
        NSLog(@"str = %@",str);
        if ([str isEqualToString:@"注册成功"]) {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"注册提示" message:@"注册成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"注册提示" message:@"请求错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
//        NSLog(@"fsf");
//        
//        leftVC = [[LeftViewController alloc] init];
//        leftVC.iconStr = iconImageUrl;
//                [LoginState LoginedPerson].iconStr = iconImageUrl;
//        [LoginState LoginedPerson].nameStr = username;
////        [[SlideNavigationController sharedInstance] switchToViewController:leftVC withCompletion:nil];
//               [self dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
