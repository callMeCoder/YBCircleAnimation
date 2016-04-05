//
//  LYBCircleView.m
//  drawCircle2
//
//  Created by liyanbin on 16/3/29.
//  Copyright © 2016年 cn.baidu.com. All rights reserved.
//

#import "LYBCircleView.h"
#import "UIView+Ex.h"
#import "LYBIndicatorView.h"
#import "POPSpringAnimation.h"
@interface LYBCircleView ()
@property (strong, nonatomic) CAShapeLayer *colorMaskLayer; // 渐变色遮罩
@property (strong, nonatomic) CAShapeLayer *colorLayer; // 渐变色
@property (nonatomic, strong) CADisplayLink *link;

@end
/**
 *  角度转弧度
 *
 *  @param x 角度
 *
 *  @return 弧度
 */
#define DEGREES_TO_RADOANS(x) (M_PI * (x) / 180.0)
@implementation LYBCircleView
- (void)awakeFromNib
{
    [self setupGrayMaskLayer];
    [self setupColorLayer];
    [self setupColorMaskLayer];
    _persentage = 0;
    self.colorMaskLayer.strokeEnd = 0;
}
/**
 *  生成一个圆环形的遮罩层
 *  因为蓝色遮罩与渐变遮罩的配置都相同，所以封装出来
 *
 *  @return 环形遮罩
 */
- (CAShapeLayer *)generateMaskLayer {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    
    // 创建一个圆心为父视图中点的圆，半径为父视图宽的2/5，起始角度是从-240°到60°
    
    UIBezierPath *path = nil;
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2) radius:self.width / 2.5 startAngle:DEGREES_TO_RADOANS(-220) endAngle:DEGREES_TO_RADOANS(40) clockwise:YES];

    layer.lineWidth = 10;
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor; // 填充色为透明（不设置为黑色）
    layer.strokeColor = [UIColor blackColor].CGColor; // 随便设置一个边框颜色
    layer.lineCap = kCALineCapRound; // 设置线为圆角
    return layer;
}
/**
 *  设置整个灰色view的遮罩
 */
- (void)setupGrayMaskLayer {
    CAShapeLayer *layer = [self generateMaskLayer];
    self.layer.mask = layer;
}
/**
 *  设置蓝色layer
 */
- (void)setupColorLayer
{    
    self.colorLayer = [CAShapeLayer layer];
    self.colorLayer.frame = self.bounds;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0].CGColor;
    [self.layer addSublayer:self.colorLayer];
    
//    self.colorLayer = [CAShapeLayer layer];
//    self.colorLayer.frame = self.bounds;
//    [self.layer addSublayer:self.colorLayer];
//    CAGradientLayer *leftLayer = [CAGradientLayer layer];
//    leftLayer.frame = CGRectMake(0, 0, self.width / 2, self.height);
    // 分段设置渐变色
//    leftLayer.locations = @[@0.3, @0.9, @1];
//    leftLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor greenColor].CGColor];
//    [self.colorLayer addSublayer:leftLayer];
//    
//    CAGradientLayer *rightLayer = [CAGradientLayer layer];
//    rightLayer.frame = CGRectMake(self.width / 2, 0, self.width / 2, self.height);
//    rightLayer.locations = @[@0.3, @0.9, @1];
//    rightLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor];
//    [self.colorLayer addSublayer:rightLayer];
}

- (void)setupColorMaskLayer
{
    CAShapeLayer *layer = [self generateMaskLayer];
    layer.lineWidth = 10 + 0.5; // 渐变遮罩线宽较大，防止蓝色遮罩有边露出来
    self.colorLayer.mask = layer;
    self.colorMaskLayer = layer;
}
- (void)setPersentage:(CGFloat)persentage {
    
    _persentage = persentage;
    self.colorMaskLayer.strokeEnd = 0.0f;
    self.indicatorView.angel = _persentage * 260;
    self.indicatorView.indexStr = [NSString stringWithFormat:@"¥%.2f",_persentage * 100];
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.toValue = @(_persentage);
    strokeAnimation.springBounciness = 12.f;
    strokeAnimation.removedOnCompletion = NO;
    [self.colorMaskLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
}
- (void)plusPersentage
{
    _persentage += 0.005;
    if ((int)_persentage == 0.5) {
        [self.link invalidate];
    }
}
@end
