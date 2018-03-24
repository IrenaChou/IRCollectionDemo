//
//  ViewController.m
//  IRCollectionDemo
//
//  Created by qiaoqiao on 2018/3/5.
//  Copyright © 2018年 irena. All rights reserved.
//

#import "ViewController.h"

#import "IRCollectionViewCell.h"

#import "IRCollectionHeaderView.h"
#import "IRCollectionFooterView.h"

@interface ViewController ()
    <UICollectionViewDataSource,
     UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView * mainCollectionView;
@property (strong, nonatomic) NSMutableArray   * items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainCollectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.items count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = self.items[section][@"sub_list"];
    return [array count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = self.items[indexPath.section][@"sub_list"];
    
    if ([array count]-1 == indexPath.item) {
        IRCollectionViewFouncCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IRCollectionViewFouncCell" forIndexPath:indexPath];
        return cell;
    }
    
    IRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IRCollectionViewCell" forIndexPath:indexPath];
    
    cell.item = array[indexPath.item];
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        IRCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IRCollectionHeaderView" forIndexPath:indexPath];
        
        NSString *value = self.items[indexPath.section][@"value"];
        headerView.showTitle = value;
        reusableview = headerView;
        
    }else if (kind == UICollectionElementKindSectionFooter){
        IRCollectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"IRCollectionFooterView" forIndexPath:indexPath];
        reusableview = footerView;
    }
    
    return reusableview;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = self.items[indexPath.section][@"sub_list"];
    
    if ([array count]-1 == indexPath.item) {
        return CGSizeMake(60, 85);
    }
    return CGSizeMake(40, 85);
}

#pragma mark - getter setter
-(UICollectionView *)mainCollectionView{
    if (!_mainCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
        layout.footerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 8);
        layout.itemSize = CGSizeMake(40, 85);
        layout.minimumInteritemSpacing = 19;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 19, 0, 19);
        
        
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate   = self;
        
        
        [_mainCollectionView registerClass:[IRCollectionViewCell class] forCellWithReuseIdentifier:@"IRCollectionViewCell"];
        
        [_mainCollectionView registerClass:[IRCollectionViewFouncCell class] forCellWithReuseIdentifier:@"IRCollectionViewFouncCell"];
        
        // header
        [_mainCollectionView registerClass:[IRCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IRCollectionHeaderView"];
        
        // footer
        [_mainCollectionView registerClass:[IRCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"IRCollectionFooterView"];
    }
    return _mainCollectionView;
}

-(NSMutableArray *)items{
    if(!_items){
        _items = [NSMutableArray array];
        // 加载本地json文件
        // 获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"json" ofType:@"json"];
        // 将文件数据化
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        
        // 对数据进行JSON格式化并返回字典形式
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"list"];
        
        for (NSDictionary *dict in array) {
            
            NSMutableArray *arrayM = [dict[@"sub_list"] mutableCopy];
            if ([arrayM count]) {
                [arrayM addObject:[arrayM lastObject]];
            }else{
                [arrayM addObject:@1];
            }
            
            NSMutableDictionary *dictM = [dict mutableCopy];
            [dictM setValue:[arrayM copy] forKey:@"sub_list"];
            
            [_items addObject:[dictM copy]];
        }
    }
    return _items;
}

@end

