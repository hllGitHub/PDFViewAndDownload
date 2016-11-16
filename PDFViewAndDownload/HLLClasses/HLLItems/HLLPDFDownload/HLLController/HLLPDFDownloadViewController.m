//
//  HLLPDFDownloadViewController.m
//  PDFViewAndDownload
//
//  Created by Jeffrey hu on 16/11/16.
//  Copyright © 2016年 Jeffrey hu. All rights reserved.
//

#import "HLLPDFDownloadViewController.h"
#import "HLLMenuCell.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <AFURLSessionManager.h>

static NSString *kCellId = @"kCellId";

@interface HLLPDFDownloadViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   NSMutableArray *titleArray;

@end

@implementation HLLPDFDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeData];
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialize data and view
- (void)initializeData {
    self.titleArray = [NSMutableArray array];
    [self.titleArray addObject:@"NSData"];
    [self.titleArray addObject:@"AFnetworking"];
}

- (void)setupSubViews {
    self.navigationController.navigationItem.title = @"PDFDownload";
    
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
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"guide.pdf"];
    
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"NSData!");
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                NSLog(@"已经有该文件了");
                return;
            }
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:PDF_URL]];
            
            BOOL isWrite = [data writeToFile:filePath atomically:YES];
            if (isWrite) {
                NSLog(@"保存成功");
            } else {
                NSLog(@"写入失败");
            }
            break;
        }
        case 1:
        {
            NSLog(@"AFnetworking");
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                NSLog(@"已经有该文件了");
                return;
            }
            
            //创建 Request
            NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
            
            //下载进行中的事件
            AFURLConnectionOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:YES];
            
            [SVProgressHUD show];
            
            [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
                float progress =  (float)totalBytesRead / totalBytesExpectedToRead;
                //下载完成
                //该方法会在下载完成后立即执行
                if (progress == 1.0) {
                    NSLog(@"下载成功");
                }
            }];
            
            //下载完成的事件
            [operation setCompletionBlock:^{
                NSLog(@"PDF成功了");
                [SVProgressHUD dismiss];
            }];
            
            [operation start];
            break;
        }
            
        default:
            break;
    }
}


@end
