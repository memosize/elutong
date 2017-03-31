//
//  NewsDetailViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/6.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <UIImageView+WebCache.h>
#import <WebKit/WebKit.h>
#import "PubDefine.h"
@interface NewsDetailViewController ()
{
    UIScrollView * myscrollView;
}
@property (nonatomic,strong)WKWebView * webView;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initWebView];
    [self initTitle];
  

   
}
- (void)initWebView
{
    myscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    myscrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 1.2);
    [self.view addSubview:myscrollView];
    [self.webView loadHTMLString:self.contentStr baseURL:nil];
    [myscrollView addSubview:_webView];
}
- (void)initTitle
{
    NSLog(@"%@",self.titleStr);
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 80)];
    titleLab.font = [UIFont systemFontOfSize:12];
    titleLab.numberOfLines = 2;
    titleLab.center = CGPointMake(CGRectGetMidX(self.view.bounds), 40);
    titleLab.text = self.titleStr;
    
    [myscrollView addSubview:titleLab];
}
- (WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.preferences = [WKPreferences new];
        //The minimum font size in points default is 0;
        config.preferences.minimumFontSize = 30;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, SCREEN_WIDTH, SCREEN_HEIGHT - 88) configuration:config];
        
    }
    return _webView;
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
