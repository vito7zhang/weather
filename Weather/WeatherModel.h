//
//  WeatherModel.h
//  Weather
//
//  Created by vito7zhang on 2017/3/21.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *week;
@property (nonatomic,copy)NSString *weather;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *tempLow;
@property (nonatomic,copy)NSString *tempHigh;

+(instancetype)weatherWithModel:(NSDictionary *)json;
-(instancetype)initWithModel:(NSDictionary *)json;
@end
