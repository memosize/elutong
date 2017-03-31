#import "LeftViewController.h"
#import "LeftTableViewCell.h"
#import "LoginViewController.h"
#import "LoginState.h"
#import <UIImageView+WebCache.h>
#import "CenterTabbarViewController.h"
#import "MLoginViewController.h"
#import "FankuiViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "ChangePasswordViewController.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView * leftTableView;
    NSArray * itemArry;
    NSMutableArray * imageArray;
    UILabel * nameLab;
    UIImageView * iconImageView;
}

@end

@implementation LeftViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;

    [self initIcon];
    [self initUsername];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [LoginState LoginedPerson].isExit = NO;
    // Do any additional setup after loading the view.
    iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 20, 80, 80)];
    iconImageView.layer.cornerRadius = 40;
    [iconImageView.layer setMasksToBounds:YES];
    nameLab = [[UILabel alloc ] initWithFrame:CGRectMake(110, 60, 60, 20)];
    [self.view addSubview:iconImageView];
    [self.view addSubview:nameLab];
    self.view.backgroundColor = [UIColor whiteColor];
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 70) style:UITableViewStylePlain];
    [self initDataSource];
    [self.view addSubview:leftTableView];
    leftTableView.delegate = self;
    leftTableView.dataSource =self;
    leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // 去掉多余的分割线
}
- (void)initIcon
{

    if ([LoginState LoginedPerson].iconStr && [LoginState LoginedPerson].isLogin) {
        NSLog(@"initIcon");
      [iconImageView sd_setImageWithURL:[NSURL URLWithString:[LoginState LoginedPerson].iconStr]];
    }else{
        [iconImageView setImage:[UIImage imageNamed:@"mainnav(1)@2x"]];
    }
}
- (void)initUsername
{

    if ([LoginState LoginedPerson].nameStr && [LoginState LoginedPerson].isLogin) {
      
        nameLab.text =  [LoginState LoginedPerson].nameStr;
    }
    else{
        nameLab.text = @"未登录";
    }
    
}
- (void)initDataSource
{
    itemArry = [NSArray arrayWithObjects:@"登陆注册",@"修改密码",@"设  置", @"意见反馈",@"退出登陆",nil];
    imageArray = [NSMutableArray array];
    for (int i=0; i<itemArry.count; i++) {
        NSString * imageName = [NSString stringWithFormat:@"left-%d@2x",i+1];
        UIImage * image = [UIImage imageNamed:imageName];
        [imageArray addObject:image];
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"leftCell";
    LeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LeftTableViewCell" owner:nil options:nil] lastObject];
        cell.itemsLabel.text = itemArry[indexPath.row];
        [cell.itemsLabel setFont:[UIFont systemFontOfSize:18]];
        cell.iconImageView.image = imageArray[indexPath.row];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemArry count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {LoginViewController * loginVC = [[LoginViewController alloc] init];
            
            [self presentViewController:loginVC animated:YES completion:nil];}
            break;
        case 1:
        {ChangePasswordViewController * changeVC = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
            
            [self presentViewController:changeVC animated:YES completion:nil];}
            break;
        case 3:
        {FankuiViewController * fankuiVC = [[FankuiViewController alloc] initWithNibName:@"FankuiViewController" bundle:nil];
            [self presentViewController:fankuiVC animated:YES completion:nil];}
            break;
        case 4:
            if ([LoginState LoginedPerson].isLogin) {
                { [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//                    [_delegate shouAlert];
                    CenterTabbarViewController *  cc = [[CenterTabbarViewController alloc] init];
                    [[LoginState LoginedPerson] addObserver:cc forKeyPath:@"isExit" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
                    if ([LoginState LoginedPerson].isExit == YES) {
                        [LoginState LoginedPerson].isExit = NO;
                    }
                    else{
                        [LoginState LoginedPerson].isExit = YES;
                          [[LoginState LoginedPerson]removeObserver:cc forKeyPath:@"isExit"];
                    }
                  
                }
            
            }
            else{
                UIAlertView * alertView =[ [UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }

            
        default:
            break;
    
  
}

}
- (void)exitLogin
{
    
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
