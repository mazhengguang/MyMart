//
//  TNCustomSegment.h
//  TNCustomSegment
//
//  Created by TigerNong on 16/12/25.
//  Copyright © 2016年 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TNCustomSegment;

@protocol TNCustomSegmentDelegate <NSObject>

- (void)segment:(TNCustomSegment *)segment didSelectedIndex:(NSInteger)selectIndex;

@end

@interface TNCustomSegment : UIView

- (id)initWithItems:(NSArray *)items withFrame:(CGRect)frame withSelectedColor:(UIColor *)selectedColor withNormolColor:(UIColor *)normolColor withFont:(UIFont *)font;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, weak) id <TNCustomSegmentDelegate> delegate;

//选中时的颜色
@property (nonatomic, strong) UIColor *selectColor;
@end
