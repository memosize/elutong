//
//  MLoginViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/27.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "MLoginViewController.h"
#import "PubDefine.h"
@interface MLoginViewController ()
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

}

@end

@implementation MLoginViewController
- (void)viewWillAppear:(BOOL)animated
{
    UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 30, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"nav (5)"] forState:UIControlStateNormal];
    [self.view addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}
// 初始化视图
- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray * segmentArray = [NSArray arrayWithObjects:@"登陆",@"注册", nil];
    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:segmentArray];
    segment.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 60);
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 124, CGRectGetWidth(self.view.bounds), 96)];
    loginView.backgroundColor = [UIColor whiteColor];
    registerView = [[UIView alloc] initWithFrame:CGRectMake(0, 124, SCREEN_WIDTH, 100)];
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
    resBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.bounds), 45)];
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
    
     UITextField * nameTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 144, SCREEN_WIDTH,48)];
     nameTF.placeholder = @"        请输入姓名";
     nameTF.layer.borderColor = [UIColor grayColor].CGColor;
     nameTF.layer.borderWidth = 1;
     nameTF.secureTextEntry = YES;

     UITextField * idTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 192, SCREEN_WIDTH,48)];
     idTF.placeholder = @"        请输入身份证号";
     idTF.layer.borderColor = [UIColor grayColor].CGColor;
     idTF.layer.borderWidth = 1;
     idTF.secureTextEntry = YES;
     
     
     UITextField * shopAddTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 240, SCREEN_WIDTH,48)];
     shopAddTF.placeholder = @"        请输入店铺地址";
     shopAddTF.layer.borderColor = [UIColor grayColor].CGColor;
     shopAddTF.layer.borderWidth = 1;
     shopAddTF.secureTextEntry = YES;



    
    
    sureTF_register.secureTextEntry = YES;
    
    [registerView addSubview:numTF_register];
    [registerView addSubview:pwdTF_register];
    [registerView addSubview:sureTF_register];
//    [registerView addSubview:resBtn];
    [registerView addSubview:shopAddTF];
    [registerView addSubview:idTF];
    [registerView addSubview:nameTF];
//    [subView addSubview:resBtn];


    
}
// 点击segmentControl 切换视图
-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg
{
    switch (Seg.selectedSegmentIndex) {
        case 0:
            subView.frame = CGRectMake(0, 220, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-220);

            for (UIView * view in subView.subviews) {
                [view removeFromSuperview];
            }
            [subView addSubview:forgetBtn];
            [subView addSubview:loginBtn];
                       [registerView removeFromSuperview];
            [self.view addSubview:loginView];
            break;
        case 1:
            subView.frame = CGRectMake(0, 412, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-412);

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
    
}
- (void)regist
{
    
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
