//
//  EwmViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "EwmViewController.h"
#import "MMScanViewController.h"

@interface EwmViewController ()

@end

@implementation EwmViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self addQrCode];
}

/**添加扫描二维码*/
- (void)addQrCode
{
    WS(weakSelf);
    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeQrCode onFinish:^(NSString *result, NSError *error) {
        if (error) {
            NSLog(@"error: %@",error);
        } else {
            if (result.length == 0) {
                return;
            }
            
            NSDictionary *dictTemp = [JsonString dictionaryWithJsonString:result];
            if([dictTemp isKindOfClass:[NSDictionary class]] && dictTemp[@"type"] && [dictTemp[@"type"] intValue] == 1){
                //goto
//                [self gotoHealthReportPage:dictTemp];
                return ;
            }
            if([dictTemp isKindOfClass:[NSDictionary class]] && dictTemp[@"type"] && [dictTemp[@"type"]isEqualToString:@"smrk"]){
                
//                SMBaseWebView *webView = [[SMBaseWebView alloc]init];
//                NSString *htmlStr = [NSString stringWithFormat:@"%@&userid=%@",dictTemp[@"url"],[SMBaseModelTool getUserMessageWithKey:UserAccountKey]];
//                //加载网页
//                webView.urlString = htmlStr;
//                [self.navigationController pushViewController:webView animated:YES];
                
                return;
            }
            
//            SMResourceInfoViewController *resourceInfoVC = [[SMResourceInfoViewController alloc] init];
//            resourceInfoVC.resultString = result;
//
//            NSLog(@"resourceInfoVC.resultString=====%@",resourceInfoVC.resultString);
//            [self.navigationController pushViewController:resourceInfoVC animated:YES];

        }
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
}


@end
