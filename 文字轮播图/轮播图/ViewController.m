//
//  ViewController.m
//  轮播图
//
//  Created by huhang on 15/11/4.
//  Copyright (c) 2015年 huhang. All rights reserved.
//

#import "ViewController.h"
#import "HU_ScycleScrollView.h"

@interface ViewController ()<ScyleScrollViewDelegate>
{
    HU_ScycleScrollView *_scyleSV;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *images = @[@"闻喜县交警队测速仪采购项目 再次竞争性谈判公告",@"我要展现给用户的内容放在scrollview中",@"让内容从上到底自动滚动，我最开始用的是DDAutoscrollview",@"如果需要开场动画的效果，在scrollView的viewcontroller实现"];
    
    _scyleSV = [[HU_ScycleScrollView alloc]initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 44)];
    _scyleSV.backgroundColor = [UIColor redColor];
    _scyleSV.titles = images;
    _scyleSV.userInteractionEnabled = YES;
    _scyleSV.delegate = self;
    [self.view addSubview:_scyleSV];
}

#pragma mark ScyleScrollViewDelegate
- (void)scyleScrollView:(HU_ScycleScrollView *)scyleView index:(NSInteger)index{
    NSLog(@"----- %ld",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
