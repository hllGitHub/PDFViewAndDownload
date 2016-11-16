//
//  HLLWebViewController.m
//  PDFViewAndDownload
//
//  Created by Jeffrey hu on 16/11/16.
//  Copyright © 2016年 Jeffrey hu. All rights reserved.
//

#import "HLLWebViewController.h"
#import <SVProgressHUD.h>

@interface HLLWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong)   UIWebView *webView;

@end

@implementation HLLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialize data and view 
- (void)setupSubViews {
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.and.right.offset(0);
    }];
    
    NSURL *url = [NSURL URLWithString:self.webUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 设置缩放
    [self.webView setScalesPageToFit:YES];
    [self.webView loadRequest:request];
    [SVProgressHUD show];
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc]init];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate= self;
    }
    return _webView;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"加载完成");
    [SVProgressHUD dismiss];
}

@end
