//
//  HU_ScycleScrollView.m
//  轮播图
//
//  Created by huhang on 15/11/4.
//  Copyright (c) 2015年 huhang. All rights reserved.
//

#import "HU_ScycleScrollView.h"
#define SCYLE_WIDTH CGRectGetWidth(self.frame)
#define SCYLE_HEIGHT CGRectGetHeight(self.frame)

@interface HU_ScycleScrollView()<UIScrollViewDelegate>

/** 延迟时间 */
@property (nonatomic,assign)NSTimeInterval intervalTime;
/** 滑动视图 */
@property (nonatomic,strong)UIScrollView *scrollView;
/** 延时器 */
@property (nonatomic,strong)NSTimer *delayTimer;

/** 目前标题 */
@property (nonatomic,strong)UILabel *currentTitleView;
/** 目前标题位置 */
@property (nonatomic,assign)NSInteger currentTitIndex;

/** 下一个标题 */
@property (nonatomic,strong)UILabel *nextTitleView;
/** 下一个标题的位置 */
@property (nonatomic,assign)NSInteger nextTitIndex;

@end

@implementation HU_ScycleScrollView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        self.intervalTime = 3;
        [self setupScycleView];
    }
    return self;
}

#pragma mark 创建视图
- (void)setupScycleView{
 
    //添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.userInteractionEnabled = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(SCYLE_WIDTH, SCYLE_HEIGHT * 2);
    scrollView.contentOffset = CGPointMake(0, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    //创建3个UILabel
    [self setupThreeTitleView];
    
}

- (void)setupThreeTitleView{
    
    //目前标题
    UILabel *currentTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCYLE_WIDTH, SCYLE_HEIGHT)];
    currentTitleView.userInteractionEnabled = YES;
    [self.scrollView addSubview:currentTitleView];
    self.currentTitleView = currentTitleView;
    //给目前标题添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTheCurrentImgAction:)];
    [self addGestureRecognizer:tap];
    
    //下一个标题
    UILabel *nextTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, SCYLE_HEIGHT, SCYLE_WIDTH, SCYLE_HEIGHT)];
    [self.scrollView addSubview:nextTitleView];
    self.nextTitleView = nextTitleView;
}

- (void)setTitles:(NSArray *)titles{

    _titles = titles;
    //创建延时器
    [self renewSetDelayTimer];
    
    //更新图片位置
    [self updateScycelScrollViewTitleIndex];
}

#pragma mark 更新图片位置
- (void)updateScycelScrollViewTitleIndex{
 
    if (self.titles.count > 0) {
        [self addTheTitleUrlStr:self.titles[self.currentTitIndex] titleView:_currentTitleView];
        [self addTheTitleUrlStr:self.titles[self.nextTitIndex] titleView:_nextTitleView];
    }
}

#pragma mark 解析图片并添加到imageView上
- (void)addTheTitleUrlStr:(NSString *)title titleView:(UILabel *)titleView{
    
    titleView.text = title;
    
}

#pragma mark 延时器执行方法
- (void)useTimerIntervalUpdateScrollViewContentOffSet:(NSTimer *)timer{
    [_scrollView setContentOffset:CGPointMake(0, SCYLE_HEIGHT) animated:YES];
}

#pragma mark 点击图片执行方法
- (void)clickTheCurrentImgAction:(UITapGestureRecognizer *)tap{
    if ([_delegate respondsToSelector:@selector(scyleScrollView:index:)]) {
        [self.delegate scyleScrollView:self index:_currentTitIndex];
    }
}

#pragma mark 滑动结束时停止动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

#pragma mark 减速滑动时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int offSet = floor(scrollView.contentOffset.y);
    if (offSet == SCYLE_HEIGHT){
        self.currentTitIndex = self.nextTitIndex;
    }
    
    //更新标题位置
    [self updateScycelScrollViewTitleIndex];
    //设置偏移量
    scrollView.contentOffset = CGPointMake(0, 0);
}

#pragma mark 重新设置延时器
- (void)renewSetDelayTimer{
    //添加延迟器
    self.delayTimer = [NSTimer scheduledTimerWithTimeInterval:self.intervalTime target:self selector:@selector(useTimerIntervalUpdateScrollViewContentOffSet:) userInfo:nil repeats:YES];
    //加入事件循环中
    [[NSRunLoop mainRunLoop] addTimer:self.delayTimer forMode:NSRunLoopCommonModes];
}

//上一个标题位置
- (NSUInteger)beforeTitIndex{
    
    if (self.currentTitIndex == 0) {
        return self.titles.count - 1;
    }else{
        return self.currentTitIndex - 1;
    }
}

//下一个标题的位置
- (NSInteger)nextTitIndex{
    
    if (self.currentTitIndex < (self.titles.count - 1)) {
        return self.currentTitIndex + 1;
    }else{
        return 0;
    }
}

@end
