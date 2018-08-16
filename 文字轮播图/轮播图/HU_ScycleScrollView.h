//
//  HU_ScycleScrollView.h
//  轮播图
//
//  Created by huhang on 15/11/4.
//  Copyright (c) 2015年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, pageControlAligment){
  
    pageControlAligmentCenter = 0,
    pageControlAligmentLeft
};

@class HU_ScycleScrollView;
@protocol ScyleScrollViewDelegate <NSObject>

- (void)scyleScrollView:(HU_ScycleScrollView *)scyleView index:(NSInteger)index;

@end


@interface HU_ScycleScrollView : UIView

/** 标题数组 */
@property (nonatomic,strong)NSArray *titles;

/** 协议 */
@property (nonatomic,assign)id<ScyleScrollViewDelegate> delegate;

@end
