//
//  UIImage+ARGB.h
//  TmpOcDemo
//
//  Created by 杨清 on 2018/12/25.
//  Copyright © 2018 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ARGB)
//  Create by QuinceyYang
- (CGContextRef)createARGBBitmapContext;

- (UIColor *)getPixelColorAtPoint:(CGPoint)point;


#pragma mark - ===========
- (UIImage *)testImage16x16;
@end

NS_ASSUME_NONNULL_END
