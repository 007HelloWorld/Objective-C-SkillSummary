//
//  NetworkRequestVC.m
//  Image
//
//  Created by pjw on 2021/2/20.
//

#import "NetworkRequestVC.h"
#import "SMHttpTool.h"
#import "NetRequest.h"
#import "FGUploadImageManager.h"

@interface NetworkRequestVC ()

@end

@implementation NetworkRequestVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    //登录
//    [self login];
//    
//    //发送网络请求
//    [self acquireData];
//    
//    
//    //上传图片
//    [self uploadImage];

    
}

-(void)login{
    [[SMHttpTool shareInstance]ucAuthAutoWithSuccessed:@{@"username":@"",@"password":@""} success:^(NSInteger code, id responseObject) {
        
    } faild:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)acquireData{
    
    NSString * url = [NSString stringWithFormat:@"%@/appcenter/api/appcenter/v1/readMeter/getMeterInfo",[SMHttpTool shareInstance].BASEURL];
    NSMutableDictionary * param = [NSMutableDictionary new];
    [param setValue:@"baseId" forKey:@"id"];
    [param setValue:@"readMeterType" forKey:@"readMeterType"];
    
    [[NetRequest request]startPatrolRequest:url requestM:@"POST" params:param resultHandle:^(id responseObj, NSError *err) {
        
    }];
}

-(void)uploadImage{
    
    //上传当前索引的图片
    FGUploadImageManager * manager = [FGUploadImageManager new];
    [manager upLoadImageWithImageArray:@[] completeBlock:^(NSArray *imageUrlArr) {
        
    }];
    
}




@end
