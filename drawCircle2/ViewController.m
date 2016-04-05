//
//  ViewController.m
//  drawCircle2
//
//  Created by liyanbin on 16/3/29.
//  Copyright © 2016年 cn.baidu.com. All rights reserved.
//

#import "ViewController.h"
#import "LYBCircleView.h"
#import "UIView+Ex.h"
#import "LineProgressView.h"
#import "POPBasicAnimation.h"
@interface ViewController ()<LineProgressViewDelegate>

@property (weak, nonatomic) IBOutlet LYBIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet LYBCircleView *circle;
@property (nonatomic, assign) CGFloat randomIndex;
@property (weak, nonatomic) IBOutlet UILabel *count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)startAction:(UIButton *)sender {

    CGFloat randomIndex = arc4random_uniform(100);
    
    POPBasicAnimation *anim = [POPBasicAnimation animation];
    anim.duration = 1.5f;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) { prop.readBlock = ^(id obj, CGFloat values[]) {
        values[0] = [[obj description] floatValue];};
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            [obj setText:[NSString stringWithFormat:@"%.2f",values[0]]];};
        prop.threshold = 0.1;}];
    anim.property = prop;
    anim.fromValue = @(0.0);
    anim.toValue = @(randomIndex);
    [self.count pop_addAnimation:anim forKey:@"counting"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.circle.indicatorView = self.indicatorView;
        self.circle.persentage = randomIndex / 100.0;
    });
}
@end
