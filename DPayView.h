//
//  DSPayField.h
//  payDemo
//
//  Created by 王晓东 on 15/12/11.
//  Copyright © 2015年 Ericdong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSDotsView.h"
//默认的颜色值
#define bg_color UIColorFromRGB(0xf2f2f2)
#define kLineColor UIColorFromRGB(0xe6e6e6)
#define kBorderColor UIColorFromRGB(0xe6e6e6)
#define kPointColor [UIColor blackColor] 

@interface DPayView : UIView

//边框的颜色属性
@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *divideLineColor;
@property (strong, nonatomic) UIColor *borderLineColor;


//原点的颜色
@property (strong, nonatomic) UIColor *dotColor;
- (instancetype)initWithFrame:(CGRect)frame callBack:(void(^)(DPayView *passwordView, NSString *password)) callback;
/**
 *  移出视图
 */
- (void)hide;
/**
 *  放弃键盘第一响应者
 */
- (void)resignFirstResponder;
/**
 *  获取键盘第一响应者
 */
- (void)becomeFirstResponder;
/**
 *  密码输入错误时震动
 */
- (void)shake;

@end
