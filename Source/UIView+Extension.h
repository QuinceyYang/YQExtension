//
//  UIView+Extension.h
//  Easy to set frames
//
//  Created by QuinceyYang on 15/9/25.
//  Copyright © 2015年 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

/**
 * 插入子视图，subview在belowSubview之上，并自动偏移后面的视图
 */
- (void)insertSubview:(UIView *)subview belowSubview:(UIView *)belowSubview flexOffset:(CGPoint)flexOffset;

/**
 * 插入子视图，subview在aboveSubview之下，并自动偏移后面的视图
 */
- (void)insertSubview:(UIView *)subview aboveSubview:(UIView *)aboveSubview flexOffset:(CGPoint)flexOffset;

/**
 * 返回一个能包含所有子视图的尺寸
 */
- (CGSize)fullSize;

/**
 * 设置视图的尺寸，使其包含所有子视图的尺寸
 */
- (void)sizeToFull;

/**
 * 平移子视图从startView至endView
 */
- (void)subviewsFlexOffset:(CGPoint)flexOffset startView:(UIView *)startView endView:(UIView *)endView;


#pragma mark -
/**
 * @author yqing
 * @brief  绘制虚线
 * @param  length   虚线的宽度
 * @param  space    虚线的间距
 * @param  color    虚线的颜色
 */
- (void)drawDashLineWithLength:(int)length space:(int)space color:(UIColor *)color;

@end
