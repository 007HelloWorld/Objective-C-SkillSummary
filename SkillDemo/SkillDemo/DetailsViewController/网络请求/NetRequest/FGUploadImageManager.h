//
//  FGUploadImageManager.h
//  FGUploadImageManager
//
//  Created by FengLe on 2018/4/2.
//  Copyright © 2018年 FengLe. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UploderManager.h"

@interface FGUploadImageManager : NSObject

+(UploderManager *) shareManager;
-(void)upLoadImageWithImageArray:(NSArray *)imageArray completeBlock:(void(^)(NSArray * imageUrlArr))completeBlock;;


@end
