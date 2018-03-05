//
//  IRCollectionHeaderView.m
//  IRTmpTestDemo
//
//  Created by qiaoqiao on 2018/3/5.
//  Copyright © 2018年 irena. All rights reserved.
//

#import "IRCollectionHeaderView.h"

#import <Masonry.h>

@interface IRCollectionHeaderView()

@property (strong, nonatomic) UILabel * showTitleLabel;
@property (strong, nonatomic) UIView  * lineView;

@end

@implementation IRCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.showTitleLabel];
        [self addSubview:self.lineView];
        
        [self.showTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.height.mas_equalTo(self);
            make.centerX.equalTo(self);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(self.showTitleLabel.mas_bottom);
        }];
    }
    return self;
}

-(void)setShowTitle:(NSString *)showTitle{
    _showTitle = showTitle;
    
    self.showTitleLabel.text = showTitle;
}
#pragma mark - getter setter
-(UILabel *)showTitleLabel{
    if (!_showTitleLabel) {
        _showTitleLabel = [[UILabel alloc]init];
        _showTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _showTitleLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:246/255.0 alpha:1];
    }
    return _lineView;
}

@end
