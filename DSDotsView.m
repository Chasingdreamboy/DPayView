//
//  DotsView.m
//  payDemo
//
//  Created by 王晓东 on 15/12/10.
//  Copyright © 2015年 Ericdong. All rights reserved.
//

#import "DSDotsView.h"


#define kLineTop 0

@interface DSDotsView ()
@property (assign, nonatomic) NSInteger selectedCount;
@property (strong, nonatomic) NSArray *lines;

@end
@implementation DSDotsView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //初始化选中的点数
        self.selectedCount = 0;
        CGFloat width = (frame.size.width - kInputCount - 1) / kInputCount;
        CGFloat height = frame.size.height;
        NSMutableArray *container = [NSMutableArray array];
        NSMutableArray *lines = [NSMutableArray array];
        for (int i = 0; i < kInputCount; i++) {
            DSDotView *dotView = [[DSDotView alloc] initWithFrame:CGRectMake((width + 1) * i, 0, width, height)];
            dotView.selected = NO;
            [self addSubview:dotView];
            [container addObject:dotView];
            //添加线条
            if (i != kInputCount - 1) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake((i + 1) * width + i, kLineTop, 1.2, height - 2 * kLineTop)];
                line.backgroundColor = self.lineColor;
                [self addSubview:line];
                [lines addObject:line];
            }
        }
        self.lines = lines;
        self.containers = container;
    }
    
    return self;
}

- (void)setLineColor:(UIColor *)lineColor {
    [_lines enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *line = (UIView *)obj;
        line.backgroundColor = lineColor;
        if (idx == _lines.count - 1) {
            *stop = 1;
        }
    }];
    
}
- (void)setDotColor:(UIColor *)dotColor {
    [_containers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DSDotView *dot = (DSDotView *)obj;
        dot.dotColor = dotColor;
        if (idx == _containers.count) {
            *stop = YES;
        }
    }];
}
- (void)selectedCount:(NSInteger)count {
    if (count < 0 || count > kInputCount) {
        return;
    }
    //密码输错时清零操作
    if (count == 0) {
        for (int i = 0; i < _containers.count; i++) {
            DSDotView *dotView = (DSDotView *)_containers[i];
            dotView.selected = NO;
        }
        _selectedCount = 0;
        return;
    }
    DSDotView *dotView = nil;
    if (_selectedCount > count) {
        dotView = (DSDotView *)_containers[count];
        dotView.selected = NO;
    } else {
        dotView = (DSDotView *)_containers[count - 1];
        dotView.selected = YES;
        
    }
    _selectedCount = count;
}

@end





@interface DSDotView ()
@property (strong, nonatomic) UIImageView *dotImg;
@end
@implementation DSDotView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addDot];
    }
    return self;
}
- (void)addDot {
    CGPoint center = self.center;
    CGRect frame = self.frame;
    self.dotImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dotSize.width, dotSize.height)];
    _dotImg.center = CGPointMake(center.x - frame.origin.x, center.y - frame.origin.y);
    _dotImg.layer.cornerRadius = dotSize.width / 2.0;
    [self addSubview:_dotImg];
    _dotImg.hidden = YES;
}
- (void)setSelected:(BOOL)selected {
    self.dotImg.hidden = !selected;
}
- (void)setDotColor:(UIColor *)dotColor {
    self.dotImg.backgroundColor = dotColor;
}
@end

