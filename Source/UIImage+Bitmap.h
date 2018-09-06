//
//  NSObject+UIImage_Bitmap.h
//  CGImageTest
//
//  Created by yeeku on 14/12/14.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Bitmap)

/**
 * 对指定的UI控件进行截图
 */
+ (UIImage*)captureView:(UIView *)targetView;

/**
 * 截屏
 */
+ (UIImage*)captureScreen;

/**
 * 定义一个方法用于“挖取”图片的指定区域
 */
- (UIImage *)imageAtRect:(CGRect)rect;

/**
 * 保持图片纵横比缩放，最短边必须匹配targetSize的大小
 * 可能有一条边的长度会超过targetSize指定的大小
 */
- (UIImage *)imageByScalingAspectToMinSize:(CGSize)targetSize;

/**
 * 保持图片纵横比缩放，最长边匹配targetSize的大小即可
 * 可能有一条边的长度会小于targetSize指定的大小
 */
- (UIImage *)imageByScalingAspectToMaxSize:(CGSize)targetSize;

/**
 * 不保持图片纵横比缩放
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

/**
 * 对图片按弧度执行旋转
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/**
 * 对图片按角度执行旋转
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 * 保存图片至Documents目录
 */
- (void) saveToDocuments:(NSString*)fileName;

@end



@interface UIImage (Category)

///把图片变灰
-(UIImage *)getGrayImage:(UIImage*)sourceImage;

///通过颜色来生成一个纯色图片
+(UIImage *)imageFromColor:(UIColor *)color rectSize:(CGRect)Rect;
@end

@interface UIImage (ResizableImage)
- (UIImage *)resizableImage:(UIEdgeInsets)insets;
@end

