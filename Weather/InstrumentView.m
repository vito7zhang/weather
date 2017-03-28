//
//  InstrumentView.m
//  Weather
//
//  Created by vito7zhang on 2017/3/22.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import "InstrumentView.h"
#import <math.h>

@interface InstrumentView()
@property (nonatomic,strong)CAShapeLayer *trackLayer;
@property (nonatomic,strong)CAShapeLayer *progressLayer;
@end
@implementation InstrumentView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:SCREEN_WIDTH/2-200/2 startAngle:M_PI*2/3 endAngle:M_PI*2+M_PI/3 clockwise:1];
//    [self.layer addSublayer:_trackLayer];
//    _trackLayer = [CAShapeLayer layer];//创建一个track shape layer
//    _trackLayer.frame = self.bounds;
//    _trackLayer.fillColor = [[UIColor clearColor] CGColor];
//    _trackLayer.strokeColor = [[UIColor whiteColor] CGColor];//指定path的渲染颜色
//    _trackLayer.opacity = 0.25; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
//    _trackLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
//    _trackLayer.lineWidth = 10;//线的宽度
//    _trackLayer.path =[path CGPath];
    
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor  = [TEXTCOLOR CGColor];
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = 30;
    _progressLayer.path = [path CGPath];
    //_progressLayer.strokeEnd = 0;
    
    CALayer *gradientLayer = [CALayer layer];
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, 0, rect.size.width/2, rect.size.height);
    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[[UIColor greenColor] CGColor],(id)[[UIColor yellowColor] CGColor], nil]];
    [gradientLayer1 setLocations:@[@0.5,@0.9,@1 ]];
    [gradientLayer1 setStartPoint:CGPointMake(0, 1)];
    [gradientLayer1 setEndPoint:CGPointMake(1, 0)];
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 =  [CAGradientLayer layer];
    [gradientLayer2 setLocations:@[@0.1,@0.5,@1]];
    gradientLayer2.frame = CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height);
    [gradientLayer2 setColors:[NSArray arrayWithObjects:(id)[[UIColor yellowColor] CGColor],(id)[[UIColor redColor] CGColor], nil]];
    [gradientLayer2 setStartPoint:CGPointMake(0, 0)];
    [gradientLayer2 setEndPoint:CGPointMake(1, 1)];
    [gradientLayer addSublayer:gradientLayer2];
    
    
    
    [gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
    [self.layer addSublayer:gradientLayer];
    
    NSArray *numberArr = @[@50,@100,@150,@200,@300,@500];
    for (int i = 0; i < numberArr.count; i++) {
        CATextLayer *textLayer = [[CATextLayer alloc]init];
        textLayer.bounds = CGRectMake(0, 0, 30, 30);
        //textLayer.position = CGPointMake(rect.size.width/2 - sin(M_PI/6)*(SCREEN_WIDTH/2-200/2), <#CGFloat y#>)
        textLayer.string = (id)[NSString stringWithFormat:@"%@",numberArr[i]];
        
        [gradientLayer setMask:textLayer];
        
    }
}


@end
