//
//  StoreViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/6.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "StoreViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "StoreCollectionViewCell.h"
#import <AFNetworking.h>
#import "PubDefine.h"
#import "YCPickerView.h"
#import "ProductViewController.h"
@interface StoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    YCPickerView * catePickView;
    YCPickerView * sortPickView;
    NSArray * cateArr;
    NSArray * sortArr;
    NSDictionary * sortparm;
    NSMutableArray * categoryNameArr;
    NSMutableArray * categoryIdArr;
    NSArray * sortParmArr;
    __block NSString * cateId;
    NSDictionary * categoryParm;
}

@end

@implementation StoreViewController
- (void)viewWillAppear:(BOOL)animated
{
    [_cateBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    [_sortBtn setTitle:@"默认排序" forState:UIControlStateNormal];
    [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    sortParmArr = [[NSArray alloc] initWithObjects:@"",@"Hprice",@"Lprice",@"Hsale", @"Lsale",nil];
    cateId = @"0";
    
//    sortParmArr = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3", @"4",nil];
    
    sortArr = [[NSArray alloc] initWithObjects:@"默认排序", @"价格从高到低",@"价格从低到高",@"销量从高到低",@"销量从低到高", nil];
    
    [self performSelector:@selector(initPickerView) withObject:self afterDelay:2.0];
    [self initCollection];
    

}
- (void)initPickerView
{
    
    NSLog(@"cateNameArr = %@",categoryNameArr);
    catePickView = [[YCPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    catePickView.arrPickerData = categoryNameArr;
    [catePickView.pickerView selectRow:3 inComponent:0 animated:YES]; //pickerview默认选中行
    [self.view addSubview:catePickView];
    sortPickView = [[YCPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    sortPickView.arrPickerData = sortArr;
    [catePickView.pickerView selectRow:3 inComponent:0 animated:YES]; //pickerview默认选中行
    [self.view addSubview:sortPickView];
    __weak StoreViewController *blockSelf = self;
    sortPickView.selectBlock = ^(NSString *str){
        for (int i = 0; i < sortArr.count; i++) {
            if ([str isEqual:sortArr[i]]) {
                [blockSelf.sortBtn setTitle:str forState:UIControlStateNormal];
              sortparm = @{@"order":sortParmArr[i],@"catid":cateId};
                NSLog(@"sortparm = %@",sortparm);
                [blockSelf resort];
            }
        }
    };
    NSLog(@"categoryname = %d",categoryNameArr.count);
    catePickView.selectBlock = ^(NSString *str){
        for (int i = 0 ; i < categoryNameArr.count; i++) {
            if ([str isEqual:categoryNameArr[i]]) {
                [blockSelf.cateBtn setTitle:str forState:UIControlStateNormal];
                
                cateId = categoryIdArr[i];
                
                     [blockSelf recate];
         
               
            }
         
            
        }

    };

}
- (void)initData
{

    self.proUrlArr  = [NSMutableArray array];
    self.proNameArr  = [NSMutableArray array];
    self.proPriceArrl = [NSMutableArray array];
    self.sku_idArr = [NSMutableArray array];
    self.seller_idArr = [NSMutableArray array];
    categoryNameArr = [NSMutableArray array];
    categoryIdArr = [NSMutableArray array];

    
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=goods_list";
    NSString * cateStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=category";
    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求数据");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"res ====== %@",[responseObject valueForKey:@"data"] );
        NSArray * listArr = [[NSArray alloc] initWithArray:[[responseObject valueForKey:@"data"] valueForKey:@"lists"]];
        for (int i = 0; i < listArr.count; i++) {
            [self.proNameArr addObject:[listArr[i] valueForKey:@"name"]];
            [self.proUrlArr addObject:[listArr[i] valueForKey:@"thumb"]];
             [self.proPriceArrl addObject:[listArr[i] valueForKey:@"shop_price"]];
              [self.sku_idArr addObject:[listArr[i] valueForKey:@"sku_id"]];
            [self.seller_idArr addObject:[listArr[i] valueForKey:@"seller_id"]];

        
       }
        NSLog(@"%lu",[self.proPriceArrl count]);
        // 需要商品id 店铺id 商品名 商品图片url
        [self.proCollection reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    // 获取分类
    [session POST:cateStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@",responseObject);
        if ([[responseObject valueForKey:@"error"] isEqual:@0]) {
            NSArray * cateArr = [NSArray arrayWithArray:[responseObject valueForKey:@"data"]];
            for (int i = 0; i < cateArr.count; i ++) {
                [categoryIdArr addObject:[cateArr[i] valueForKey:@"id"]];
                [categoryNameArr addObject:[cateArr[i] valueForKey:@"name"]];

            }
            [categoryNameArr insertObject:@"全部分类" atIndex:0];
            [categoryIdArr insertObject:@"0" atIndex:0];
            // 避免 cateIdArr 数组越界
        }

        NSLog(@"catenamearr = %@",categoryNameArr);
        NSLog(@"cateid = %@",categoryIdArr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
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
    prolayout.itemSize = CGSizeMake(100, 168);
    [self.proCollection setCollectionViewLayout:prolayout];
    //代理设置
    
    //注册item类型 这里使用系统的类型
    [self.proCollection registerNib:[UINib nibWithNibName:@"StoreCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"procellId"];
    self.proCollection.backgroundColor = [UIColor whiteColor];
    self.proCollection.delegate=self;
    self.proCollection.dataSource=self;
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
    StoreCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"procellId" forIndexPath:indexPath];
    cell.proNameLab.text = self.proNameArr[indexPath.row];
    [cell.proImageView sd_setImageWithURL:[NSURL URLWithString:self.proUrlArr[indexPath.row]]];
    cell.priceLab.text = [NSString stringWithFormat:@"￥ %@",self.proPriceArrl[indexPath.row]];
    cell.priceLab.textColor = [UIColor redColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductViewController * productVC = [[ProductViewController alloc] init];
    productVC.sku_id = self.sku_idArr[indexPath.row];
    productVC.seller_id = self.seller_idArr[indexPath.row];
    productVC.proImageUrl = self.proUrlArr[indexPath.row];
    productVC.proPrice = self.proPriceArrl[indexPath.row];
    [self.navigationController pushViewController:productVC animated:YES];
}
- (void)requestData
{
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=category";
    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"请求数据中...");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"res = %@",responseObject);
        NSLog(@"name = %@",[[responseObject valueForKey:@"data"][0] valueForKey:@"name"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
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

- (IBAction)tapSort:(id)sender {
    [sortPickView popPickerView];
    
}
- (IBAction)tapCate:(id)sender
{
    [catePickView popPickerView];
}
- (void)recate
{
    // 生成排序参数
    NSString * sortID;
    NSLog(@"sortparmArr = %@",sortParmArr);
    if ([_sortBtn.currentTitle isEqualToString:@"默认排序"]) {
        sortID = sortParmArr[0];
    }
    if ([_sortBtn.currentTitle isEqualToString:@"价格从高到低"]) {
        sortID = sortParmArr[1];
    }
    if ([_sortBtn.currentTitle isEqualToString:@"价格从低到高"]) {
        sortID = sortParmArr[2];
    }
    if ([_sortBtn.currentTitle isEqualToString:@"销量从高到低"]) {
        sortID = sortParmArr[3];
    }
    if ([_sortBtn.currentTitle isEqualToString:@"销量从低到高"]) {
        sortID = sortParmArr[4];
    }
    categoryParm = @{@"catid":cateId,@"order":sortID};
    
    NSLog(@"cateoryparm ======= %@",categoryParm);
    NSLog(@"sortParm === %@",sortparm);
    NSLog(@"catid = %@",cateId);
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=goods_list";
    [session GET:urlStr parameters:categoryParm progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"请求中");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"res = %@",[responseObject valueForKey:@"error"]);
        if ([[responseObject valueForKey:@"error"]isEqual:@0]) {
            self.proPriceArrl = [NSMutableArray array];
            self.proUrlArr = [NSMutableArray array];
            self.proNameArr = [NSMutableArray array];
            
            NSArray * listArr = [[NSArray alloc] initWithArray:[[responseObject valueForKey:@"data"] valueForKey:@"lists"]];
            NSLog(@"listArr = %d",listArr.count);
            for (int i = 0; i < listArr.count; i++) {
                [self.proNameArr addObject:[listArr[i] valueForKey:@"name"]];
                [self.proUrlArr addObject:[listArr[i] valueForKey:@"thumb"]];
                [self.proPriceArrl addObject:[listArr[i] valueForKey:@"shop_price"]];
            }
            NSLog(@"%lu,%lu",[self.proNameArr count],[self.proUrlArr count]);
            // 需要商品id 店铺id 商品名 商品图片url
            [self.proCollection reloadData];
            NSLog(@"proprice.count = %d",_proPriceArrl.count);

        }else{
            // 没有数据的情况
            self.proPriceArrl = nil;
            self.proUrlArr = nil;
            self.proNameArr = nil;
            [self.proCollection reloadData];

        }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}
// 重新分类
- (void)resort
{
    NSLog(@"sortparm = %@",sortparm);
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=goods_list";
    [session GET:urlStr parameters:sortparm progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"请求中");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"res = %@",[responseObject valueForKey:@"error"]);
        if ([[responseObject valueForKey:@"error"]isEqual:@0]) {
            NSLog(@"res = %@",responseObject);
            self.proPriceArrl = [NSMutableArray array];
            self.proUrlArr = [NSMutableArray array];
            self.proNameArr = [NSMutableArray array];
            
            NSArray * listArr = [[NSArray alloc] initWithArray:[[responseObject valueForKey:@"data"] valueForKey:@"lists"]];
         
            for (int i = 0; i < listArr.count; i++) {
                [self.proNameArr addObject:[listArr[i] valueForKey:@"name"]];
                [self.proUrlArr addObject:[listArr[i] valueForKey:@"thumb"]];
                [self.proPriceArrl addObject:[listArr[i] valueForKey:@"shop_price"]];
            }
            NSLog(@"%@",self.proPriceArrl);
            // 需要商品id 店铺id 商品名 商品图片url
            [self.proCollection reloadData];
            
        }else{
            // 没有数据的情况
            self.proPriceArrl = nil;
            self.proUrlArr = nil;
            self.proNameArr = nil;
            [self.proCollection reloadData];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];


}
// 重新排序

@end
