//
//  CommentViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/10.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "CommentViewController.h"
#import <AFNetworking.h>
#import "CommentTableViewCell.h"
#import <UIImageView+WebCache.h>
#define PRO_COMMENT  @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=goods_comment"
#define SHOP_COMMENT @"http://www.b1ss.com/index.php?m=goods&c=api&a=seller_comment"
#import "PubDefine.h"
#import "Comment.h"
#import "AddComment.h"
@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    AddComment * add;
    NSMutableArray * comArr;
}

@property (nonatomic,copy)NSMutableArray * commentArr;
@property (nonatomic, strong)NSString * mood;

@end

@implementation CommentViewController
- (void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self.navigationItem setTitle:@"评论"];
    [self initData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.commmentTb.delegate = self;
    self.commmentTb.dataSource = self;
    self.commmentTb.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    add = [[[NSBundle mainBundle]loadNibNamed:@"AddComment" owner:nil options:nil]lastObject];
    [add.publishBtn addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
    add.center = CGPointMake(SCREEN_WIDTH*0.5, -1000);
    [self.view addSubview:add];
}

- (void)initData
{
    NSLog(@"self.commArr.count ======  %d",self.commentArr.count);
    NSString * urlStr;
    NSDictionary * parm;

    if (self.isPro) {
        urlStr = PRO_COMMENT;
        parm = [[NSDictionary alloc] initWithObjectsAndKeys:self.sku_id,@"sku_id", nil];
        NSLog(@"self.sku_id = %@",self.sku_id);
    }
    else{
        urlStr = SHOP_COMMENT;
        parm = [[NSDictionary alloc] initWithObjectsAndKeys:self.seller_id,@"seller_id", nil];
    }
    comArr = [NSMutableArray array];

    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
        session.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
        session.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    [session GET:urlStr parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"请求中...");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
//        NSLog(@"response = %@",responseObject);
//        NSLog(@"%@",[responseObject valueForKey:@"data"]);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"dic = %@",dic);
        NSArray * dataArr = [NSArray arrayWithArray:[dic valueForKey:@"data"]];
        if (dataArr.count >0) {
            
            for (int i = 0; i < dataArr.count; i++) {
                Comment * comment = [[Comment alloc] init];
                comment.iconUrl = [dataArr[i] valueForKey:@"member_img"];
                comment.name = [dataArr[i] valueForKey:@"member_name"];
                comment.date = [dataArr[i] valueForKey:@"_datetime"];
                comment.mood = [dataArr[i] valueForKey:@"mood"];
                comment.content = [dataArr[i] valueForKey:@"content"];
                [comArr addObject:comment];
            }
        }
        NSLog(@"comArr.count = %d",comArr.count);
        [self.commmentTb reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        NSLog(@"error = %@",error);
    }];
}
#pragma mark -- UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"comment";
    CommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        Comment * comment = (Comment *)comArr[indexPath.row];

        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommentTableViewCell" owner:nil options:nil]lastObject];
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:comment.iconUrl]];
        cell.iconImageView.layer.cornerRadius =36/2;
        cell.iconImageView.clipsToBounds = YES;
        cell.userNameLab.text = comment.name;
        cell.timeLab.text = comment.date;
        cell.timeLab.adjustsFontSizeToFitWidth = YES;
        cell.contentLab.text = comment.content;
        cell.evaluateLab.text = comment.mood;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return comArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}
- (void)add
{
    NSLog(@"add");
    
}
- (void)publish:(UIButton *)sender
{
    NSLog(@"mood = ==== %@",_mood);
    NSLog(@"sku_id = %@",_sku_id);
    _mood = @"";
    if (add.goodBtn.selected) {
           _mood = @"positive";
        add.goodBtn.selected = NO;
    
    }
    if (add.midBtn.selected) {
        _mood = @"neutral";
        add.midBtn.selected = NO;

    }
    if (add.badBtn.selected) {
        _mood = @"negative";
        add.badBtn.selected = NO;

    }
    NSDictionary * parm = @{@"spu_id":self.sku_id,@"content":add.commentTV.text,@"mood":_mood};
    NSLog(@"parm = %@",parm);
    NSLog(@"_mood = %@",_mood);
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=comment&c=api_member&a=add";
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    session.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应

    [session POST:urlStr parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求中");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"dic = %@",dic);
        if ([[dic valueForKey:@"error"]isEqual:@0]) {
            [self initData];
        }
        else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:[dic valueForKey:@"data"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error =  %@",error);
    }];
    self.commmentTb.alpha = 1.0;
    

   [UIView animateWithDuration:0.7 animations:^{
       add.center = CGPointMake(SCREEN_WIDTH*0.5, +2000);
       
   } completion:^(BOOL finished) {

   }];
}
- (NSMutableArray *)commentArr
{
    if (_commentArr == nil) {
        _commentArr = [NSMutableArray array];
    }
    return _commentArr;
}
- (void)clickRightButton
{
    add.center = CGPointMake(SCREEN_WIDTH*0.5, 300);
    add.goodBtn.selected = YES;
    self.commmentTb.alpha = 0.2;
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
