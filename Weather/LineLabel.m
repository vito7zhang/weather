//
//  LineLabel.m
//  Weather
//
//  Created by vito7zhang on 2017/3/18.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import "LineLabel.h"

@implementation LineLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, self.strokeColor.CGColor);
    CGContextSetLineWidth(ctx, 2);
    switch (_lineType) {
        case 0:{
            CGContextMoveToPoint(ctx, 0, 0);
            CGContextAddLineToPoint(ctx, rect.size.width, 0);
        }
            break;
        case 1:{
            CGContextMoveToPoint(ctx, 0, rect.size.height/2);
            CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height/2);
        }
            break;
        case 2:{
            CGContextMoveToPoint(ctx, 0, rect.size.height-2);
            CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height-2);
        }
            break;
        default:
        break;
    }
    CGContextStrokePath(ctx);

}
-(UIColor *)strokeColor{
    if (!_strokeColor) {
        _strokeColor = [UIColor blackColor];
    }
    return _strokeColor;
}


@end
