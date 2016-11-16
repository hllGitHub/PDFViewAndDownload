//
//  HLLPDFViewController.m
//  PDFViewAndDownload
//
//  Created by Jeffrey hu on 16/11/16.
//  Copyright © 2016年 Jeffrey hu. All rights reserved.
//

#import "HLLPDFViewController.h"
#import "HLLMenuCell.h"
#import <QuickLook/QuickLook.h>

#import "HLLWebViewController.h"        // webViewController
#import "ReaderViewController.h"

static NSString *kCellId = @"kCellId";

@interface HLLPDFViewController () <UITableViewDelegate, UITableViewDataSource, QLPreviewControllerDelegate, QLPreviewControllerDataSource, ReaderViewControllerDelegate>

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   NSMutableArray *titleArray;
@property (nonatomic, assign)   BOOL isLocal;

@end

@implementation HLLPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeData];
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - Initialize data and view
- (void)initializeData {
    self.titleArray = [NSMutableArray array];
    [self.titleArray addObject:@"UIWebView本地浏览"];
    [self.titleArray addObject:@"UIWebView在线浏览"];
    [self.titleArray addObject:@"QLPreviewController浏览"];
    [self.titleArray addObject:@"PDF Reader"];
}

- (void)setupSubViews {
    self.navigationController.navigationItem.title = @"PDFView";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.bottom.offset(0);
    }];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HLLMenuCell class] forCellReuseIdentifier:kCellId];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLLMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    cell.title = self.titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"webView");
            HLLWebViewController *webViewLocalController = [[HLLWebViewController alloc]init];
            webViewLocalController.webUrlString = PDF_FILE_PATH;
            [self.navigationController pushViewController:webViewLocalController animated:YES];
            break;
        }
        case 1:
        {
            NSLog(@"webView");
            HLLWebViewController *webViewController = [HLLWebViewController alloc];
            webViewController.webUrlString = PDF_URL;
            [self.navigationController pushViewController:webViewController animated:YES];
            break;
        }
        case 2:
        {
            NSLog(@"本地预览");
            self.isLocal = YES;
            QLPreviewController *qlPreview = [[QLPreviewController alloc]init];
            qlPreview.dataSource = self; //需要打开的文件的信息要实现dataSource中的方法
            qlPreview.delegate = self;  //视图显示的控制
            qlPreview.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
            [self.navigationController pushViewController:qlPreview animated:YES];
            break;
        }
        case 3:
        {
            NSLog(@"阅读器");
            ReaderDocument *doc = [[ReaderDocument alloc] initWithFilePath:PDF_FILE_PATH password:nil];
            ReaderViewController *rvc = [[ReaderViewController alloc] initWithReaderDocument:doc];
            rvc.delegate = self;
            [self presentViewController:rvc animated:YES completion:nil];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"git-cheatsheet" ofType:@"pdf"];
    
    return [NSURL fileURLWithPath:path];
}

#pragma mark - ReaderViewControllerDelegate
- (void)dismissReaderViewController:(ReaderViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
