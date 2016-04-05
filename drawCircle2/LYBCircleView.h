//
//  LYBCircleView.h
//  drawCircle2
//
//  Created by liyanbin on 16/3/29.
//  Copyright © 2016年 cn.baidu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYBIndicatorView;
@interface LYBCircleView : UIView
@property (assign, nonatomic) CGFloat persentage;
/**
 *  内部指针的View(需根据指针图片大小自行设置)
 */
@property (nonatomic, strong) LYBIndicatorView *indicatorView;


@end
