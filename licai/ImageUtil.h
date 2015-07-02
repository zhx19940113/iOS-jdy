//
//  ImageUtil.h
//  iweight
//
//  Created by 钟惠雄 on 14-7-25.
//  Copyright (c) 2014年 shierlan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageUtil : NSObject
/** 加载图片*/
+(UIImage*)loadImage:(NSString *) path;
/** 等比率缩放*/
+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
/** 自定义长宽*/
+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
/** 根据给定得图片，从其指定区域截取一张新得图片*/
+(UIImage *)getImageFromImage :(UIImage *) bigImage rect:(CGRect *) myImageRect;
+(UIImage *)createImageWithColor:(UIColor *)color;
@end
