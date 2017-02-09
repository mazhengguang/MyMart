//
//  TNCustomSegment.m
//  TNCustomSegment
//
//  Created by TigerNong on 16/12/25.
//  Copyright © 2016年 TigerNong. All rights reserved.
//

#import "TNCustomSegment.h"
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]

@interface TNCustomSegment ()
@property (nonatomic, strong) UIButton *selectSegment;



//正常的颜色
@property (nonatomic, strong) UIColor *normolColor;

@end

@implementation TNCustomSegment

- (id)initWithItems:(NSArray *)items withFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = RGB(87, 210, 210);
        [TNCustomSegment setUpView:self byRoundingCorners:UIRectCornerAllCorners withSize:CGSizeMake(5, 5)];
    }
    return self;
}

- (id)initWithItems:(NSArray *)items withFrame:(CGRect)frame withSelectedColor:(UIColor *)selectedColor withNormolColor:(UIColor *)normolColor withFont:(UIFont *)font{
    
    if (self = [super initWithFrame:frame]) {
        
        self.selectColor = selectedColor;
        self.normolColor = normolColor;
        
        [TNCustomSegment setUpView:self byRoundingCorners:UIRectCornerAllCorners withSize:CGSizeMake(5, 5)];
        
        if (selectedColor == nil) {
            self.backgroundColor = RGB(87, 210, 210);
        }else{
            self.backgroundColor = selectedColor;
        }
        
        [self setUpItems:items withSelectedColor:selectedColor withNormolColor:normolColor withFont:font];
    }
    return self;
    
}

- (void)setUpItems:(NSArray *)items withSelectedColor:(UIColor *)selectedColor withNormolColor:(UIColor *)normolColor withFont:(UIFont *)font{
    
    for (UIView *obj in self.subviews) {
        if ([obj isMemberOfClass:[UIButton class]]) {
            [obj removeFromSuperview];
        }
    }
    
    CGFloat buttonW = (self.frame.size.width - (items.count + 1)) * 1.0 / items.count;
    CGFloat buttonH = self.frame.size.height - 2;
    CGFloat buttonY = 1;
    
    for (NSInteger i = 0; i < items.count; i ++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        [self addSubview:button];
        
        CGFloat buttonX = i * (buttonW + 1) + 1;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        if (selectedColor == nil) {
            [button setTitleColor:RGB(87, 210, 210) forState:UIControlStateNormal];
            button.backgroundColor = RGB(87, 210, 210);
        }else{
            [button setTitleColor:selectedColor forState:UIControlStateNormal];
            button.backgroundColor = selectedColor;
        }
        
        
        [button setTitle:items[i] forState:UIControlStateNormal];
        
        if (normolColor == nil) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        }else{
            [button setTitleColor:normolColor forState:UIControlStateDisabled];
        }
        
        if (font == nil) {
            button.titleLabel.font = [UIFont systemFontOfSize:15];
        }else{
            button.titleLabel.font = font;
        }

        [button addTarget:self action:@selector(clickSelectItem:) forControlEvents:UIControlEventTouchUpInside];
        
        //把左边的圆角
        if (i == 0) {
            [TNCustomSegment setUpView:button byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft withSize:CGSizeMake(5, 5)];
        }

        //把右边的圆角
        if (i == items.count - 1) {
            [TNCustomSegment setUpView:button byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight withSize:CGSizeMake(5, 5)];
        }
    }
    
    [self clickSelectItem:self.subviews[0]];
}

- (void)clickSelectItem:(UIButton *)button{
    
    self.selectSegment.enabled = YES;
    button.enabled = NO;
    self.selectSegment = button;
    
    UIButton *selectButton = self.subviews[button.tag];
    
    for (UIButton *otherButton in self.subviews) {
        if (otherButton == selectButton) {
            if (self.selectColor == nil) {
                selectButton.backgroundColor = RGB(87, 210, 210);
            }else{
                selectButton.backgroundColor = self.selectColor;
            }
        }else{
            
            if (self.normolColor == nil) {
                otherButton.backgroundColor = [UIColor whiteColor];
            }else{
                otherButton.backgroundColor = self.normolColor;
            }
        }
    }

    if ([self.delegate respondsToSelector:@selector(segment:didSelectedIndex:)]) {
        [self.delegate segment:self didSelectedIndex:button.tag];
    }
    
}

//设置按钮的部分圆角
+ (void)setUpView:(UIView *)view byRoundingCorners:(UIRectCorner)corners withSize:(CGSize)size{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners: corners  cornerRadii:size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    
    [self clickSelectItem:self.subviews[selectedIndex]];
}

@end
