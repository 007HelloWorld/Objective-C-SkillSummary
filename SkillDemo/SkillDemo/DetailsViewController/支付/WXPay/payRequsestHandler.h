

#import <Foundation/Foundation.h>
#import "WXUtil.h"
#import "ApiXml.h"

// 账号帐户资料
//更改商户把相关参数后可测试

//#define APP_ID          @"wx9fce0509363293c9"               //APPID
//// ---- 弃用
////#define APP_ID          @"wxa80a90c907a38505"               //APPID
//#define APP_SECRET      @"8dea971664df0706ad3092be948646ad" //appsecret
//#define APP_Description @"ZT3000"
////商户号，填写商户对应参数
//#define MCH_ID          @"1407869202"
////----- 弃用
////#define MCH_ID          @"1279882801"
////商户API密钥，填写相应参数
//#define PARTNER_ID      @"jslhwljsb1qazxsw2zt3000wechatpay"
//// ---- 弃用
////#define PARTNER_ID      @"linghaozhitongsanqianyanfabu3000"
////支付结果回调页面
//#define NOTIFY_URL      @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"
////获取服务器端支付数据地址（商户自定义）
//#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"







@interface payRequsestHandler : NSObject{
	//预支付网关url地址
    NSString *payUrl;

    //lash_errcode;
    long     last_errcode;
	//debug信息
    NSMutableString *debugInfo;
    
    NSString *appid,*mchid,*spkey;
}
//初始化函数
-(BOOL) init:(NSString *)app_id mch_id:(NSString *)mch_id;
-(NSString *) getDebugifo;
//设置商户密钥
-(void) setKey:(NSString *)key;
//创建package签名
//-(NSString*) createMd5Sign:(NSMutableDictionary*)dict;

- ( NSMutableDictionary *)hylg_sendPay:(NSString *)prePayid;

@end
