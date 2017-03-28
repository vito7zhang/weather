//
//  DetailModel.m
//  Weather
//
//  Created by vito7zhang on 2017/3/21.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import "DetailModel.h"

@implementation AQI

@end
@implementation Hourly

@end
@implementation LifeIndex

@end
@implementation DetailModel
+(instancetype)detailWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}
-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.city = dic[@"city"];
        self.temp = dic[@"temp"];
        self.tempHigh = dic[@"temphigh"];
        self.tempLow = dic[@"templow"];
        self.weather = dic[@"weather"];
        
        NSDictionary *aqi = dic[@"aqi"];
        self.pm2_5 = aqi[@"pm2_5"];
        AQI *a = [AQI new];
        a.pm10 = aqi[@"pm10"];
        a.pm2_5 = aqi[@"pm2_5"];
        a.no2 = aqi[@"no2"];
        a.so2 = aqi[@"so2"];
        a.co = aqi[@"co"];
        a.o3 = aqi[@"o3"];
        a.quality = aqi[@"quality"];
        a.level = aqi[@"aqiinfo"][@"level"];
        a.color = aqi[@"aqiinfo"][@"color"];
        a.affect = aqi[@"aqiinfo"][@"affect"];
        a.measure = aqi[@"aqiinfo"][@"measure"];
        self.aqi = a;
        
        self.week = dic[@"week"];
        self.date = [dic[@"date"] substringFromIndex:5];
        
        NSMutableArray *m = [NSMutableArray array];
        NSArray *hourlyArr = dic[@"hourly"];
        for (int i = 0; i < hourlyArr.count; i++) {
            Hourly *oneHour = [Hourly new];
            oneHour.time = hourlyArr[i][@"time"];
            oneHour.temp = hourlyArr[i][@"temp"];
            oneHour.weather = hourlyArr[i][@"weather"];
            oneHour.img = hourlyArr[i][@"img"];
            [m addObject:oneHour];
        }
        self.hourlys = [NSArray arrayWithArray:m];
        
        m = [NSMutableArray array];
        NSArray *lifeIndexArr = dic[@"index"];
        for (int i = 0; i < lifeIndexArr.count; i++) {
            LifeIndex *lifeIndex = [LifeIndex new];
            lifeIndex.iName = lifeIndexArr[i][@"iname"];
            lifeIndex.iValue = lifeIndexArr[i][@"ivalue"];
            lifeIndex.detail = lifeIndexArr[i][@"detail"];
            [m addObject:lifeIndex];
        }
        self.lifeIndexs = [NSArray arrayWithArray:m];
        
    }
    return self;
}
@end

