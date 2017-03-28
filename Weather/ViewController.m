//
//  ViewController.m
//  Weather
//
//  Created by vito7zhang on 2017/3/18.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import "ViewController.h"
#import "LineLabel.h"
#import "RefreshView.h"
#import "WeatherModel.h"
#import "DetailModel.h"
#import "WeatherView.h"
#import "DetailView.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()<RefreshViewDelegate>
@property (nonatomic,strong)UIButton *cityButton;
@property (nonatomic,strong)UILabel *temLabel;
@property (nonatomic,strong)UILabel *pronLabel;
@property (nonatomic,strong)UILabel *climateLabel;
@property (nonatomic,strong)LineLabel *temSectionLabel;
@property (nonatomic,strong)UIView *PMView;
@property (nonatomic,strong)UIButton *lifeButton;
@property (nonatomic,strong)RefreshView *refreshView;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)DetailView *detailView;;

@property (nonatomic,strong)NSMutableArray <WeatherModel *> *weatherArray;
@property (nonatomic,strong) DetailModel *detail;

@property (nonatomic,strong)CLLocationManager *locationM;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    
    self.weatherArray = [NSMutableArray new];
    
    
    
    [self.view addSubview:self.cityButton];
    [self.view addSubview:self.temLabel];
    [self.view addSubview:self.pronLabel];
    [self.view addSubview:self.climateLabel];
    //[self.view addSubview:self.temSectionLabel];
    [self.view addSubview:self.PMView];
    [self.view addSubview:self.lifeButton];
    [self.view addSubview:self.refreshView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.detailView];

    [self request];
}

#pragma mark WebRequest
-(void)request{
    NSString *appcode = @"f6494e1f078445a098f430356d905af9";
    NSString *host = @"http://jisutqybmf.market.alicloudapi.com";
    NSString *path = @"/weather/query";
    NSString *method = @"GET";
    NSString *querys = @"?city=%E5%B9%BF%E5%B7%9E";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
//    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *bodyDic = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingAllowFragments error:nil];
        NSArray *daily = bodyDic[@"result"][@"daily"];
        for (int i = 0; i< daily.count; i++) {
            WeatherModel *m = [WeatherModel weatherWithModel:daily[i]];
            [self.weatherArray addObject:m];
            self.detail = [DetailModel detailWithDic:bodyDic[@"result"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateUI];
            });
        }
    }];
    
    [task resume];
}

#pragma mark 更新UI
-(void)updateUI{
    [self.cityButton setTitle:self.detail.city forState:UIControlStateNormal];
    self.temLabel.text = self.detail.temp;
    self.climateLabel.text = self.detail.weather;
    self.temSectionLabel.text = [NSString stringWithFormat:@"%@~%@°C",self.detail.tempLow,self.detail.tempHigh];
    [self.PMView.subviews[1] setTitle:[NSString stringWithFormat:@"%@ %@",self.detail.pm2_5,self.detail.aqi.quality] forState:UIControlStateNormal];
    LineLabel *label = self.PMView.subviews[0];
    
    unsigned int red, green, blue;
    NSScanner *scanner = [NSScanner scannerWithString:[self.detail.aqi.color substringWithRange:NSMakeRange(1, 2)]];
    [scanner scanHexInt:&red];
    scanner = [NSScanner scannerWithString:[self.detail.aqi.color substringWithRange:NSMakeRange(3, 2)]];
    [scanner scanHexInt:&green];
    scanner = [NSScanner scannerWithString:[self.detail.aqi.color substringWithRange:NSMakeRange(5, 2)]];
    [scanner scanHexInt:&blue];
    label.textColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    label.strokeColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    
    [self.lifeButton setTitle:[NSString stringWithFormat:@"生活资讯\n%@ %@",self.detail.date,self.detail.week] forState:UIControlStateNormal];
    self.refreshView.timelabel.text = @"最新数据";
    self.refreshView.refreshImageView.image = [UIImage imageNamed:@"refresh"];
    for (int i = 0; i < self.bottomView.subviews.count; i++) {
        WeatherView *view = (WeatherView *)self.bottomView.subviews[i];
        if ([view isMemberOfClass:[WeatherView class]]) {
            view.weatherImageView.image = [UIImage imageNamed:self.weatherArray[i].img];
            view.dateLabel.text = self.weatherArray[i].week;
            view.tempSectionLabel.text = [NSString stringWithFormat:@"%@~%@°C",self.weatherArray[i].tempLow,self.weatherArray[i].tempHigh];
        }
    }
    
    NSMutableArray *array1 = [NSMutableArray array];
    NSMutableArray *array2 = [NSMutableArray array];
    NSMutableArray *array3 = [NSMutableArray array];
    NSMutableArray *array4 = [NSMutableArray array];
    for (int i = 0; i < self.weatherArray.count; i++) {
        WeatherModel *m = self.weatherArray[i];
        [array1 addObject:[m.date substringFromIndex:5]];
        [array2 addObject:m.img];
        [array3 addObject:m.tempHigh];
        [array4 addObject:m.tempLow];
    }
    self.detailView.dateArr = array1;
    self.detailView.imgArr = array2;
    self.detailView.tempHighArr = array3;
    self.detailView.tempLowArr = array4;
}


#pragma mark 定位

-(void)location{
    // 判断定位服务是否开启
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"已经开启定位服务，即将开始定位...");
        [self.locationM startUpdatingLocation];
    } else {
        NSLog(@"没有开启定位服务");
        //判断是否可以打开设置界面
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
            
            //跳转到设置页面
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:[NSDictionary new] completionHandler:nil];
            
        };
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [_locationM stopUpdatingLocation];
    NSLog(@"位置信息:%@", locations);
    CLGeocoder *geo = [[CLGeocoder alloc]init];
    [geo reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks[0];
            NSDictionary *dic = [placemark addressDictionary];
            NSLog(@"dic %@",dic);//根据你的需要选取所需要的地址
            
            //城市要注意
            NSString *city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
            }
            NSLog(@"city :%@",city);
        }
        else if (error == nil && [placemarks count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];

    // 停止定位(代理方法一直调用,会非常耗电，除非特殊需求，如导航）
}


-(CLLocationManager *)locationM{
    if (!_locationM) {
        _locationM = [[CLLocationManager alloc] init];
        
//        _locationM.delegate = self;
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [_locationM requestWhenInUseAuthorization];
        }
        _locationM.distanceFilter = 500; //在用户位置改变500米时调用一次代理方法
        
        _locationM.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationM;
}

#pragma mark LazyLoad View
-(UIButton *)cityButton{
    if (!_cityButton) {
        _cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityButton setImage:[UIImage imageNamed:@"location.png"] forState:UIControlStateNormal];
        _cityButton.frame = CGRectMake(16, 28, 100, 40);
        _cityButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 70);
        
        [_cityButton setTitle:@"广州" forState:UIControlStateNormal];
        [_cityButton setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
        _cityButton.titleLabel.font = [UIFont systemFontOfSize:28];
        _cityButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    }
    return _cityButton;
}

-(UILabel *)temLabel{
    if (!_temLabel) {
        _temLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 140, 300, 130)];
        _temLabel.font = [UIFont systemFontOfSize:120];
        _temLabel.text = @"20";
        _temLabel.textColor = TEXTCOLOR;
    }
    return _temLabel;
}
-(UILabel *)pronLabel{
    if (!_pronLabel) {
        _pronLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 160, 60, 60)];
        _pronLabel.font = [UIFont systemFontOfSize:80];
        _pronLabel.text = @"°";
        _pronLabel.textColor = TEXTCOLOR;
    }
    return _pronLabel;
}
-(UILabel *)climateLabel{
    if (!_climateLabel) {
        _climateLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 210, 60, 40)];
        _climateLabel.font = [UIFont systemFontOfSize:28];
        _climateLabel.text = @"小雨";
        _climateLabel.textColor = TEXTCOLOR;
    }
    return _climateLabel;
}

-(LineLabel *)temSectionLabel{
    if (!_temSectionLabel) {
        _temSectionLabel = [[LineLabel alloc]initWithFrame:CGRectMake(16, 290, 170, 40)];
        _temSectionLabel.text = @"17~21°C";
        _temSectionLabel.lineType = UILabelLineTypeBottom;
        _temSectionLabel.strokeColor = TEXTCOLOR;
        _temSectionLabel.textColor = TEXTCOLOR;
        _temSectionLabel.font = [UIFont systemFontOfSize:28];
    }
    return _temSectionLabel;
}
-(UIView *)PMView{
    if (!_PMView) {
        _PMView = [[UIView alloc]initWithFrame:CGRectMake(16, 365, 100, 30)];
        LineLabel *PMlabel = [[LineLabel alloc]initWithFrame:CGRectMake(5, 0, 40, 26)];
        PMlabel.lineType = UILabelLineTypeBottom;
        PMlabel.strokeColor = [UIColor greenColor];
        PMlabel.layer.cornerRadius = 2.0;
        PMlabel.layer.borderWidth = 1;
        PMlabel.layer.masksToBounds = YES;
        PMlabel.layer.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:0.5].CGColor;
        PMlabel.layer.borderColor = [UIColor whiteColor].CGColor;
        PMlabel.text = @"PM2.5";
        PMlabel.textColor = [UIColor greenColor];
        [_PMView addSubview:PMlabel];
        PMlabel.font = [UIFont systemFontOfSize:12];
        UIButton *PMButton = [UIButton buttonWithType:UIButtonTypeCustom];
        PMButton.frame = CGRectMake(48, 0, 40, 30);
        [PMButton setTitle:@"92 良" forState:UIControlStateNormal];
        PMButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_PMView addSubview:PMButton];
        
    }
    return _PMView;
}

-(UIButton *)lifeButton{
    if (!_lifeButton) {
        _lifeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _lifeButton.frame = CGRectMake(16, 400, 120, 30);
        [_lifeButton setImage:[UIImage imageNamed:@"cloth"] forState:UIControlStateNormal];
        [_lifeButton setTitle:@"生活资讯\n3-18 周日" forState:UIControlStateNormal];
        _lifeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 70);
        _lifeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _lifeButton.titleLabel.numberOfLines = 0;
        _lifeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _lifeButton;
}

-(RefreshView *)refreshView{
    if (!_refreshView) {
        _refreshView = [[RefreshView alloc] initWithFrame:CGRectMake(198, 566, 200, 30)];
        _refreshView.delegate = self;
    }
    return _refreshView;
}
-(void)requestNewData{
    [self request];
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.frame = CGRectMake(0, 616, SCREEN_WIDTH, 120);
        _bottomView.backgroundColor = [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:0.5];
        
//        UIView *upView = [UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)
        UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upButton addTarget:self action:@selector(transView:) forControlEvents:UIControlEventTouchUpInside];
        [upButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        upButton.frame = CGRectMake(SCREEN_WIDTH/2-10, 0, 20, 20);
        [_bottomView addSubview:upButton];
        for (int i = 0; i < 4; i++) {
            WeatherView *view = [[WeatherView alloc]init];
            view.frame = CGRectMake(SCREEN_WIDTH/4*i, 20, SCREEN_WIDTH/4, 100);
            [self.bottomView addSubview:view];
        }
    }
    return _bottomView;
}
-(DetailView *)detailView{
    if (!_detailView) {
        _detailView = [[DetailView alloc]init];
        _detailView.hidden = YES;
        _detailView.frame = CGRectMake(0, 536, SCREEN_WIDTH, 200);
        _detailView.backgroundColor = [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:0.5];
//        _detailView.dateArr =

        [_detailView.downButton addTarget:self action:@selector(transView:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _detailView;
}

-(void)transView:(UIButton *)btn{
    self.refreshView.hidden = !self.refreshView.hidden;
    self.bottomView.hidden = !self.bottomView.hidden;
    self.detailView.hidden = !self.detailView.hidden;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
