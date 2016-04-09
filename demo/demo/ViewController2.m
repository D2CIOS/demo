//
//  ViewController2.m
//  demo
//
//  Created by 翟泉 on 16/3/26.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ViewController2.h"
#import "ESTabView.h"

@interface ViewController2 ()
<UIScrollViewDelegate, UICollectionViewDataSource, ESTabViewDelegate>
{
    UIScrollView *_scrollView;
    ESTabView *_tabView;
}
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 400)];
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.delegate = self;
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 100)];
//    view.backgroundColor = [UIColor greenColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.itemSize = CGSizeMake(80, 80);
    
    UICollectionView *collection1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 400) collectionViewLayout:flowLayout];
    collection1.dataSource = self;
    collection1.backgroundColor = [UIColor orangeColor];
    collection1.scrollEnabled = NO;
    collection1.tag = 1;
    [collection1 registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AAA"];
    
    UICollectionView *collection2 = [[UICollectionView alloc] initWithFrame:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, 350) collectionViewLayout:flowLayout];
    collection2.dataSource = self;
    collection2.backgroundColor = [UIColor yellowColor];
    collection2.scrollEnabled = NO;
    [collection2 registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AAA"];
    
    _tabView = [[ESTabView alloc] initWithFrame:CGRectMake(0, 100, _scrollView.frame.size.width, 400)];
    _tabView.delegate = self;
    [_tabView setItemsWithViews:@[collection1, collection2] titles:@[@"推荐", @"轻奢潮牌"]];
    [_scrollView addSubview:_tabView];
    
    
    [self.view addSubview:_scrollView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self tabView:_tabView didMoveToIndex:0];
    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    return 40;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AAA" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
    return cell;
}

#pragma mark - ESTabViewDelegate
- (void)tabView:(ESTabView *)tabView didMoveToIndex:(NSInteger)index; {
    UIScrollView *sc = [tabView contentViewWithIndex:index];
    _scrollView.contentSize = CGSizeMake(0, 100 + sc.contentSize.height+TabBarHeight);
    if (_scrollView.contentOffset.y >= 100) {
        CGFloat offsetY = 100 + sc.contentOffset.y;
        _scrollView.contentOffset = CGPointMake(0, offsetY);
    }
    else {
        sc.contentOffset = CGPointZero;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    if (scrollView == _scrollView) {
        UIScrollView *sc = [_tabView contentViewWithIndex:_tabView.currentIndex];
        CGFloat offset;
        if (scrollView.contentOffset.y >= 100) {
            offset = scrollView.contentOffset.y - _tabView.frame.origin.y;
            sc.contentOffset = CGPointMake(0, _scrollView.contentOffset.y - 100);
        }
        else {
            offset = 100 - _tabView.frame.origin.y;
            sc.contentOffset = CGPointMake(0, 0);
        }
        if (offset != 0) {
            _tabView.transform = CGAffineTransformTranslate(_tabView.transform, 0, offset);
        }
    }
}

@end
