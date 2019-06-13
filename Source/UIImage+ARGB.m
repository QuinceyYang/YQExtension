//
//  UIImage+ARGB.m
//  TmpOcDemo
//
//  Created by 杨清 on 2018/12/25.
//  Copyright © 2018 QuinceyYang. All rights reserved.
//

#import "UIImage+ARGB.h"

@implementation UIImage (ARGB)


//  Create by QuinceyYang
- (CGContextRef)createARGBBitmapContext {
    
    // Get image width, height
    size_t pixelsWide = CGImageGetWidth(self.CGImage);
    size_t pixelsHigh = CGImageGetHeight(self.CGImage);
    
    // Declare the number of bytes per row
    NSInteger bitmapBytesPerRow  = (pixelsWide * 4);
    NSInteger bitmapByteCount    = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL) {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    // Allocate memory for image data
    void *bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL) {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    
    // Create the bitmap context
    CGContextRef context = CGBitmapContextCreate (bitmapData,
                                                  pixelsWide,
                                                  pixelsHigh,
                                                  8,      // bits per component
                                                  bitmapBytesPerRow,
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedFirst);
    if (context == NULL) {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    
    // release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    return context;
}

- (UIColor *)getPixelColorAtPoint:(CGPoint)point
{
    UIColor* color = nil;
    CGImageRef inImage = self.CGImage;
    // Create bitmap context to draw the image into
    CGContextRef cgctx = [self createARGBBitmapContext];
    if (cgctx == NULL) {
        return nil; /* error */
    }
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    // Draw the image to the bitmap context
    CGContextDrawImage(cgctx, rect, inImage);
    
    // get image data
    unsigned char* data = CGBitmapContextGetData (cgctx);
    if (data != NULL) {
        //offset locates the pixel in the data from x,y.
        //4 for 4 bytes of data per pixel, w is width of one row of data.
        int offset = 4*((w*round(point.y))+round(point.x));
        int alpha =  data[offset];
        int red = data[offset+1];
        int green = data[offset+2];
        int blue = data[offset+3];
        //NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
    }
    
    //release the context
    CGContextRelease(cgctx);
    // Free image data
    if (data) {
        free(data);
    }
    return color;
}



#pragma mark - ========== create 16*16size cgctx =================
- (CGContextRef)createARGBBitmapContext_16x16 {
    
    // Get image width, height
    size_t pixelsWide = 16;
    size_t pixelsHigh = 16;
    
    // Declare the number of bytes per row
    NSInteger bitmapBytesPerRow  = (pixelsWide * 4);
    NSInteger bitmapByteCount    = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL) {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    // Allocate memory for image data
    char *bitmapData = malloc(bitmapByteCount);
    if (bitmapData == NULL) {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    memset(bitmapData, 0, bitmapByteCount);
    long offset = 4*((pixelsWide*8)+5);
    int alpha =  bitmapData[offset];
    int red = bitmapData[offset+1];
    int green = bitmapData[offset+2];
    int blue = bitmapData[offset+3];
    NSLog(@"offset: %ld colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
    bitmapData[offset] = 0x80;
    bitmapData[offset+1] = 0xf0;
    
    // Create the bitmap context
    CGContextRef context = CGBitmapContextCreate (bitmapData,
                                                  pixelsWide,
                                                  pixelsHigh,
                                                  8,      // bits per component
                                                  bitmapBytesPerRow,
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedFirst);
    if (context == NULL) {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    
    // release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    return context;
}

- (UIImage *)testImage16x16 {
    CGContextRef ctx = [self createARGBBitmapContext_16x16];
    CGImageRef cgImgRef = CGBitmapContextCreateImage(ctx);
    if (cgImgRef == NULL) {
        return nil;
    }
    else {
        return [UIImage imageWithCGImage:cgImgRef];
    }
    
}

@end
