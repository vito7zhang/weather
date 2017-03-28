//
//  RefreshView.h
//  Weather
//
//  Created by vito7zhang on 2017/3/20.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RefreshViewDelegate <NSObject>
-(void)requestNewData;

@end

@interface RefreshView : UIView
@property (strong,nonatomic)UILabel *timelabel;
@property (strong,nonatomic)UIImageView *refreshImageView;
@property (nonatomic,weak) id<RefreshViewDelegate> delegate;
@end
