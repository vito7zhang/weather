//
//  RefreshView.m
//  Weather
//
//  Created by vito7zhang on 2017/3/20.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import "RefreshView.h"

@implementation RefreshView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}
-(void)addView{
    _timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-40, self.frame.size.height)];
    _timelabel.text = @"最新数据";
    _timelabel.textColor = TEXTCOLOR;
    _timelabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_timelabel];
    
    _refreshImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-30, 0, 30, self.frame.size.height)];
    _refreshImageView.image = [UIImage imageNamed:@"refresh"];
    [self addSubview:_refreshImageView];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _timelabel.text = @"正在更新..";
    _refreshImageView.image = [UIImage imageNamed:@"stop"];
    [self.delegate requestNewData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
