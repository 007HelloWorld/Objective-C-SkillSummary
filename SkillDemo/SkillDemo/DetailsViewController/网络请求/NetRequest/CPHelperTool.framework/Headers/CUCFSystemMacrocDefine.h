//
//  CUCFSystemMacrocDefine.h
//  CatPaw
//
//  Created by lk on 2017/6/19.
//  Copyright © 2017年 lk. All rights reserved.
//

#import "CUCFSystemUitil.h"

/**
 *  去除performSelector警告
 *
 *  @param code 需要屏蔽警告的代码
 *
 *  @return
 */
#define CUCFSystemRemovePerformSelectorLeakWarning(code)                    \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")

/**
 *  当前App的版本号 float型
 */
#define CUCFSystemAppFloatVersion [CUCFSystemUitil appFloatVersion]

/**
 *  当前App的版本号 字符串型
 */
#define CUCFSystemAppStringVersion [CUCFSystemUitil appStringVersion]

/**
 *  当前AppBundle版本号
 */
#define CUCFSystemAppBundleIntVersion [CUCFSystemUitil appBundleIntVersion]

/**
 *  当前AppBundle版本号
 */
#define CUCFSystemAppBundleStringVersion [CUCFSystemUitil appBundleStringVersion]

/**
 *  当前App的bundleIdentifier
 */
#define CUCFSystemAppBundleIdentifier [CUCFSystemUitil appBundleIdentifier]

/**
 *  屏幕绝对画布
 */
#define CUCFSystemScreenBounds [CUCFSystemUitil screenBounds]

/**
 *  获取系统版本号
 */
#define CUCFSystemFloatVersion [CUCFSystemUitil currentSystemFloatVersion]

/**
 *  Description
 */
#define CUCFSystemStringVersion [CUCFSystemUitil currentSystemStringVersion]

/**
 *  Description
 */
#define CUCFSystemName [CUCFSystemUitil currentSystemName]

/**
 *  获取系统版本号
 */
#define CUCFSystemVersion [CUCFSystemUitil currentSystemVersion]

/**
 *  当前屏幕缩放倍数 float
 */
#define CUCFScreenScale [CUCFSystemUitil currentScreenScale]

/**
 *  当前屏幕缩放倍数 字符串
 */
#define CUCFScreenStringScale [CUCFSystemUitil currentScreenStringScale]

/**
 *  系统是否超过5.0
 */
#define CUCFSystemIsOver5 [CUCFSystemUitil isSystemVersionOver:5.0]

/**
 *  系统是否超过6.0
 */
#define CUCFSystemIsOver6 [CUCFSystemUitil isSystemVersionOver:6.0]

/**
 *  系统是否超过7.0
 */
#define CUCFSystemIsOver7 [CUCFSystemUitil isSystemVersionOver:7.0]

/**
 *  系统是否超过8.0
 */
#define CUCFSystemIsOver8 [CUCFSystemUitil isSystemVersionOver:8.0]

/**
 *  系统是否超过9.0
 */
#define CUCFSystemIsOver9 [CUCFSystemUitil isSystemVersionOver:9.0]

/**
 *  系统是否超过11.0
 */
#define CUCFSystemIsOver11 [CUCFSystemUitil isSystemVersionOver:11.0]

/**
 *  获取屏幕大小
 */
#define CUCFSystemScreenSize [CUCFSystemUitil deviceScreenSize]

/**
 *  750获取等比宽
 */
#define CUCFGeometricWidth(originalWidth) [CUCFSystemUitil geometricWidthOriginalWidth:originalWidth]

/**
 *  750获取等比高
 */
#define CUCFGeometricHeight(originalHeight) [CUCFSystemUitil geometricHeightOriginalHeight:originalHeight]

/**
 *  750获取等比Y
 */
#define CUCFGeometricY(originalY) [CUCFSystemUitil geometricYOriginalY:originalY]

/**x
 *  750获取等比X
 */
#define CUCFGeometricX(originalX) [CUCFSystemUitil geometricXOriginalX:originalX]

/**
 *  750获取字号
 */
#define CUCFGeometricFont(originalFont) [CUCFSystemUitil geometricXOriginalFont:originalFont]

/**
 *  获取屏幕宽度
 */
#define CUCFSystemScreenWidth [CUCFSystemUitil deviceScreenSize].width
/**
 *  获取屏幕高度
 */
#define CUCFSystemScreenHeight [CUCFSystemUitil deviceScreenSize].height
/**
 *  获取TableView实际高度
 */
#define CUCFSystemScreenHeightForMainTabBar CUCFSystemScreenHeight-123.0f

#define CUCFSystemScreenHeightForsubTabBar CUCFSystemScreenHeight-49.0f

/**
 *  是否iPhone4
 */
#define CUCFSystemiPhone4 [CUCFSystemUitil iPhone4Device]

/**
 *  是否iPhone5
 */
#define CUCFSystemiPhone5 [CUCFSystemUitil iPhone5Device]

/**
 *  是否iPhone6
 */
#define CUCFSystemiPhone6 [CUCFSystemUitil iPhone6Device]

/**
 *  是否iPhoneX
 */
#define CUCFSystemiPhoneX [CUCFSystemUitil iPhoneXDevice]

/**
 *  是否iPhone6 plus
 */
#define CUCFSystemiPhone6Plus [CUCFSystemUitil iPhone6PlusDevice]

/**
 *  是否iPad
 */
#define CUCFSystemiPad [CUCFSystemUitil iPadDevice]

/**
 *  系统UINavigationBar高度
 */
#define CUCFSystemNavigationBarHeight [CUCFSystemUitil naivationBarHeight]

/**
 *  Y轴增量
 */
#define CUCFSystemOriginYDelta 20.f

/**
 *  AppDelegate
 */
#define CUCFApplicationDelegate [UIApplication shareApplication].delegate

/**
 *  创建对象弱引用
 */
#define CUCFWeakObject(anObject)  __weak __typeof(anObject)

/**
 *  创建对象强引用
 */
#define CUCFStrongObject(anObject) __strong __typeof(anObject)

/**
 *  创建self弱引用
 */
#define CUCFWeakSelf CUCFWeakObject(self)

/**
 *  创建self强引用
 */
#define CUCFStrongSelf CUCFStrongObject(CUCFWeakSelf)

/**
 *  系统通知中心
 */
#define CUCFNotificationCenter [CUCFSystemUitil defaultCenter]

/**
 *  系统通知中心发noti名字的通知
 */
#define CUCFNotificationPost(noti) [CUCFSystemUitil postNoti:noti]

/**
 *  系统通知中心发noti名字的通知，携带参数对象object
 */
#define CUCFNotificationPostObj(noti,object) [CUCFSystemUitil postNoti:noti withObject:object]

/**
 *  系统通知中心发noti名字的通知，携带参数对象object ,携带用户自定义信息userInfo
 */
#define CUCFNotificationPostObjUserInfo(noti,object,userInfo) [CUCFSystemUitil postNoti:noti withObject:object withUserInfo:userInfo]

/**
 *  注册通知
 */
#define CUCFNotificationAdd(_noParamsFunc, _notifyName)  [[NSNotificationCenter defaultCenter] \
addObserver:self \
selector:@selector(_noParamsFunc) \
name:_notifyName \
object:nil];

/**
 *  获取mainBundle
 */
#define CUCFMainBundle [NSBundle mainBundle]

/**
 *  获取mainBundle内名字为fileName的文件的路径
 */
#define CUCFMainBundlePath(fileName) [CUCFSystemUitil mainBundlePath:fileName]

/**
 *  获取路径为bundlePath的指定bundle中文件名为fileName的文件路径
 */
#define CUCFBundlePath(bundlePath,fileName) [CUCFSystemUitil bundle:bundlePath file:fileName]


/**
 *  运行时给一个对象添加一个成员，添加的associateKey必须是一个静态常量字符串 static NSString * const associateKey = @"";
 */
#define CUCFAssociateOriginWithObject(originObj,associateObj,associateKey) [CUCFSystemUitil originObject:originObj associateObject:associateObj byKey:associateKey]

/**
 *  通过key获取运行时加入的成员
 */
#define CUCFGetAssociateObject(originObj,associateKey) [CUCFSystemUitil associateObjectFromOrigin:originObj byKey:associateKey]

/**
 *  移除辅助成员
 */
#define CUCFAssociateRemove(originObj) [CUCFSystemUitil associateRemoveFromOrigin:originObj]

/**
 *  照相机是否可用
 */
#define CUCFCameraIsAvailable [CUCFSystemUitil cameraAvailable]

/**
 *  前置摄像头是否可用
 */
#define CUCFFrontCameraAvailable [CUCFSystemUitil frontCameraAvailable]

/**
 *  照相机闪光灯是否可用
 */
#define CUCFCameraFlashAvailable [CUCFSystemUitil cameraFlashAvailable]

/**
 *  是否支持发短信
 */
#define CUCFSystemCanSendSMS [CUCFSystemUitil canSendSMS]

/**
 *  是否支持打电话
 */
#define CUCFSystemCanMakePhoneCall [CUCFSystemUitil canMakePhoneCall]

/**
 *  当前是否有网络链接
 */
#define CUCFNetworkIsAvailable [CUCFSystemUitil networkAvailable]

/**
 *  App是否有权限访问照片库
 */
#define CUCFAppCanAccessPhotoLibrary [CUCFSystemUitil isAppPhotoLibraryAccessAuthorized]

/**
 *  App是否有权限访问相机
 */
#define CUCFAppCanAccessCamera [CUCFSystemUitil isAppCameraAccessAuthorized]

/**
 *  获取屏幕Y轴起始点
 */
#define CUCFAppSelfViewFrameOrangeY [CUCFSystemUitil getSelfViewFrameOrangeY]

/**
 *  系统是否 >=7.0 <7.1
 */
#define CUCFSystemVersionIs7 [CUCFSystemUitil isSystemVersionIs7]


#define WEAKSELF __weak __typeof(self)weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

/**
 *  打印
 */
#ifdef DEBUG
#define CPLog(fmt,...)NSLog((@"%s [Line%d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define CPLog(...)
#endif


/**
 *  完美解决Xcode NSLog打印不全的宏 亲测目前支持到8.2bate版
 */
#ifdef DEBUG
//#define NSLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define NSLog(format, ...)
#endif

