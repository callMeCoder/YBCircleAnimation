//
//  LineProgressView.h
//  Layer
//
//  Created by Carver Li on 14-12-1.
//
//

#import <UIKit/UIKit.h>
#import "LineProgressLayer.h"

@class LineProgressView;

@protocol LineProgressViewDelegate <NSObject>
@optional
- (void)LineProgressViewAnimationDidStart:(LineProgressView *)lineProgressView;
- (void)LineProgressViewAnimationDidStop:(LineProgressView *)lineProgressView;

@end
@interface LineProgressView : UIView
/**
 *  画线的个数
 */
@property (nonatomic,assign) int total;
/**
 *  默认颜色
 */
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign) int completed;
/**
 *  覆盖后的颜色
 */
@property (nonatomic,strong) UIColor *completedColor;
/**
 *  外部大圆半径
 */
@property (nonatomic,assign) CGFloat radius;
/**
 *  内部小圆半径
 */
@property (nonatomic,assign) CGFloat innerRadius;
/**
 *  开始角度
 */
@property (nonatomic,assign) CGFloat startAngle;
/**
 *  结束角度
 */
@property (nonatomic,assign) CGFloat endAngle;

@property (nonatomic, assign) CFTimeInterval animationDuration;
@property (nonatomic,weak) id<LineProgressViewDelegate>delegate;

- (void)setCompleted:(int)completed animated:(BOOL)animated;

@end


