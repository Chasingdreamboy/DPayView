//
//  DSPayField.m
//  payDemo
//
//  Created by 王晓东 on 15/12/11.
//  Copyright © 2015年 Ericdong. All rights reserved.
//

#import "DPayView.h"
#import "AppDelegate.h"
@interface DPayView ()<UITextFieldDelegate>
@property (copy, nonatomic) void(^callback)(DPayView *passwordView, NSString *password);
@property (strong, nonatomic) DSDotsView *dotsView;
@property (strong, nonatomic) UITextField *textField;
@property (assign, nonatomic) NSInteger inputTimes;

@end

@implementation DPayView
- (instancetype)initWithFrame:(CGRect)frame callBack:(void(^)(DPayView *passwordView, NSString *password)) callback {
    self.callback = callback;
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width / 6.0);
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [kBorderColor CGColor];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.delegate = self;
        [self addSubview:_textField];
        self.dotsView = [[DSDotsView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _dotsView.backgroundColor = bg_color;
        _dotsView.lineColor =  kLineColor;
        _dotsView.dotColor = kPointColor;
        [self addSubview:_dotsView];
        [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
            if ([note.object isEqual:_textField])
            {
                [self changeInput:_textField.text.length];
            }
            
        }];
    }
    return self;
}
- (void)setDividerColor:(UIColor *)dividerColor {
    _dotsView.lineColor = dividerColor;
}
- (void)setDotColor:(UIColor *)dotColor {
    _dotsView.dotColor = dotColor;
}
- (void)hide {
    [self.textField resignFirstResponder];
    [self removeFromSuperview];

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    }
    else if(string.length == 0)
    {
        //判断是不是删除键
        return YES;
    }
    else if (![self isNumberWithString:string]) {
        NSLog(@"请输入数字");
        return NO;
    }
    else if(textField.text.length >= kInputCount)
    {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)changeInput:(NSInteger)count {
    if (count < kInputCount) {
        [self.dotsView selectedCount:count];
    } else if (count == kInputCount) {
         self.callback(self, _textField.text);
        [self.dotsView selectedCount:kInputCount];
        [self performSelector:@selector(clear) withObject:nil afterDelay:.8];
    }
}
- (void)clear {
    [self.dotsView selectedCount:0];
    self.textField.text = nil;
}
-(BOOL)isNumberWithString:(NSString *)string {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    return [predicate evaluateWithObject:string];
}
- (void)resignFirstResponder {
    [_textField resignFirstResponder];
}
- (void)becomeFirstResponder {
    [_textField becomeFirstResponder];
}
- (void)shake {
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat s = 5.0;
    shake.values = @[@(s), @(0), @(-s), @(0), @(s), @(0), @(-s),@(0)];
    shake.duration = .2;
    shake.repeatCount = 2;
    shake.removedOnCompletion = YES;
    [self.layer addAnimation:shake forKey:@"shake"];
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    
    _dotsView.backgroundColor = backgroundColor;
    
}
- (void)setDivideLineColor:(UIColor *)divideLineColor {
    _divideLineColor = divideLineColor;
    _dotsView.lineColor = divideLineColor;
}
- (void)setBorderLineColor:(UIColor *)borderLineColor {
    _borderLineColor = borderLineColor;
    self.layer.borderColor = borderLineColor.CGColor;
}

@end
