//
//  UploderManager.m
//  SMProject
//
//  Created by 浩哥哥 on 2019/3/24.
//  Copyright © 2019 浩哥哥. All rights reserved.
//



#import "UploderManager.h"
#import "NetRequest.h"
#import "SMHttpTool.h"
#import "NSData+Handle.h"


@interface UploderManager()

/** current upload content*/
@property(retain, nonatomic) NSData  *currentUplaodContent;

@end

@implementation UploderManager



- (id)init
{
    if (self = [super init]) {
        self.currentUplaodContent = nil;
    }
    return self;
}

+(UploderManager *) shareManager
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

- (void)startUploadWithData:(NSData *)uploadContent
{
    if (isNull(uploadContent)) {
        NSError * error = [NSError errorWithDomain:@"上传内容为空" code:013 userInfo:@{@"descripte":@"上传内容为空"}];
        [self.delegate uploadFaild:error];
        return;
    }
    if (_delegate) {
        [_delegate uploadBegin];
    }
    
    self.currentUplaodContent = uploadContent;
}



- (void)startUpLoadWithImagesArray:(NSArray *)uploadImages result:(loadImagesArrayBlock)resultHandle
{
    if (isNull(uploadImages)) {
        NSError * error = [NSError errorWithDomain:@"上传内容为空" code:013 userInfo:@{@"descripte":@"上传内容为空"}];
        [self.delegate uploadFaild:error];
        return;
    }
    if (_delegate) {
        [_delegate uploadBegin];
    }
    
    NSMutableArray *tempArrays = [[NSMutableArray alloc]init];
    __block NSString *imgString = @"";
    dispatch_group_t group = dispatch_group_create();
        
        for (int i = 0; i < uploadImages.count; i++) {
                // 进入线程组
                dispatch_group_enter(group);
                [self uploadImage:uploadImages[i] result:^(NSString *targetImage, NSError *error) {
                    if (error) {
                        //传输失败
                        [self.delegate uploadFaild:error];
                        return;
                    }
                    imgString = [imgString stringByAppendingFormat:@"%@,", targetImage];
        //            if (targetImage.length) {
                        [tempArrays addObject:targetImage];
        //            }
                    // 离开线程组
                       dispatch_group_leave(group);
                    
                }];
            }
       
        
    
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
               NSLog(@"-----------  图片完成!");
            resultHandle(tempArrays);
               for (NSString * response in tempArrays) {
                   NSLog(@" 图片-- %@", response);
               }
               
           });
}

- (void)startComplaintUpLoadWithImagesArray:(NSArray *)uploadImages result:(loadImagesStringBlock)resultHandle
{
    if (isNull(uploadImages)) {
        NSError * error = [NSError errorWithDomain:@"上传内容为空" code:013 userInfo:@{@"descripte":@"上传内容为空"}];
        [self.delegate uploadFaild:error];
        return;
    }
    if (_delegate) {
        [_delegate uploadBegin];
    }
    
    NSMutableArray *tempArrays = [[NSMutableArray alloc]init];
    __block NSString *imgString = @"";
    for (int i = 0; i < uploadImages.count; i++) {
        [self uploadComplaintImage:uploadImages[i] result:^(NSString *targetImage, NSError *error) {
            if (error) {
                //传输失败
                [self.delegate uploadFaild:error];
                return;
            }
            imgString = [imgString stringByAppendingFormat:@"%@,", targetImage];
//            if (targetImage.length) {
                [tempArrays addObject:targetImage];
//            }

            if ([tempArrays.copy count] == uploadImages.count) {
                resultHandle(imgString);
            }

        }];
    }
}

- (void)uploadComplaintImage:(UIImage *)targetImage result:(loadImageBlock)resultHandle{
    
    
    
    NSData *imageData = [NSData zipNSDataWithImage:targetImage];
    //开始上传
    NSString *urlStr = [NSString stringWithFormat:@"%@/portal/system/file/v1/upload", [SMHttpTool shareInstance].BASEURL];
    NSDictionary *paramDict = [[NSDictionary alloc]init];
    [[NetRequest request]startUpload:urlStr uploadData:imageData params:paramDict resultHandle:^(id responseObj, NSError *err) {
        
        if (responseObj) {
            
            if ([responseObj isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *resDict = (id)responseObj;
                NSString *valueStr = [resDict objectForKey:@"value"];
                valueStr = [valueStr stringByReplacingOccurrencesOfString:@"fileId"withString:@"id"];
                valueStr = [valueStr stringByReplacingOccurrencesOfString:@"fileName"withString:@"name"];
                valueStr = [valueStr stringByReplacingOccurrencesOfString:@"filePath"withString:@"path"];
                
//                NSDictionary *valueDict = [SMBaseModelTool dictionaryWithJsonString:valueStr];
//                NSString *fileIdStr = [SMBaseModelTool getValueWithDict:valueDict andKey:@"fileId"];
//                NSString *imgUrl = [NSString stringWithFormat:@"https://smcloud-uat.shimaowy.com/portal/system/file/v1/downloadFile?fileId=%@",fileIdStr];
                resultHandle(valueStr,nil);
            }
        }
        if (err) {
            NSLog(@"%@", err);
            resultHandle(nil,err);
        }
        
    } progressHandle:^(id responseObj, NSError *err) {
        
    }];
}

- (void)uploadImage:(UIImage *)targetImage result:(loadImageBlock)resultHandle{
    
    NSData *imageData = [NSData zipNSDataWithImage:targetImage];
    //开始上传
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/portal/system/file/v1/upload", [SMHttpTool shareInstance].BASEURL];
//    NSString *urlStr = [NSString stringWithFormat:@"%@/portal/·", [SMHttpTool shareInstance].BASEURL];
    NSDictionary *paramDict = [[NSDictionary alloc]init];
    [[NetRequest request]startUpload:urlStr uploadData:imageData params:paramDict resultHandle:^(id responseObj, NSError *err) {
        
        if (responseObj) {
            
            if ([responseObj isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *resDict = (id)responseObj;
                NSString *valueStr = [resDict objectForKey:@"value"];
                NSDictionary *valueDict = [self dictionaryWithJsonString:valueStr];
                NSString *filePathStr = [self getValueWithDict:valueDict andKey:@"filePath"];
                NSString *imgUrl = [NSString stringWithFormat:@"%@/media/%@",[SMHttpTool shareInstance].BASEURL, filePathStr];
                resultHandle(imgUrl,nil);
            }
        }
        
        if (err) {
            NSLog(@"%@", err);
            resultHandle(nil,err);
        }
        
    } progressHandle:^(id responseObj, NSError *err) {
        
    }];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSString *)getValueWithDict:(NSDictionary *)dict andKey:(NSString *)key {
    
    if(![[dict allKeys] containsObject:key]){
        return @"";
    }
    
    if ([[dict objectForKey:key] isKindOfClass:[NSString class]]) {
        
        return [dict objectForKey:key];
    } else if ([[dict objectForKey:key] isKindOfClass:[NSNumber class]]) {
        NSNumber *number = [dict objectForKey:key];
        return [NSString stringWithFormat:@"%@",number];
    }
    
    return @"";
}


#pragma mark - uplaoder delegate
- (void)uploadBegin
{
    
}

- (void)uploadSuccess:(NSString *)imageKey
{
    
}

- (void)uploadFaild:(NSError *)err
{
    
}
@end
