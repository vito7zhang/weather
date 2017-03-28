//
//  DetailModel.h
//  Weather
//
//  Created by vito7zhang on 2017/3/21.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AQI : NSObject
@property (nonatomic,copy) NSString *pm10;
@property (nonatomic,copy) NSString *pm2_5;
@property (nonatomic,copy) NSString *no2;
@property (nonatomic,copy) NSString *so2;
@property (nonatomic,copy) NSString *co;
@property (nonatomic,copy) NSString *o3;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSString *color;
@property (nonatomic,copy) NSString *affect;
@property (nonatomic,copy) NSString *measure;
@property (nonatomic,copy) NSString *quality;
@end

@interface Hourly : NSObject
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *weather;
@property (nonatomic,copy) NSString *temp;
@property (nonatomic,copy) NSString *img;
@end

@interface LifeIndex : NSObject
@property (nonatomic,copy) NSString *iName;
@property (nonatomic,copy) NSString *iValue;
@property (nonatomic,copy) NSString *detail;
@end

@interface DetailModel : NSObject
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *temp;
@property (nonatomic,copy) NSString *tempHigh;
@property (nonatomic,copy) NSString *tempLow;
@property (nonatomic,copy) NSString *weather;
@property (nonatomic,copy) NSString *pm2_5;
@property (nonatomic,strong) AQI *aqi;
@property (nonatomic,copy) NSString *week;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,strong) NSArray <Hourly *> *hourlys;
@property (nonatomic,strong) NSArray <LifeIndex *> *lifeIndexs;

+(instancetype)detailWithDic:(NSDictionary *)dic;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
