//
//  gzhPhotoManager.m
//  Image
//
//  Created by pjw on 2021/2/19.
//

#import "gzhPhotoManager.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>

@interface gzhPhotoManager () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) id<gzhPhotoManagerDelegate> delegate;
@property (nonatomic, assign) CGSize photoSize;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) UIViewController *controller;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@end


@implementation gzhPhotoManager

+ (instancetype)instance {
     static gzhPhotoManager * shareInstance = nil;
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
         shareInstance = [[gzhPhotoManager alloc]init];
     });
     return shareInstance;
 }
 -(void)selectPhotoWithController:(id )controller delegate:(id)target{

     _controller = controller;
     _delegate = target;

     UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
     [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
     [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

         [self cameraCheck:action];
     }]];
     [alertVC addAction:[UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

         [self phAuthorizationCheck:action];
     }]];
     [_controller presentViewController:alertVC animated:YES completion:nil];
 }


 -(void)cameraCheck:(UIAlertAction *)action{
     /*
      AVAuthorizationStatusNotDetermined = 0,// 系统还未知是否访问，第一次开启相机时
      AVAuthorizationStatusRestricted, // 受限制的
      AVAuthorizationStatusDenied, //不允许
      AVAuthorizationStatusAuthorized // 允许状态
      */
 
    ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
    if (author == AVAuthorizationStatusRestricted || author ==AVAuthorizationStatusDenied) {
        [self alertViewWithTitle:@"提示" message:@"如需拍照,请检查拍照功能是否开启,可在:设置->隐私->照相.设置"];
    }else if (author == AVAuthorizationStatusAuthorized){
        [self selectCamera:action];
    }else if (author == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                //允许访问
                [self selectCamera:action];
            }else{
                //不允许访问
                [self alertViewWithTitle:@"提示" message:@"如需拍照,请检查拍照功能是否开启,可在:设置->隐私->照相.设置"];
            }
        }];
    }
}
 
  //判断是否有权限访问相簿
- (void)phAuthorizationCheck:(UIAlertAction *)action{
      /*
      PHAuthorizationStatusNotDetermined,     用户还没有做出选择
      PHAuthorizationStatusDenied,            用户拒绝当前应用访问相册(用户当初点击了"不允许")
      PHAuthorizationStatusAuthorized         用户允许当前应用访问相册(用户当初点击了"好")
      PHAuthorizationStatusRestricted,        因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
      */

     // 判断授权状态
     PHAuthorizationStatus statu = [PHPhotoLibrary authorizationStatus];
     if (statu == PHAuthorizationStatusRestricted) {
         NSLog(@"无法访问相簿--PHAuthorizationStatusRestricted");
         [self alertViewWithTitle:@"提示" message:@"如需拍照,请检查拍照功能是否开启,可在:设置->隐私->照片.设置"];
     } else if (statu == PHAuthorizationStatusDenied) {
         NSLog(@"无法访问相簿--PHAuthorizationStatusDenied");
         [self alertViewWithTitle:@"提示" message:@"如需拍照,请检查拍照功能是否开启,可在:设置->隐私->照片.设置"];
     } else if (statu == PHAuthorizationStatusAuthorized) {
         NSLog(@"可以访问相簿--PHAuthorizationStatusAuthorized");
         [self selectPhotoLibrary:action];
     } else if (statu == PHAuthorizationStatusNotDetermined) {
         // 弹框请求用户授权
         NSLog(@"第一次访问--PHAuthorizationStatusNotDetermined");
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {

             if (status == PHAuthorizationStatusAuthorized) {
                 [self selectPhotoLibrary:action];
             }else{
                 [self alertViewWithTitle:@"提示" message:@"如需拍照,请检查拍照功能是否开启,可在:设置->隐私->照片.设置"];
             }
         }];
     }
 }

// 拍照
- (void)selectCamera:(UIAlertAction *)action {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {         dispatch_async(dispatch_get_main_queue(), ^{
            [self alertViewWithTitle:@"警告" message:@"对不起,您的设备不存在相机"];
    });
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.imagePickerController) {
            self.imagePickerController = [UIImagePickerController new];
            self.imagePickerController.delegate = self;
         }
         if (self.photoSize.width!=0 && self.photoSize.height!=0) {
             self.imagePickerController.allowsEditing = YES;
         }else{
             self.imagePickerController.allowsEditing = NO;
         }

        self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        [self.controller presentViewController:self.imagePickerController animated:YES completion:nil];
    });
 }

 // 从相册中选择
 - (void)selectPhotoLibrary:(UIAlertAction *)action {
     if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
         dispatch_async(dispatch_get_main_queue(), ^{
              [self alertViewWithTitle:@"警告" message:@"对不起，您的设备不存在相册"];
         });

     }
     
     
     dispatch_async(dispatch_get_main_queue(), ^{
         if (!self.imagePickerController) {
             self.imagePickerController = [UIImagePickerController new];
             self.imagePickerController.delegate = self;
         }
         if (self.photoSize.width!=0&&self.photoSize.height!=0) {
             self.imagePickerController.allowsEditing = YES;
         }else{
             self.imagePickerController.allowsEditing = NO;
         }
         self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
         self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
         [self.controller presentViewController:self.imagePickerController animated:YES completion:nil];
     });
 }

 #pragma mark - UIImagePickerViewController delegate
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

     NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
     if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
         if (_photoSize.height!=0&&_photoSize.width!=0) {
             UIImage *image = [self fixOrientation:[info objectForKey:UIImagePickerControllerEditedImage]];
             self.image = [self scaleImage:image Tosize:self.photoSize];
             if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
                 UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
             }
         }else{
             UIImage *image = [self fixOrientation:[info objectForKey:UIImagePickerControllerOriginalImage]];
             self.image = [self scaleImage:image Tosize:self.photoSize];
             if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
                 UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
             }
         }
         [picker dismissViewControllerAnimated:YES completion:^{
             if (self.delegate && [self.delegate respondsToSelector:@selector(selectedPhotoImage:)]) {
                 if (self.image) {
                     [self.delegate selectedPhotoImage:self.image];
                 } else {
                     [self alertViewWithTitle:@"你还没选择图片呢" message:nil];
                 }
             }
         }];
     }
 }

 -(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
     [picker dismissViewControllerAnimated:YES completion:nil];
 }
 // 裁剪图片
 - (UIImage *)scaleImage:(UIImage *)img Tosize:(CGSize)size {

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGSize imgSize = CGSizeMake(0, 0);
    if (size.width != 0 && size.height != 0) {
        imgSize = CGSizeMake(size.width, img.size.height*(size.width/img.size.width));
    } else {
        imgSize = CGSizeMake(screenWidth*2, img.size.height*(screenWidth/img.size.width)*2);
    }
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(imgSize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}


 //修正image方向
- (UIImage *)fixOrientation:(UIImage *)aImage {


    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;

    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
             break;
    }

    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                              CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                              CGImageGetColorSpace(aImage.CGImage),
                                              CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
             // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
     // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


 // 提醒
- (void)alertViewWithTitle:(NSString *)title message:(NSString *)msg {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [_controller presentViewController:alertVC animated:YES completion:nil];
}

@end

