//
//  DetailView.h
//  Weather
//
//  Created by vito7zhang on 2017/3/22.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailView : UIView
@property (nonatomic,strong) NSArray *dateArr;
@property (nonatomic,strong) NSArray *imgArr;
@property (nonatomic,strong)NSArray *tempHighArr;
@property (nonatomic,strong)NSArray *tempLowArr;
@property (nonatomic,strong)UIButton *downButton;

@end
