//
//  UIView+Extension.m
//  Easy to set frames
//
//  Created by QuinceyYang on 15/9/25.
//  Copyright © 2015年 QuinceyYang. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

@dynamic maxX;
@dynamic maxY;

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

/**
 * 插入子视图，subview在belowSubview之上，并自动偏移后面的视图
 */
- (void)insertSubview:(UIView *)subview belowSubview:(UIView *)belowSubview flexOffset:(CGPoint)flexOffset {
    //
    if (![subview isKindOfClass:[UIView class]] || ![belowSubview isKindOfClass:[UIView class]]) {
        return;
    }
    if (belowSubview.superview != self) {
        return;
    }
    //
    [self insertSubview:subview belowSubview:belowSubview];
    NSArray <UIView *> * subviewsArr = self.subviews;
    NSUInteger idx = [subviewsArr indexOfObject:belowSubview];
    if (idx != NSNotFound) {
        for (NSUInteger i=idx; i<subviewsArr.count; i++) {
            CGRect frame = subviewsArr[i].frame;
            frame.origin.x += flexOffset.x;
            frame.origin.y += flexOffset.y;
            subviewsArr[i].frame = frame;
        }
    }
}

/**
 * 插入子视图，subview在aboveSubview之下，并自动偏移后面的视图
 */
- (void)insertSubview:(UIView *)subview aboveSubview:(UIView *)aboveSubview flexOffset:(CGPoint)flexOffset {
    //
    if (![subview isKindOfClass:[UIView class]] || ![aboveSubview isKindOfClass:[UIView class]]) {
        return;
    }
    if (aboveSubview.superview != self) {
        return;
    }
    //
    [self insertSubview:subview aboveSubview:aboveSubview];
    NSArray <UIView *> * subviewsArr = self.subviews;
    NSUInteger idx = [subviewsArr indexOfObject:subview];
    if (idx != NSNotFound) {
        idx += 1;
        for (NSUInteger i=idx; i<subviewsArr.count; i++) {
            CGRect frame = subviewsArr[i].frame;
            frame.origin.x += flexOffset.x;
            frame.origin.y += flexOffset.y;
            subviewsArr[i].frame = frame;
        }
    }
}

/**
 * 返回一个能包含所有子视图的尺寸
 */
- (CGSize)fullSize {
    NSArray <UIView *> * subviewsArr = self.subviews;
    if (subviewsArr.count <= 0) {
        return self.frame.size;
    }
    CGSize size = CGSizeMake(0, 0);
    for (NSUInteger i=0; i<subviewsArr.count; i++) {
        if (CGRectGetMaxX(subviewsArr[i].frame) > size.width) {
            size.width = CGRectGetMaxX(subviewsArr[i].frame);
        }
        if (CGRectGetMaxY(subviewsArr[i].frame) > size.height) {
            size.height = CGRectGetMaxY(subviewsArr[i].frame);
        }
    }
    return size;
}

/**
 * 设置视图的尺寸，使其包含所有子视图的尺寸
 */
- (void)sizeToFull {
    NSArray <UIView *> * subviewsArr = self.subviews;
    if (subviewsArr.count <= 0) {
        return;
    }
    CGSize size = CGSizeMake(0, 0);
    for (NSUInteger i=0; i<subviewsArr.count; i++) {
        if (CGRectGetMaxX(subviewsArr[i].frame) > size.width) {
            size.width = CGRectGetMaxX(subviewsArr[i].frame);
        }
        if (CGRectGetMaxY(subviewsArr[i].frame) > size.height) {
            size.height = CGRectGetMaxY(subviewsArr[i].frame);
        }
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

/**
 * 平移子视图从startView至endView
 */
- (void)subviewsFlexOffset:(CGPoint)flexOffset startView:(UIView *)startView endView:(UIView *)endView {
    
    if (startView==nil || startView.superview!=self) {
        return;
    }
    if (endView==nil || endView.superview!=self) {
        return;
    }
    NSArray <UIView *> * subviewsArr = self.subviews;
    NSUInteger startIdx = [subviewsArr indexOfObject:startView];
    NSUInteger endIdx = [subviewsArr indexOfObject:endView];
    if (startIdx > endIdx) {
        return;
    }
    for (NSUInteger i=startIdx; i<=endIdx; i++) {
        CGRect frame = subviewsArr[i].frame;
        frame.origin.x += flexOffset.x;
        frame.origin.y += flexOffset.y;
        subviewsArr[i].frame = frame;
    }
}

#pragma mark -
/**
 * @author yqing
 * @brief  绘制虚线
 * @param  length   虚线的宽度
 * @param  space    虚线的间距
 * @param  color    虚线的颜色
 */
- (void)drawDashLineWithLength:(int)length space:(int)space color:(UIColor *)color
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:color.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:length], [NSNumber numberWithInt:space], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}



@end
