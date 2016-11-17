//
//  HLLTestColorViewController.m
//  PDFViewAndDownload
//
//  Created by Jeffrey hu on 16/11/17.
//  Copyright © 2016年 Jeffrey hu. All rights reserved.
//

#import "HLLTestColorViewController.h"

static NSString *kCellId = @"kCellId";

@interface HLLTestColorViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   NSMutableArray *titleArray;
@property (nonatomic, strong)   NSMutableArray *colorArray;

@end

@implementation HLLTestColorViewController

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
    // 颜色
    _colorArray = [NSMutableArray array];
    NSMutableArray *color1Array = [NSMutableArray arrayWithObjects:FlatBlack, FlatBlue, FlatBrown, FlatCoffee, FlatForestGreen, FlatGray, FlatGreen, FlatLime, FlatMagenta, FlatMaroon, FlatMint, FlatNavyBlue, FlatOrange, FlatPink, FlatPlum, FlatPowderBlue, FlatPurple, FlatRed, FlatSand, FlatSkyBlue, FlatTeal, FlatWatermelon, FlatWhite, FlatYellow, nil];
    NSMutableArray *color2Array = [NSMutableArray arrayWithObjects:FlatBlackDark, FlatBlueDark, FlatBrownDark, FlatCoffeeDark, FlatForestGreenDark, FlatGrayDark, FlatGreenDark, FlatLimeDark, FlatMagentaDark, FlatMaroonDark, FlatMintDark, FlatNavyBlueDark, FlatOrangeDark, FlatPinkDark, FlatPlumDark, FlatPowderBlueDark, FlatPurpleDark, FlatRedDark, FlatSandDark, FlatSkyBlueDark, FlatTealDark, FlatWatermelonDark, FlatWhiteDark, FlatYellowDark, nil];
    [self.colorArray addObject:color1Array];
    [self.colorArray addObject:color2Array];
    
    // 标题
    _titleArray = [NSMutableArray array];
    NSMutableArray *title1Array = [NSMutableArray arrayWithObjects:@"FlatBlack", @"FlatBlue", @"FlatBrown", @"FlatCoffee", @"FlatForestGreen", @"FlatGray", @"FlatGreen", @"FlatLime", @"FlatMagenta", @"FlatMaroon", @"FlatMint", @"FlatNavyBlue", @"FlatOrange", @"FlatPink", @"FlatPlum", @"FlatPowderBlue", @"FlatPruple", @"FlatRed", @"FlatSand", @"FlatSkyBlue", @"FlatTeal", @"FlatWatermelon", @"FlatWhite", @"FlatYellow", nil];
    NSMutableArray *title2Array = [NSMutableArray array];
    for (NSInteger i = 0; i < title1Array.count; i ++) {
        NSString *item = [NSString stringWithFormat:@"%@Dark", title1Array[i]];
        [title2Array addObject:item];
    }
    
    [self.titleArray addObject:title1Array];
    [self.titleArray addObject:title2Array];
}

- (void)setupSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.and.right.offset(0);
    }];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    cell.backgroundColor = self.colorArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
