//
//  UploderManager.h
//  SMProject
//
//  Created by 浩哥哥 on 2019/3/24.
//  Copyright © 2019 浩哥哥. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+EXtention.h"


typedef void(^loadImagesArrayBlock)(NSArray *urlImages);
typedef void(^loadImagesStringBlock)(NSString *uploadString);

typedef void(^loadImageBlock)(NSString *targetImage,NSError *error);

@protocol uploaderDelegate
@required

- (void)uploadBegin;

- (void)uploadFaild:(NSError *)err;

- (void)uploadSuccess:(NSString *)imageKey;

@end

@interface UploderManager : NSObject <uploaderDelegate>

@property(assign, nonatomic) id<uploaderDelegate> delegate;


+ (UploderManager *)shareManager;

//只有 巡查工单 处理的时候时候，用到的 上传图片 方法
- (void)startUpLoadWithImagesArray:(NSArray *)uploadImages result:(loadImagesArrayBlock)resultHandle;

- (void)startComplaintUpLoadWithImagesArray:(NSArray *)uploadImages result:(loadImagesStringBlock)resultHandle;

- (void)uploadComplaintImage:(UIImage *)targetImage result:(loadImageBlock)resultHandle;

@end
