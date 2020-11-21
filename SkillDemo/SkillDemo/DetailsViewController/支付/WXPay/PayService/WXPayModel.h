//
//  WXPayModel.h
//  ZhiTong
//
//  Created by 付凯 on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseModel.h"
#import "WXApi.h"
#import "payRequsestHandler.h"

@interface WXPayModel : BaseModel<WXApiDelegate>

/*
 appid = wxa80a90c907a38505;
 "mch_id" = 1279882801;
 "nonce_str" = a9TiK8AKxYPyIjZy;
 "prepay_id" = wx20160607212457ca717a6a620972248968;
 "result_code" = SUCCESS;
 "return_code" = SUCCESS;
 "return_msg" = OK;
 sign = 9F37FF899E99AB80ABB149998A2424BC;
 "trade_type" = APP;
 */

@property (nonatomic,strong)NSString *appid;

@property (nonatomic,strong)NSString *mch_id;

@property (nonatomic,strong)NSString *nonce_str;

@property (nonatomic,strong)NSString *prepay_id;

@property (nonatomic,strong)NSString *sign;

@property (nonatomic,strong)NSString *trade_type;

- (BOOL)sendWeixinPay;

- (BOOL)sendWeixinFulePay;

@end
