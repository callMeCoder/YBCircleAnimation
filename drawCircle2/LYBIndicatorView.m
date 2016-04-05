//
//  LYBIndicatorView.m
//  drawCircle2
//
//  Created by liyanbin on 16/3/29.
//  Copyright © 2016年 cn.baidu.com. All rights reserved.
//

#import "LYBIndicatorView.h"
#import "UIView+Ex.h"
#import "POPSpringAnimation.h"
#define DEGREES_TO_RADOANS(x) (M_PI * (x) / 180.0)

@interface LYBIndicatorView ()

@property (nonatomic, strong) UIImageView *image;

@end

@implementation LYBIndicatorView

- (void)awakeFromNib
{
    UIImageView *image = [[UIImageView alloc] init];
    self.image = image;
    image.image = [UIImage imageNamed:@"png_zhizhen"];
    [image sizeToFit];
    image.layer.anchorPoint = CGPointMake(.75, 0.25);
    image.centerX = self.width * 0.5 ;
    image.centerY = self.height  * 0.5;
    [self addSubview:image];
}
- (void)setAngel:(NSInteger)angel
{
    _angel = angel;
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    strokeAnimation.toValue = @(DEGREES_TO_RADOANS(angel));
    strokeAnimation.springBounciness = 12.f;
    strokeAnimation.removedOnCompletion = NO;
    [self.image.layer pop_addAnimation:strokeAnimation forKey:@"kPOPLayerRotation"];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UILabel *label = [[UILabel alloc] init];
        label.text = self.indexStr;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:20];
        [label sizeToFit];
        label.centerX = self.width * 0.5;
        label.y = self.height - 40;
        [self addSubview:label];
        
        POPSpringAnimation *ani1 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        ani1.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
        ani1.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        ani1.springBounciness = 12.f;
        ani1.springSpeed = 4;
        [label pop_addAnimation:ani1 forKey:@"ani2"];
    });
//    self.image.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADOANS(angel));
    
//    if (angel == 240) {
//        [UIView animateWithDuration:.25f animations:^{
//            self.image.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADOANS(angel + 20));
//        }];
//    }
}
@end
