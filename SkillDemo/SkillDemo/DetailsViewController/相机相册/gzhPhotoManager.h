//
//  gzhPhotoManager.h
//  Image
//
//  Created by pjw on 2021/2/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/*
 Privacy - Photo Library Usage Description                  请求访问相册
 Privacy - Camera Usage Description                         请求访问相机
 Localized resources can be mixed                           YES
 表示是否允许应用程序获取框架库内语言（前题是手机要设置为中文哦）
*/
@protocol gzhPhotoManagerDelegate;

@protocol gzhPhotoManagerDelegate <NSObject>

- (void)selectedPhotoImage:(UIImage *)image;

@end



@interface gzhPhotoManager : NSObject

+(instancetype)instance;

/// 选择图片
/// @param controller 当前控制器
/// @param target 代理
/// @param pSize 选择照片尺寸 尺寸传（0，0）不进行裁剪
- (void)selectPhotoWithController:(id )controller delegate:(id)target;


@end



NS_ASSUME_NONNULL_END
