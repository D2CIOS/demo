//
//  ViewController.m
//  demo
//
//  Created by 翟泉 on 16/3/23.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ViewController.h"
#import "ESTabView.h"

@interface ViewController ()
<UIScrollViewDelegate, UICollectionViewDataSource, ESTabViewDelegate>
{
    UIScrollView *_scrollView;
    UIScrollView *_scrollView0;
    UIScrollView *_scrollView1;
    UIScrollView *_scrollView2;
    
    ESTabView *_tabView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
//    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 400)];
//    _scrollView.backgroundColor = [UIColor orangeColor];
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 100)];
//    view.backgroundColor = [UIColor greenColor];
//    
//    _scrollView0 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, _scrollView.frame.size.width, 400)];
//    _scrollView0.backgroundColor = [UIColor blueColor];
//    _scrollView0.pagingEnabled = YES;
//    
//    
//    _scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 400)];
//    _scrollView1.backgroundColor = [UIColor redColor];
//    
//    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 400)];
//    v1.backgroundColor = [UIColor blackColor];
//    [_scrollView1 addSubview:v1];
//    
//    _scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, 350)];
//    _scrollView2.backgroundColor = [UIColor yellowColor];
//    
//    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(20, 50, 100, 400)];
//    v2.backgroundColor = [UIColor blackColor];
//    [_scrollView2 addSubview:v2];
//    
//    
//    [_scrollView0 addSubview:_scrollView1];
//    [_scrollView0 addSubview:_scrollView2];
//    
//    
//    [_scrollView addSubview:view];
//    [_scrollView addSubview:_scrollView0];
//    
//    
//    [self.view addSubview:_scrollView];
//    
//    
//    _scrollView0.contentSize = CGSizeMake(_scrollView.frame.size.width*2, 300);
//    
//    _scrollView.delegate = self;
//    _scrollView0.delegate = self;
//    
//    _scrollView1.contentSize = CGSizeMake(0, 2000);
//    _scrollView2.contentSize = CGSizeMake(0, 4000);
//    
//    
//    _scrollView1.scrollEnabled = NO;
//    _scrollView2.scrollEnabled = NO;
//    
//    [self scrollViewDidEndDecelerating:_scrollView0];
}

bool bl = true;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; {
    NSLog(@"%s", __FUNCTION__);
    if (scrollView == _scrollView0) {
        NSInteger index = _scrollView0.contentOffset.x / _scrollView0.frame.size.width;
        NSLog(@"%ld", index);
        
        bl = false;
        if (index == 0) {
            _scrollView.contentSize = CGSizeMake(0, 100 + _scrollView1.contentSize.height);
        }
        else {
            _scrollView.contentSize = CGSizeMake(0, 100 + _scrollView2.contentSize.height);
        }
        bl = true;
        
        
        if (_scrollView.contentOffset.y >= 100) {
            if (index == 0) {
                _scrollView.contentOffset = CGPointMake(0, 100 + _scrollView1.contentOffset.y);
            }
            else {
                _scrollView.contentOffset = CGPointMake(0, 100 + _scrollView2.contentOffset.y);
            }
        }
        
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    if (scrollView == _scrollView) {
        if (!bl) {
            return;
        }
        
        NSLog(@"%lf", scrollView.contentOffset.y);
        
        if (scrollView.contentOffset.y >= 100) {
            CGFloat offset = scrollView.contentOffset.y - _scrollView0.frame.origin.y;
            if (offset != 0) {
                _scrollView0.transform = CGAffineTransformTranslate(_scrollView0.transform, 0, offset);
            }
            
            
            NSInteger index = _scrollView0.contentOffset.x / _scrollView0.frame.size.width;
            if (index == 0) {
                _scrollView1.contentOffset = CGPointMake(0, _scrollView.contentOffset.y - 100);
            }
            else {
                _scrollView2.contentOffset = CGPointMake(0, _scrollView.contentOffset.y - 100);
            }
            
        }
        else {
            CGFloat offset = 100 - _scrollView0.frame.origin.y;
            if (offset != 0) {
                _scrollView0.transform = CGAffineTransformTranslate(_scrollView0.transform, 0, offset);
            }
            
            
            NSInteger index = _scrollView0.contentOffset.x / _scrollView0.frame.size.width;
            if (index == 0) {
                _scrollView1.contentOffset = CGPointMake(0, 0);
            }
            else {
                _scrollView2.contentOffset = CGPointMake(0, 0);
            }
        }
    }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView; {
    NSLog(@"%s", __FUNCTION__);
//    self.index = (NSInteger)self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
