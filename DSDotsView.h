//
//  DotsView.h
//  payDemo
//
//  Created by 王晓东 on 15/12/10.
//  Copyright © 2015年 Ericdong. All rights reserved.
//



#import <UIKit/UIKit.h>
#define kInputCount 6


@interface DSDotsView : UIView
@property (strong, nonatomic) UIColor *lineColor;
@property (strong, nonatomic) UIColor *dotColor;
@property (strong, nonatomic) NSArray *containers;
- (void)selectedCount:(NSInteger)count;
@end

#define dotSize CGSizeMake (10.0f,10.0f)
#define UIColorFromRGB(r) [UIColor colorWithRed:((r & 0xFF0000) >> 16)/255.0 green:((r & 0xFF00) >> 8)/255.0 blue:(r & 0xFF)/255.0 alpha:1.0]
@interface DSDotView : UIImageView
@property (assign, nonatomic) BOOL selected;
@property (strong, nonatomic) UIColor *dotColor;
@end
