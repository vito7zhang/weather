//
//  WeatherModel.m
//  Weather
//
//  Created by vito7zhang on 2017/3/21.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel
+(instancetype)weatherWithModel:(NSDictionary *)json{
    return [[self alloc]initWithModel:json];
}
-(instancetype)initWithModel:(NSDictionary *)json{
    if (self = [super init]) {
        self.date = json[@"date"];
        self.week = json[@"week"];
        self.weather = json[@"day"][@"weather"];
        self.img = json[@"day"][@"img"];
        self.tempLow = json[@"night"][@"templow"];
        self.tempHigh = json[@"day"][@"temphigh"];
    }
    return self;
}
@end
