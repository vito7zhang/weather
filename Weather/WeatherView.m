//
//  WeatherView.m
//  Weather
//
//  Created by vito7zhang on 2017/3/22.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView
- (instancetype)init
{
    
    self = [super init];
    if (self) {
        self.weatherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH/4-20, 40)];
        self.weatherImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.weatherImageView.image = [UIImage imageNamed:@"0"];
        [self addSubview:self.weatherImageView];
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH/4, 25)];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        self.dateLabel.textColor = TEXTCOLOR;
        self.dateLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.dateLabel];
        
        self.tempSectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH/4, 25)];
        self.tempSectionLabel.textColor = TEXTCOLOR;
        self.tempSectionLabel.textAlignment = NSTextAlignmentCenter;
        self.tempSectionLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.tempSectionLabel];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
