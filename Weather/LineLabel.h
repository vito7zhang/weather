//
//  LineLabel.h
//  Weather
//
//  Created by vito7zhang on 2017/3/18.
//  Copyright © 2017年 vito7zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UILabelLineType) {
    UILabelLineTypeUnder = 0,
    UILabelLineTypeThrough,
    UILabelLineTypeBottom,
};
@interface LineLabel : UILabel
@property (nonatomic,strong)UIColor *strokeColor;
@property (nonatomic,assign)UILabelLineType lineType;
@end
