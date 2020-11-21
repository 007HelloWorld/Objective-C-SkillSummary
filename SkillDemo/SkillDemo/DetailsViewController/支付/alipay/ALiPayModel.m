//
//  ALiPayModel.m
//  ZhiTong
//
//  Created by 付凯 on 16/6/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ALiPayModel.h"

@implementation ALiPayModel

- (instancetype)init {
    if (self = [super init]) {
        self.partner        = ALiPayPartner;
        self.seller         = ALiPaySeller;
        self.service        = @"mobile.securitypay.pay";
        self.paymentType    = @"1";
        self.inputCharset   = @"utf-8";
        self.itBPay         = @"15d";
        self.showUrl        = @"m.alipay.com";
    }
    return self;
}

// 支付宝多账户支付
- (instancetype)initWithOrderString:(NSString *)orderString {
    if (self = [super init]) {
        self.orderString = orderString;
    }
    return self;
}

- (instancetype)initWithPayMode:(int)payMode {
    if (self = [super init]) {
        if (payMode == 1) {
            self.partner = kFuelAliPayPartner;
            self.seller  = kFuelAliPaySeller;
        }
        self.payMode = payMode;
    }
    return self;
}

- (void)aliPayWithSuccessCallback:(void (^) (void))successCallback errorCallback:(void (^)(NSString *errorMsg))errorCallback{
    
    if (self.payMode == 0) {
        NSString *appScheme     = @"ztScheme";
        [[AlipaySDK defaultService] payOrder:self.orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {

            int resultStatus = [[resultDic valueForKey:@"resultStatus"] intValue];

            if (resultStatus == 9000) {

                successCallback ();
            }
            else
            {
                /*
                 9000    订单支付成功
                 8000    正在处理中
                 4000    订单支付失败
                 6001    用户中途取消
                 6002    网络连接出错
                 */
                NSString *errormsg ;

                if (resultStatus == 8000) {

                    errormsg =@"订单正在处理,请勿重复支付";
                }
                else if (resultStatus == 4000){

                    errormsg =@"订单支付失败";
                }
                else if (resultStatus == 6001){

                    errormsg =@"已取消支付";

                }
                else if (resultStatus == 6002){

                    errormsg =@"网络连接出错";
                }

                errorCallback (errormsg);
            }
            NSLog(@"%@",resultDic);

        }];
    }else {
        //将商品信息拼接成字符串
        NSString *orderSpec     = [self description];
        NSLog(@"orderSpec %@",orderSpec);
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode

        NSString *rsaPrivateKey = kFuelAliPayPrivateKey;

        id<DataSigner> signer   = CreateRSADataSigner(rsaPrivateKey);
        NSString *signedString  = [signer signString:orderSpec];
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme     = @"ztScheme";
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString   = nil;

        if (signedString != nil) {

            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];


            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {

                int resultStatus = [[resultDic valueForKey:@"resultStatus"] intValue];

                if (resultStatus == 9000) {

                    successCallback ();
                }
                else
                {
                    /*
                     9000    订单支付成功
                     8000    正在处理中
                     4000    订单支付失败
                     6001    用户中途取消
                     6002    网络连接出错
                     */
                    NSString *errormsg ;

                    if (resultStatus == 8000) {

                        errormsg =@"订单正在处理,请勿重复支付";
                    }
                    else if (resultStatus == 4000){

                        errormsg =@"订单支付失败";
                    }
                    else if (resultStatus == 6001){

                        errormsg =@"已取消支付";

                    }
                    else if (resultStatus == 6002){

                        errormsg =@"网络连接出错";
                    }

                    errorCallback (errormsg);
                }
                NSLog(@"%@",resultDic);

            }];
        }
    }

    
//    //将商品信息拼接成字符串
//    NSString *orderSpec     = [self description];
//    NSLog(@"orderSpec %@",orderSpec);
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//
//
//    NSString *rsaPrivateKey = self.payMode == 1 ? kFuelAliPayPrivateKey : ALiPayPrivateKey;
//
//
//    id<DataSigner> signer   = CreateRSADataSigner(rsaPrivateKey);
//    NSString *signedString  = [signer signString:orderSpec];
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme     = @"ztScheme";
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString   = nil;
//
//
//    if (signedString != nil) {
//
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//
//            int resultStatus = [[resultDic valueForKey:@"resultStatus"] intValue];
//
//            if (resultStatus == 9000) {
//
//                successCallback ();
//            }
//            else
//            {
//                /*
//                 9000    订单支付成功
//                 8000    正在处理中
//                 4000    订单支付失败
//                 6001    用户中途取消
//                 6002    网络连接出错
//                 */
//                NSString *errormsg ;
//
//                if (resultStatus == 8000) {
//
//                    errormsg =@"订单正在处理,请勿重复支付";
//                }
//                else if (resultStatus == 4000){
//
//                    errormsg =@"订单支付失败";
//                }
//                else if (resultStatus == 6001){
//
//                    errormsg =@"已取消支付";
//
//                }
//                else if (resultStatus == 6002){
//
//                    errormsg =@"网络连接出错";
//                }
//
//                errorCallback (errormsg);
//            }
//            NSLog(@"%@",resultDic);
//
//        }];
//    }
}

#pragma mark -- description
- (NSString *)description {
    NSMutableString * discription = [NSMutableString string];
    if (self.partner) {
        [discription appendFormat:@"partner=\"%@\"", self.partner];
    }
    if (self.seller) {
        [discription appendFormat:@"&seller_id=\"%@\"", self.seller];
    }
    if (self.tradeNO) {
        [discription appendFormat:@"&out_trade_no=\"%@\"", self.tradeNO];
    }
    if (self.productName) {
        [discription appendFormat:@"&subject=\"%@\"", self.productName];
    }
    if (self.productDescription) {
        [discription appendFormat:@"&body=\"%@\"", self.productDescription];
    }
    if (self.amount) {
        [discription appendFormat:@"&total_fee=\"%@\"", self.amount];
    }
    if (self.notifyURL) {
        [discription appendFormat:@"&notify_url=\"%@\"", self.notifyURL];
    }
    
    if (self.service) {
        [discription appendFormat:@"&service=\"%@\"",self.service];//mobile.securitypay.pay
    }
    if (self.paymentType) {
        [discription appendFormat:@"&payment_type=\"%@\"",self.paymentType];//1
    }
    
    if (self.inputCharset) {
        [discription appendFormat:@"&_input_charset=\"%@\"",self.inputCharset];//utf-8
    }
    if (self.itBPay) {
        [discription appendFormat:@"&it_b_pay=\"%@\"",self.itBPay];//15d
    }
    if (self.showUrl) {
        [discription appendFormat:@"&show_url=\"%@\"",self.showUrl];//m.alipay.com
    }
    if (self.rsaDate) {
        [discription appendFormat:@"&sign_date=\"%@\"",self.rsaDate];
    }
    if (self.appID) {
        [discription appendFormat:@"&app_id=\"%@\"",self.appID];
    }
    for (NSString * key in [self.extraParams allKeys]) {
        [discription appendFormat:@"&%@=\"%@\"", key, [self.extraParams objectForKey:key]];
    }
    return discription;
}

@end
