//
//  PMViewController.m
//  Weather
//
//  Created by vito7zhang on 2017/3/22.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import "PMViewController.h"
#import "InstrumentView.h"

@interface PMViewController ()

@end

@implementation PMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"今日空气质量";
    
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    
    InstrumentView *instruView = [[InstrumentView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    instruView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:instruView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
