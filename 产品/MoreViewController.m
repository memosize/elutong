//
//  MoreViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/22.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "MoreViewController.h"
#import "ProductCollectionViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface MoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView * proCollection;
}


@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self performSelector:@selector(initCollection) withObject:self afterDelay:4];
    
}
- (void)initData
{
    self.proUrlArr  = [NSMutableArray array];
    self.proNameArr  = [NSMutableArray array];

    
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=goods_list";
     NSDictionary * parm = [NSDictionary dictionaryWithObjectsAndKeys:@10,@"num",nil];
    [session GET:urlStr parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求数据");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"res = %@",responseObject);
        NSArray * listArr = [[NSArray alloc] initWithArray:[[responseObject valueForKey:@"data"] valueForKey:@"lists"]];
        for (int i = 0; i < listArr.count; i++) {
            [self.proNameArr addObject:[listArr[i] valueForKey:@"name"]];
            [self.proUrlArr addObject:[listArr[i] valueForKey:@"thumb"]];
            

        }
        NSLog(@"%lu,%lu",[self.proNameArr count],[self.proUrlArr count]);
        // 需要商品id 店铺id 商品名 商品图片url
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];

}
- (void)initCollection
{
    UICollectionViewFlowLayout * shoplayout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为横向流布局
    shoplayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    //设置每个item的大小为100*100
    shoplayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 100);
    shoplayout.minimumInteritemSpacing = 50;
    
    UICollectionViewFlowLayout * prolayout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为横向流布局
    prolayout.scrollDirection = UICollectionViewScrollPositionCenteredHorizontally;
    //设置每个item的大小为100*100
    prolayout.itemSize = CGSizeMake(100, 100);
    proCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 500) collectionViewLayout:prolayout];
    //代理设置
    
    //注册item类型 这里使用系统的类型
    [proCollection registerNib:[UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"procellId"];
    proCollection.backgroundColor = [UIColor whiteColor];
    proCollection.delegate=self;
    proCollection.dataSource=self;
    [self.view addSubview:proCollection];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return [self.proNameArr count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    
        ProductCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"procellId" forIndexPath:indexPath];
        cell.proNameLab.text = self.proNameArr[indexPath.row];
        [cell.proImageView sd_setImageWithURL:[NSURL URLWithString:self.proUrlArr[indexPath.row]]];
        return cell;
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
