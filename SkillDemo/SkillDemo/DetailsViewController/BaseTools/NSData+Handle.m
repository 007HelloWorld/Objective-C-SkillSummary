//
//  NSData+Handle.m
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import "NSData+Handle.h"

@implementation NSData (Handle)

+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280&&height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280&&height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280&&height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
        
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData * data = UIImageJPEGRepresentation(newImage,0.5f);
    
//    NSLog(@"图片大小KB====%lf",data.length/1024.0);
    
    if (data.length > 300*1024) {
        if (data.length > 1024*1024) {//1M以及以上
            data = UIImageJPEGRepresentation(newImage, 0.35);
        }else if (data.length > 512*1024) {//0.5M-1M
            data = UIImageJPEGRepresentation(newImage, 0.4);
        }else if (data.length > 300*1024) {//0.25M-0.5M
            data = UIImageJPEGRepresentation(newImage, 0.45);
        }
    }
    
    return data;
}

@end
