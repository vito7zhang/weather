//
//  DetailView.m
//  Weather
//
//  Created by vito7zhang on 2017/3/22.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import "DetailView.h"
@interface DetailView()
@property (nonatomic,weak)NSArray <UILabel *> *dateLabel;
@property (nonatomic,weak)NSArray <UIImageView *> *weatherImageViews;
@end

@implementation DetailView

-(instancetype)init{
    if (self = [super init]) {
        _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _downButton.frame = CGRectMake(SCREEN_WIDTH/2-10, 0, 20, 20);
        [_downButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self addSubview:_downButton];
        
        for (int i = 0; i < 7; i++) {
            UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/7*i, 20, SCREEN_WIDTH/7, 20)];
            dateLabel.textColor = TEXTCOLOR;
            dateLabel.textAlignment = NSTextAlignmentCenter;
//            dateLabel.text = detailArray
            [self addSubview:dateLabel];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/7*i+17, 50, 35, 35)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:imageView];
//            dateLabel.text = @"";
        }
    }
    return self;
}
-(void)setDateArr:(NSArray *)dateArr{
    _dateArr = dateArr;
    int index = 0;
    for (int i = 0; i < self.subviews.count; i++) {
        if ([self.subviews[i] isMemberOfClass:[UILabel class]]) {
            UILabel *label = self.subviews[i];
            label.text = dateArr[index];
            index++;
        }
    }
}
-(void)setImgArr:(NSArray *)imgArr{
    _imgArr = imgArr;
    int index = 0;
    for (int i = 0; i < self.subviews.count; i++) {
        if ([self.subviews[i] isMemberOfClass:[UIImageView class]]) {
            UIImageView *label = self.subviews[i];
            label.image = [UIImage imageNamed:imgArr[index]];
            index++;
        }
    }
}

-(void)setTempLowArr:(NSArray *)tempLowArr{
    _tempLowArr = tempLowArr;
    [self setNeedsDisplay];
}
-(void)setTempHighArr:(NSArray *)tempHighArr{
    _tempHighArr = tempHighArr;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (_tempHighArr.count > 0 & _tempLowArr.count > 0) {
        int max = [_tempHighArr[0] intValue];
        int min = [_tempLowArr[0] intValue];
        for (int i = 0; i < _tempHighArr.count; i++) {
            max = max > [_tempHighArr[i] intValue] ? max : [_tempHighArr[i] intValue];
            min = min > [_tempLowArr[i] intValue] ? min : [_tempLowArr[i] intValue];
        }
        //画线
        UIBezierPath *bezier = [UIBezierPath bezierPath];
        [bezier setLineWidth:2];
        [bezier moveToPoint:CGPointMake(SCREEN_WIDTH/7/2, max - [_tempHighArr[0] intValue] + 115)];
        for (int i = 1;i < _tempHighArr.count; i++) {
            [bezier addLineToPoint:CGPointMake(SCREEN_WIDTH/7/2+SCREEN_WIDTH/7*i, max - [_tempHighArr[i] intValue] + 115)];
        }
        [TEXTCOLOR setStroke];
        [bezier stroke];

        bezier = [UIBezierPath bezierPath];
        [bezier setLineWidth:2];
        [bezier moveToPoint:CGPointMake(SCREEN_WIDTH/7/2, 160 - [_tempLowArr[0] intValue] + min)];
        for (int i = 1;i < _tempLowArr.count; i++) {
            [bezier addLineToPoint:CGPointMake(SCREEN_WIDTH/7/2+SCREEN_WIDTH/7*i, 160 - [_tempLowArr[i] intValue] + min)];
        }
        [[UIColor greenColor] setStroke];
        [bezier stroke];
        //画点
        for (int i = 0; i < _tempHighArr.count; i++) {
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH/7/2+SCREEN_WIDTH/7*i, max - [_tempHighArr[i] intValue] + 115) radius:4 startAngle:0 endAngle:2*M_PI clockwise:0];
            [TEXTCOLOR setFill];
            [path fill];
            
            path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH/7/2+SCREEN_WIDTH/7*i, 160 - [_tempLowArr[i] intValue] + min) radius:4 startAngle:0 endAngle:2*M_PI clockwise:0];
            [[UIColor greenColor] setFill];
            [path fill];
            
            UILabel *highLabel = [UILabel new];
            highLabel.text = [NSString stringWithFormat:@"%@°C",_tempHighArr[i]];
            highLabel.textColor = TEXTCOLOR;
            highLabel.textAlignment = NSTextAlignmentCenter;
            [highLabel drawTextInRect:CGRectMake(SCREEN_WIDTH/7*i, max - [_tempHighArr[i] intValue] + 115 - 23, SCREEN_WIDTH/7, 20)];
            
            UILabel *lowLabel = [UILabel new];
            lowLabel.text = [NSString stringWithFormat:@"%@°C",_tempLowArr[i]];
            lowLabel.textColor = [UIColor greenColor];
            lowLabel.textAlignment = NSTextAlignmentCenter;
            [lowLabel drawTextInRect:CGRectMake(SCREEN_WIDTH/7*i, 160 - [_tempLowArr[i] intValue] + min + 3, SCREEN_WIDTH/7, 20)];
        }
        
        
    }
    
}


@end
