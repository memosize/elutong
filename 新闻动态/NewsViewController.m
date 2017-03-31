//
//  NewsViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/25.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "News.h"
#import "MovieTableViewCell.h"
#import "NewsDetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * newsTableView;
    NSMutableArray * titleArr;
    NSMutableArray * timeArr;
    NSMutableArray * newsImageArr;
    NSArray * sectionArr;
    NSMutableArray * movieUrlArr;
    NSMutableArray * movieTitleArr;
    NSMutableArray * otheNameArr;
    NSMutableArray * otherImageArr;
}

@end

@implementation NewsViewController
- (void)viewWillAppear:(BOOL)animated
{
        [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];


}
- (void)initView
{
    newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) style:UITableViewStyleGrouped];
    newsTableView.delegate = self;
    newsTableView.dataSource = self;
    [self.view addSubview:newsTableView];
}
- (void)initData
{
    titleArr = [NSMutableArray array];
    timeArr = [NSMutableArray array];
    newsImageArr = [NSMutableArray array];
     movieUrlArr = [NSMutableArray array];
     movieTitleArr = [NSMutableArray array];
    otheNameArr = [NSMutableArray array];
    otherImageArr = [NSMutableArray array];
    
    sectionArr = [[NSArray alloc] initWithObjects:@"新闻动态",@"视频中心",@"其他" ,nil];
//    [titleArr addObserver:self forKeyPath:@"count" options:nil context:NULL];
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=misc&c=api&a=news";
//       NSDictionary * parm = [NSDictionary dictionaryWithObjectsAndKeys:numStr,@"username",pwdStr,@"password", nil];
    
    
    [session POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求数据");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        NSLog(@"res = %@",responseObject);
        NSArray * dicc = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"dicc = %@",dicc);
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:[responseObject valueForKey:@"data"]];
        NSArray * newsArr = [NSArray arrayWithArray:[dic valueForKey:@"news"]];
        NSArray * movieArr = [NSArray arrayWithArray:[dic valueForKey:@"movie"]];
        NSArray * otherArr = [NSArray arrayWithArray:[dic valueForKey:@"other"]];
      

        NSLog(@"newsArr.count = %d",newsArr.count);
        for (int i = 0; i < [newsArr count]; i ++) {
            [titleArr addObject:[newsArr[i] valueForKey:@"main"]];
            [newsImageArr addObject:[newsArr[i] valueForKey:@"newsimg"]];
            [timeArr addObject:[newsArr[i] valueForKey:@"date"]];
        }
        for (int i = 0; i < movieArr.count; i++) {
            [movieUrlArr addObject:[movieArr[i] valueForKey:@"url"]];
            [movieTitleArr addObject:[movieArr[i] valueForKey:@"title"]];
        }
        for (int i = 0; i < otherArr.count; i++) {
            [otheNameArr addObject:[otherArr[i] valueForKey:@"name"]];
            [otherImageArr addObject:[otherArr[i] valueForKey:@"img"]];
        }
   
        NSLog(@"movieArr = %@",movieUrlArr);
        if (newsImageArr.count) {
            [newsTableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        
    }];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       if (indexPath.section == 0) {
         NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"news"];
        if (cell == nil) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:nil options:nil]lastObject];
                    cell.timeLab.text = timeArr[indexPath.row];
                    cell.titleLab.text = titleArr[indexPath.row];            
                    [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:newsImageArr[indexPath.row]]];
            
                }
           return cell;
        }
    
    else if (indexPath.section == 1)
    {
    MovieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"movie"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MovieTableViewCell" owner:nil options:nil]lastObject];
            [cell.movieBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
            cell.mtitleLab.text = movieTitleArr[indexPath.row];
        }
        return cell;
    }
    else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"other"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"other"];
//            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:otherImageArr[indexPath.row]]];
//            cell.textLabel.text = otheNameArr[indexPath.row];
        }
        return cell;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return newsImageArr.count;
    }
    else if (section == 1)
    {
        return movieTitleArr.count;
    }
    else
        return otheNameArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 72;
    }else if (indexPath.section == 1)
    {
        return 164;
    }else{
        return 44;
}
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionArr[section];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailViewController * newsDetailVC = [[NewsDetailViewController alloc] initWithNibName:@"NewsDetailViewController" bundle:nil];
    newsDetailVC.titleStr = titleArr[indexPath.row];
    newsDetailVC.imageUrl = newsImageArr[indexPath.row];
    newsDetailVC.timeStr = timeArr[indexPath.row];
    newsDetailVC.contentStr = titleArr[indexPath.row];
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}
- (void)play:(UIButton *)sender
{
    int row = [newsTableView indexPathForCell:((NewsTableViewCell*)[[sender superview]superview])].row;
    NSURL *url = [NSURL URLWithString:movieUrlArr[row]];
    NSLog(@"url = %@",url);
    //视频播放对象
    MPMoviePlayerController *movie = [[MPMoviePlayerController alloc] initWithContentURL:url];
        movie.controlStyle = MPMovieControlStyleFullscreen;
    [movie.view setFrame:self.view.bounds];
    movie.initialPlaybackTime = -1;
    [self.view addSubview:movie.view];
    [movie play];
    // 注册一个播放结束的通知
    //1 监听播放状态
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stateChange) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    //2 监听播放完成
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finishedPlay) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    //3视频截图
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(caputerImage:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    //3视频截图
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(caputerImage:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    
    //4退出全屏通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exitFullScreen) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
}
- (void)exitFullScreen
{
    NSLog(@"退出全屏");
}
- (void)finishedPlay
{
    NSLog(@"播放完成");
}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"count"]) {
//        [newsTableView reloadData];
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
