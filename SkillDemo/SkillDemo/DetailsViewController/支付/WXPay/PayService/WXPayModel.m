//
//  WXPayModel.m
//  ZhiTong
//
//  Created by 付凯 on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WXPayModel.h"

@implementation WXPayModel

- (BOOL)sendWeixinPay{

    if (![WXApi isWXAppInstalled]) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [MBProgressHUD showMessageInView:keyWindow withText:@"未安装微信"];
        return NO;
    }
    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    [req hylg_sendPay:self.prepay_id];
    return YES;
}

- (BOOL)sendWeixinFulePay{
    
    if (![WXApi isWXAppInstalled]) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [MBProgressHUD showMessageInView:keyWindow withText:@"未安装微信"];
        return NO;
    }
    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:@"wx4af62862b574d2fc" mch_id:@"1481672182"];
    //设置密钥
    [req setKey:@"jslhwljsb1qazxsw2zt3000wechatpay"];
    [req hylg_sendPay:self.prepay_id];
    return YES;
}

@end
