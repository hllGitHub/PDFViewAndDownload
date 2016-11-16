//
//  HLLMenuCell.m
//  PDFViewAndDownload
//
//  Created by Jeffrey hu on 16/11/16.
//  Copyright © 2016年 Jeffrey hu. All rights reserved.
//

#import "HLLMenuCell.h"

@interface HLLMenuCell ()

@property (nonatomic, strong)   UILabel *titleLabel;

@end

@implementation HLLMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

// 初始化视图
- (void)initView {
    self.titleLabel = [UILabel new];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:15.f];
    self.titleLabel.textColor = [UIColor colorWithRed:0.3 green:0.6 blue:0.7 alpha:1.0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 布局
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.width.equalTo(@300);
        make.height.equalTo(@24);
        make.left.equalTo(@15);
    }];
}

#pragma mark - set
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}


@end
