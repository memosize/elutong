//
//  IndexViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/7.
//  Copyright © 2017年 dasousuo. All rights reserved.
//
#import "IndexViewController.h"
#import "PubDefine.h"
#import "ShopCollectionViewCell.h"
#import "ProductCollectionViewCell.h"
#import "RescueViewController.h"
#import "ProductViewController.h"
#import "ShopViewController.h"
#import "OtherViewController.h"
#import <AFNetworking.h>
#import "MoreViewController.h"
#import <UIImageView+WebCache.h>
#import "NewsViewController.h"
#import "ProductViewController.h"
#import "ShopViewController.h"
#import "StoreViewController.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS//加上这两个宏就不需要考虑父控件了
#import "Masonry.h"
@interface IndexViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIScrollView * myscrollView;
    UIImageView * imageView;
    UIPageControl * pageControl;
    UIButton * rescueBtn;// 救援按钮
    UIButton * NewsBtn;//新闻按钮
    UIButton * shopBtn;//购物中心
    UIButton * serviceBtn;// 其他维修服务
    UIButton * recomdBtn;// 新品推荐按钮
    UIButton * moreBtn;    //更多按钮
    UIButton * secRecBtn;
    UIButton * secMoreBtn;
    UICollectionView * shopCollection;
    UICollectionView * proCollection;
    int dis;
    UIScrollView * bgScrollerView;//底层滚动视图
}

@end

@implementation IndexViewController
- (void)viewWillAppear:(BOOL)animated
{
    if (self.proNameArr.count == 0  && self.selleridArr.count == 0  ) {
        [self initdata];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        [self initView];
        [self initButton];
    [self initCollection];
    
    
}

- (void)initdata
{
    self.proUrlArr  = [NSMutableArray array];
    self.proNameArr  = [NSMutableArray array];
    self.skuIdArr  = [NSMutableArray array];
    self.selleridArr  = [NSMutableArray array];
    self.shopIdArr = [NSMutableArray array];
    self.proPriceArr = [NSMutableArray array];
    
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=goods_list";
    NSString * shopUrlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=seller";
    NSDictionary * proParm = [[NSDictionary alloc] initWithObjectsAndKeys:@3,@"num", nil];
    [session GET:urlStr parameters:proParm progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求数据");
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"res = %@",responseObject);
        if (1) {
            NSArray * listArr = [[NSArray alloc] initWithArray:[[responseObject valueForKey:@"data"] valueForKey:@"lists"]];
            for (int i = 0; i < listArr.count; i++) {
                [self.proNameArr addObject:[listArr[i] valueForKey:@"name"]];
                [self.proUrlArr addObject:[listArr[i] valueForKey:@"thumb"]];
                [self.skuIdArr addObject:[listArr[i] valueForKey:@"sku_id"]];
                [self.selleridArr addObject:[listArr[i] valueForKey:@"seller_id"]];
                [self.proPriceArr addObject:[listArr[i] valueForKey:@"shop_price"]];
            }
            NSLog(@"%lu,%lu,%lu,%lu",[self.proNameArr count],[self.proUrlArr count],[self.skuIdArr count],(unsigned long)[self.selleridArr count]);
            // 需要商品id 店铺id 商品名 商品图片url
            [proCollection reloadData];

        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    [session GET:shopUrlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求数据");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.sellerImageUrlArr = [NSMutableArray array];
        self.sellerNameArr = [NSMutableArray array];
        NSLog(@"请求成功");
        NSLog(@"res0 = %@",responseObject);
        NSArray * listArr = [[NSArray alloc] initWithArray:[responseObject valueForKey:@"data"]];
//        NSLog(@"listArr = %@",listArr);
        for (int i = 0; i < [listArr count]; i++) {
         [self.sellerNameArr addObject:[listArr[i] valueForKey:@"shopName"]];
         [self.sellerImageUrlArr addObject:[listArr[i] valueForKey:@"logo"]];
            [self.shopIdArr addObject:[listArr[i] valueForKey:@"id"]];
        
        }
        [shopCollection reloadData];
        NSLog(@"%d  ---   %d",self.sellerImageUrlArr.count,self.sellerNameArr.count);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];

    NSLog(@"self.pronameArr = %@",self.proNameArr);

}
- (void)initView
{
    bgScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT * 2)];
    bgScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 3);
//    bgScrollerView.backgroundColor = [UIColor whiteColor];
    myscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    CGFloat imageW = myscrollView.frame.size.width;
    CGFloat imageH = myscrollView.frame.size.height;
    CGFloat imageY = 0;
    int imageCount = 5;
    // 设置scrollView
    
    myscrollView.contentSize = CGSizeMake(imageCount * imageW, imageH);
   


    // 轮播图加载
    for (int i = 0 ; i < imageCount; i++) {
        imageView = [[UIImageView alloc] init];
        CGFloat imageX = i * imageW;

        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        // 设置图片
        NSString * imageName = [NSString stringWithFormat:@"banner%d.jpg",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        [myscrollView addSubview:imageView];

    }
    // 隐藏水平滚动条
    myscrollView.showsHorizontalScrollIndicator = NO;
    // 分页
    myscrollView.pagingEnabled = YES;
    myscrollView.delegate = self;
    // 初始化pageControl
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 50, 110, 100, 37)];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.numberOfPages = imageCount;
    pageControl.currentPage = 0;
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    
//    [self.view addSubview:pageControl];
    [self.view addSubview:bgScrollerView];
    [bgScrollerView addSubview:myscrollView];
    [bgScrollerView addSubview:pageControl];

    __weak typeof (self) weakSelf = self;//防止循环使用

    }
- (void)nextImage
{
    // 增加页码
    int page = 0;
    if (pageControl.currentPage == 4) {
        page = 0;
    }
    else{
        page = pageControl.currentPage + 1;
    }
    // 计算scrollView 滚动位置
    CGFloat offsetX = page * myscrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [myscrollView setContentOffset:offset animated:YES];
    
}
// scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page  = (myscrollView.contentOffset.x + scrollView.frame.size.width * 0.5)/scrollView.frame.size.width;
    pageControl.currentPage = page;
    
}
- (void)initButton
{
    rescueBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, myscrollView.frame.origin.y + 100, 40, 60)];
    [rescueBtn setTitle:@"救援" forState:UIControlStateNormal];
    [rescueBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [rescueBtn setImage:[UIImage imageNamed:@"link_03@3x"] forState:UIControlStateNormal];
    [rescueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    rescueBtn.titleEdgeInsets = UIEdgeInsetsMake(40, -42, -10, 0);
    rescueBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [rescueBtn addTarget:self action:@selector(turnToRescue) forControlEvents:UIControlEventTouchUpInside];
    NewsBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, myscrollView.frame.origin.y + 100, 40, 63)];
    [NewsBtn setTitle:@"新闻动态" forState:UIControlStateNormal];
    [NewsBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [NewsBtn setImage:[UIImage imageNamed:@"link_05@3x"] forState:UIControlStateNormal];
    [NewsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    NewsBtn.titleEdgeInsets = UIEdgeInsetsMake(40, -42, -10, 1);
    NewsBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //购物按钮
    [NewsBtn addTarget:self action:@selector(turnToNews) forControlEvents:UIControlEventTouchUpInside];
    shopBtn = [[UIButton alloc] initWithFrame:CGRectMake(180, myscrollView.frame.origin.y + 100, 40, 60)];
    [shopBtn setTitle:@"商城" forState:UIControlStateNormal];
    [shopBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [shopBtn setImage:[UIImage imageNamed:@"link_07@3x"] forState:UIControlStateNormal];
    [shopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    shopBtn.titleEdgeInsets = UIEdgeInsetsMake(40, -42, -10, 0);
    shopBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [shopBtn addTarget:self action:@selector(turnToStore) forControlEvents:UIControlEventTouchUpInside];
    // 维修按钮
    serviceBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, myscrollView.frame.origin.y + 100, 40, 60)];
    [serviceBtn setTitle:@"其他维修" forState:UIControlStateNormal];
    [serviceBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [serviceBtn setImage:[UIImage imageNamed:@"link_09@3x"] forState:UIControlStateNormal];
    [serviceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    serviceBtn.titleEdgeInsets = UIEdgeInsetsMake(40, -42, -10, 0);
    serviceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [serviceBtn addTarget:self action:@selector(turnToMaintain) forControlEvents:UIControlEventTouchUpInside];
    // 新品推荐按钮
    recomdBtn  = [[UIButton alloc] initWithFrame:CGRectMake(10, 240, 80, 20)];
    [recomdBtn setImage:[UIImage imageNamed:@"tit_03@3x"] forState:UIControlStateNormal];
    [recomdBtn setTitle:@"新品推荐" forState:UIControlStateNormal];
    [recomdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [recomdBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    recomdBtn.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 10);
    recomdBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    recomdBtn.enabled = NO;
    // 更多按钮
    moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 115, 240, 40, 20)];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    // 新品推荐按钮
    [moreBtn addTarget:self action:@selector(turnToMorePro) forControlEvents:UIControlEventTouchUpInside];
    secRecBtn  = [[UIButton alloc] initWithFrame:CGRectMake(10, 380, 80, 20)];
    [secRecBtn setImage:[UIImage imageNamed:@"tit_03@3x"] forState:UIControlStateNormal];
    [secRecBtn setTitle:@"明星店铺" forState:UIControlStateNormal];
    [secRecBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secRecBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    secRecBtn.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 10);
    secRecBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    secRecBtn.enabled = NO;
    // 更多按钮
    secMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 115, 380, 40, 20)];
    [secMoreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [secMoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secMoreBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [bgScrollerView addSubview:moreBtn];
    [bgScrollerView addSubview:recomdBtn];
    [bgScrollerView addSubview:rescueBtn];
    [bgScrollerView addSubview:NewsBtn];
    [bgScrollerView addSubview:shopBtn];
    [bgScrollerView addSubview:serviceBtn];
    [bgScrollerView addSubview:secRecBtn];
    [bgScrollerView addSubview:secMoreBtn];
    // 按钮适配
    __weak typeof (self) weakSelf = self;//防止循环使用
    float padding = (SCREEN_WIDTH - 230)/3 + 10;
    NSLog(@"paddind = %f",padding);
    [recomdBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.top.equalTo(myscrollView).with.offset(220);
        make.left.equalTo(self.view).with.offset(10);
    }];
    [moreBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.top.equalTo(myscrollView).with.offset(220);
        make.right.equalTo(self.view).with.offset(-10);
    }];
    [secRecBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.top.equalTo(myscrollView).with.offset(400);
        make.left.equalTo(self.view).with.offset(10);
    }];
    [secMoreBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.top.equalTo(myscrollView).with.offset(400);
        make.right.equalTo(self.view).with.offset(-10);
    }];
    [rescueBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 60));
        make.top.equalTo(myscrollView).with.offset(145);
        make.left.equalTo(myscrollView).with.offset(15);
    }];
    [serviceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 60));
        make.top.equalTo(myscrollView).with.offset(145);
        make.right.equalTo(myscrollView).with.offset(-15);
    }];
    [NewsBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 60));
        make.left.equalTo(rescueBtn.mas_right).with.offset(padding);
        make.top.equalTo(myscrollView).with.offset(145);

    }];
    [shopBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 60));
        make.right.equalTo(serviceBtn.mas_left).with.offset(- padding);
        make.top.equalTo(myscrollView).with.offset(145);

    }];


    

}
// 初始化collection
- (void)initCollection
{
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * shoplayout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为横向流布局
    shoplayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    //设置每个item的大小为100*100
    shoplayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), (200));
    shoplayout.minimumInteritemSpacing = 5;
    
    UICollectionViewFlowLayout * prolayout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为横向流布局
    prolayout.scrollDirection = UICollectionViewScrollPositionCenteredHorizontally;
    //设置每个item的大小为100*100
    prolayout.itemSize = CGSizeMake(SCREEN_WIDTH/3 - 5, 120);
    prolayout.minimumInteritemSpacing = 0;

//创建collectionView 通过一个布局策略layout来创建
    shopCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 430, CGRectGetWidth(self.view.bounds), 1230) collectionViewLayout:shoplayout];
    //代理设置
    shopCollection.backgroundColor = [UIColor whiteColor];
    shopCollection.delegate=self;
    shopCollection.dataSource=self;
    //注册item类型 这里使用系统的类型
    [shopCollection registerClass:[ShopCollectionViewCell class] forCellWithReuseIdentifier:@"cellid_shop"];
    
    [bgScrollerView addSubview:shopCollection];
    
    proCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 250, CGRectGetWidth(self.view.bounds), 120) collectionViewLayout:prolayout];
    
    //代理设置

    //注册item类型 这里使用系统的类型
    [proCollection registerNib:[UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"procellId"];
    proCollection.backgroundColor = [UIColor whiteColor];
    proCollection.delegate=self;
    proCollection.dataSource=self;
    [bgScrollerView addSubview:proCollection];
//ProCollectinView 适配
  

}
// UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    
    if (collectionView == shopCollection) {
        return [self.sellerNameArr count];
    }
    else{
        return [self.proNameArr count];
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == shopCollection) {
        ShopCollectionViewCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid_shop" forIndexPath:indexPath];
        cell.shopNameLab.text = self.sellerNameArr[indexPath.row];
        [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:self.sellerImageUrlArr[indexPath.row]]];
        __weak typeof (self) weakSelf = self;
        return cell;
    }else
    {
        ProductCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"procellId" forIndexPath:indexPath];
        cell.proNameLab.text = self.proNameArr[indexPath.row];
        [cell.proImageView sd_setImageWithURL:[NSURL URLWithString:self.proUrlArr[indexPath.row]]];
        return cell;
    }

//    cell.backgroundColor = [UIColor colorWithPatternImage:_imageArr[indexPath.row]];
//    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithPatternImage:_imageArr[indexPath.row]];
//    cell.backgroundColor = [UIColor redColor];

}
#pragma mark -- UICollectionDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductViewController * productVC = [[ProductViewController alloc] initWithNibName:@"ProductViewController" bundle:nil];
    ShopViewController * shopVC = [[ShopViewController alloc] init];
    if (collectionView == proCollection) {
        productVC.sku_id = self.skuIdArr[indexPath.row];
        productVC.seller_id = self.shopIdArr[indexPath.row];
        productVC.proImageUrl = self.proUrlArr[indexPath.row];
        productVC.proPrice = self.proPriceArr[indexPath.row];
        [self.navigationController pushViewController:productVC animated:YES];
    }else{
        shopVC.shopId = self.shopIdArr[indexPath.row];
        [self.navigationController pushViewController:shopVC animated:YES];

    }
    
}

// 跳转到救援
- (void)turnToRescue
{
    RescueViewController * rescueVC = [[RescueViewController alloc] init];
    [self.navigationController pushViewController:rescueVC animated:YES];
//    [[SlideNavigationController sharedInstance] switchToViewController:rescueVC withCompletion:nil];
}
- (void)turnToMaintain
{
    OtherViewController * otherVC = [[OtherViewController alloc] init];
//    [[SlideNavigationController sharedInstance] switchToViewController:otherVC withCompletion:nil];
        [self.navigationController pushViewController:otherVC animated:YES];
}
- (void)turnToMorePro
{
    MoreViewController * moreVC = [[MoreViewController alloc] init];
        [self.navigationController pushViewController:moreVC animated:YES];
//    [[SlideNavigationController sharedInstance]switchToViewController:moreVC withCompletion:nil];
}
- (void)turnToNews
{
    NewsViewController * newsVC = [[NewsViewController alloc] init];
    [self.navigationController pushViewController:newsVC animated:YES];
}
- (void)turnToStore
{
    StoreViewController * storeVC = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil];
    [self.navigationController pushViewController:storeVC animated:YES];
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
