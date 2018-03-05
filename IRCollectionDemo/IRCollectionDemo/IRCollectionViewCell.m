//
//  IRCollectionViewCell.m
//  IRTmpTestDemo
//
//  Created by qiaoqiao on 2018/3/5.
//  Copyright © 2018年 irena. All rights reserved.
//

#import "IRCollectionViewCell.h"

#import <Masonry.h>

@interface IRCollectionViewCell()

@property (strong, nonatomic) UIImageView * iconImageView;
@property (strong, nonatomic) UILabel     * desLabel;

@end

@implementation IRCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.desLabel];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(self.mas_width);
            make.top.mas_equalTo(15);
        }];
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
            make.width.mas_equalTo(self);
        }];
    }
    return self;
}
-(void)setItem:(NSDictionary *)item{
    _item = item;
    
    self.desLabel.text = item[@"value"];
    
    if ([item[@"icon_url"] length]) {
        NSURL *url = [NSURL URLWithString:item[@"icon_url"]];
        UIImage *iconImage = [UIImage imageWithData:[[NSData alloc]initWithContentsOfURL:url]];
        self.iconImageView.image = iconImage;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    _iconImageView.layer.cornerRadius = _iconImageView.frame.size.width * 0.5;
    _iconImageView.layer.masksToBounds = YES;
}

#pragma mark - getter setter

-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.backgroundColor = [UIColor grayColor];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}
-(UILabel *)desLabel{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]init];
        _desLabel.font = [UIFont systemFontOfSize:10];
        _desLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _desLabel;
}
@end

@interface IRCollectionViewFouncCell()

@property (strong, nonatomic) UIButton * addButton;
@property (strong, nonatomic) UIButton * cutButton;

@end

@implementation IRCollectionViewFouncCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addButton];
        [self addSubview:self.cutButton];
        
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(24);
            make.centerY.mas_equalTo(self);
        }];
        
        [self.cutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(24);
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.addButton.mas_right).offset(8);
        }];

    }
    return self;
}
#pragma mark - action
-(void)addButtonAction{
    NSLog(@"您点击了添加按钮");
}
-(void)cutButtonAction{
    NSLog(@"您点击了减少按钮");
}

#pragma mark - getter setter

-(UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
-(UIButton *)cutButton{
    if (!_cutButton) {
        _cutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cutButton setImage:[UIImage imageNamed:@"cut"] forState:UIControlStateNormal];
        [_cutButton addTarget:self action:@selector(cutButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cutButton;
}
@end

