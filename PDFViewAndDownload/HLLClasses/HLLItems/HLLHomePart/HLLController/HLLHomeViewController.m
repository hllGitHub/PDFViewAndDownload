//
//  HLLHomeViewController.m
//  PDFViewAndDownload
//
//  Created by Jeffrey hu on 16/11/16.
//  Copyright © 2016年 Jeffrey hu. All rights reserved.
//

#import "HLLHomeViewController.h"
#import <BButton.h>
#import "HLLPDFViewController.h"        // PDFView
#import "HLLPDFDownloadViewController.h"// PDFDownload

@interface HLLHomeViewController ()

// 浏览button
@property (nonatomic, strong)   BButton *viewButton;
// 下载button
@property (nonatomic, strong)   BButton *downloadButton;

@end

@implementation HLLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHue:0.6 saturation:0.7 brightness:0.8 alpha:1.0];
    
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Initialize data and view
- (void)setupSubViews {
    self.navigationController.navigationItem.title = @"";
    [self.navigationController.navigationBar setTranslucent:YES];
    
    [self setupButtons];
}

// 绘制button
- (void)setupButtons {
    self.viewButton = [[BButton alloc]initWithFrame:CGRectZero type:BButtonTypeWarning style:BButtonStyleBootstrapV3];
    [self.view addSubview:self.viewButton];
    [self.viewButton addTarget:self action:@selector(viewPDF) forControlEvents:UIControlEventTouchUpInside];
    [self.viewButton setTitle:@"浏览" forState:UIControlStateNormal];
    
    self.downloadButton = [[BButton alloc]initWithFrame:CGRectZero type:BButtonTypePurple style:BButtonStyleBootstrapV3];
    [self.view addSubview:self.downloadButton];
    [self.downloadButton addTarget:self action:@selector(downloadPDF) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadButton setTitle:@"下载" forState:UIControlStateNormal];
    
    // 布局
    __weak typeof(self) weakSelf = self;
    [self.viewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
        make.top.offset(200);
    }];
    
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
        make.top.equalTo(weakSelf.viewButton.mas_bottom).offset(20);
    }];
}

#pragma mark - Private method
// 浏览PDF
- (void)viewPDF {
    NSLog(@"浏览PDF");
    
    HLLPDFViewController *pdfViewController = [HLLPDFViewController new];
    pdfViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pdfViewController animated:YES];
}

// 下载PDF
- (void)downloadPDF {
    NSLog(@"下载PDF");
    
    HLLPDFDownloadViewController *pdfLoadViewController = [HLLPDFDownloadViewController new];
    pdfLoadViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pdfLoadViewController animated:YES];
}

@end
