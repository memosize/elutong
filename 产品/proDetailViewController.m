//
//  proDetailViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/10.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "proDetailViewController.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <WebKit/WebKit.h>
#import "PubDefine.h"
@interface proDetailViewController ()
{
    UIScrollView * myscrollView;
}
@property (nonatomic, strong)WKWebView * webView;
@end

@implementation proDetailViewController
- (void)viewWillAppear:(BOOL)animated
{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initWebView];

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
- (void)initWebView
{
    myscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    myscrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 1.2);
    [self.view addSubview:myscrollView];
    [self.webView loadHTMLString:self.contentStr baseURL:nil];
    [self.view addSubview:_webView];
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
