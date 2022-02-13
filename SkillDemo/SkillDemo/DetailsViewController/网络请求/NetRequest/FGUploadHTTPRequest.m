//
//  FGUploadHTTPRequest.m
//  FGUploadImageManager
//
//  Created by FengLe on 2018/4/2.
//  Copyright © 2018年 FengLe. All rights reserved.
//

#import "FGUploadHTTPRequest.h"
#import "NetRequest.h"
#import "SMHttpTool.h"

@implementation FGUploadHTTPRequest

FGShareSingletonM(Upload);

/**
 自己实现图片上传功能...
 */
- (void)uploadPhotoAlbum:(NSData *)data uploadProgress:(void(^)(float percent))progress completeBlock:(void(^)(BOOL isSuccess,NSString * imageUrlString))completeBlock;
{
        //开始上传
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/portal/system/file/v1/upload", [SMHttpTool shareInstance].BASEURL];
        NSDictionary *paramDict = [[NSDictionary alloc]init];
        [[NetRequest request]startUpload:urlStr uploadData:data params:paramDict resultHandle:^(id responseObj, NSError *err) {
            
            if (responseObj) {
                
                if ([responseObj isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *resDict = (id)responseObj;
                    NSString *valueStr = [resDict objectForKey:@"value"];
//                    NSDictionary *valueDict = [SMBaseModelTool dictionaryWithJsonString:valueStr];
//                    NSString *filePathStr = [SMBaseModelTool getValueWithDict:valueDict andKey:@"filePath"];
//                    NSString *imgUrl = [NSString stringWithFormat:@"%@/media/%@",[SMHttpTool shareInstance].BASEURL, filePathStr];
                    NSLog(@"%@",valueStr);
                    completeBlock(YES,valueStr);
                }
            }
            
            if (err) {
                NSLog(@"%@", err);
                NSDictionary *dict = @{@"err":err.domain};
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"err" object:nil userInfo:dict]];
            }
            
        } progressHandle:^(id responseObj, NSError *err) {
            
        }];
}


@end
