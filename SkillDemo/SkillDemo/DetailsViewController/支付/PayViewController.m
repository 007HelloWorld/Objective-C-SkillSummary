//
//  PayViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/10/6.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "PayViewController.h"
#import "ALiPayModel.h"





@interface PayViewController (){
    NSMutableData* _responseData;
}

//银联支付
@property(nonatomic, copy)NSString *tnMode;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 4; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100 + 100 * i, 100, 60)];
        if (i == 0) {
            [btn setTitle:@"微信支付" forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setTitle:@"支付宝" forState:UIControlStateNormal];
        }else if (i == 2){
            [btn setTitle:@"银联支付" forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    if (index == 0) {
        [self wxPay];
    }else if (index == 1){
        [self zfbPay];
    }else if (index == 2){
        [self ylPay];
    }
}

-(void)wxPay{
//    
//    [WXApi registerApp:APP_ID withDescription:APP_Description];
//
//    NSDictionary * dict = @{@"payMsg":@"alipay_sdk=alipay-sdk-java-3.3.1&app_id=2016120904071956&biz_content=%7B++++%22out_trade_no%22%3A%2201161221120151619865%22%2C++++%22total_amount%22%3A11.34%2C++++%22subject%22%3A%22%E8%81%9A%E4%B9%99%E7%83%AF%E9%86%87%22%2C++++%22product_code%22%3A%22QUICK_MSECURITY_PAY%22++%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Ftest.faker.asia%2Farchitecture-payment%2Fitface%2Ffree%2Fpayment%2Falipay%2Fnotify.htm&return_url=http%3A%2F%2F192.168.2.205%3A16580%2Fh5%2Fpay%2FreturnUrl&sign=F1LR8Th2dPa6ZWCmfN95WBpRfIkCXVkWO7rYtUYE9rw9aTsTwq1kr0XRCbX0TaONCwsYnWjN0bTF5EZmCZVLThbno7r7iAPUfhuygYxG2EjdITsFKXEq5IqR%2FoK4Yf1pvTGUCSd%2BfXV%2B0W%2BGMj5vervRY1HUEDbvWnBF2DASDaJ4YxLpMFgHpXYl0fzO%2FtBYCChZ8BewhPOAWuHfpGo94%2FStK9rJORNa1xhtY%2FA8NH13ZoYHvS3fUVrlFAxQ1Hl6%2BKZkpHm2xlvwhZ387I0jwf8Y2vTtO2qux7D6xFB%2FZYafRMt3aZlcX6Vl1OakuO6FrzgRwIsrnnzE2s9R7FXRww%3D%3D&sign_type=RSA2&timestamp=2019-01-15+16%3A47%3A00&version=1.0"};
//
//    WXPayModel *wxPayModel = [[WXPayModel alloc] initWithDictionary:dict];
//
//    [wxPayModel sendWeixinPay];
}

-(void)zfbPay{
    WEAKSELF

    NSString *payMsg = @"alipay_sdk=alipay-sdk-java-3.3.1&app_id=2016120904071956&biz_content=%7B++++%22out_trade_no%22%3A%2201161221120151619865%22%2C++++%22total_amount%22%3A11.34%2C++++%22subject%22%3A%22%E8%81%9A%E4%B9%99%E7%83%AF%E9%86%87%22%2C++++%22product_code%22%3A%22QUICK_MSECURITY_PAY%22++%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Ftest.faker.asia%2Farchitecture-payment%2Fitface%2Ffree%2Fpayment%2Falipay%2Fnotify.htm&return_url=http%3A%2F%2F192.168.2.205%3A16580%2Fh5%2Fpay%2FreturnUrl&sign=j7mVzofD5faVTu1UfrNVSStUzusKvKYK%2B7CTeL1yvTlxY2SpJB%2BFLWvLx6d6r8TnzGlO4np7jdQPjy2gYLrHxqaYNQYa%2F6coDFz6EP%2FRRDmadpvD7g7%2Brbm01dSLPdrmo%2B06jYjSw7tWoCPvDae0irLc77NkyXEHemlPM5DVDHBFDQi6Dv2q5H0f%2FUnc4hA8X1%2FWcLcXNmUgLH11aSjvTNkVNKuBrjK8f96IWQwhOZyOugKXj8rWviev%2FPh3%2FzNnv1HgfRoNPabAciKUNXu0wNF0U5%2BlhhlaIfV3aMy76A%2B9wFNLRDT0SqFBoC%2F403BHq1wKuPEoRPt1VTtlGzOlAw%3D%3D&sign_type=RSA2&timestamp=2019-01-15+15%3A33%3A47&version=1.0";

    ALiPayModel *alipayModel = [[ALiPayModel alloc] initWithOrderString:payMsg];

    [alipayModel aliPayWithSuccessCallback:^{

        SHOW_TIP_IN_WINDOW(@"支付成功");


    } errorCallback:^(NSString *errorMsg) {

        SHOW_TIP_IN_WINDOW(errorMsg);
    }];
}

-(void)ylPay{
    
    self.tnMode = kMode_Development;
    [self startNetWithURL:[NSURL URLWithString:kURL_TN_Normal]];
}

- (void)startNetWithURL:(NSURL *)url
{
    [MBProgressHUD showHUDInView:self.view withText:@"加载中"];

    NSURLRequest * urlRequest=[NSURLRequest requestWithURL:url];
    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [urlConn start];
    
    
    
}


#pragma mark - connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    NSInteger code = [rsp statusCode];
    if (code != 200)
    {

//        [self showAlertMessage:kErrorNet];
        [connection cancel];
    }
    else
    {

        _responseData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    [self hideAlert];
    [MBProgressHUD hideHUDForView:self.view];
    NSString* tn = [[NSMutableString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    if (tn != nil && tn.length > 0)
    {

        NSLog(@"tn=%@",tn);
        [[UPPaymentControl defaultControl] startPay:tn fromScheme:@"PayStyle" mode:self.tnMode viewController:self];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//    [self showAlertMessage:kErrorNet];
}



#pragma mark UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    NSString* msg = [NSString stringWithFormat:kResult, result];
//    [self showAlertMessage:msg];
}


@end
