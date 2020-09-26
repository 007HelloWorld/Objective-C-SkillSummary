//
//  SafetyViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/9/3.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "SafetyViewController.h"
#import "RSA.h"

@interface SafetyViewController ()

@end

@implementation SafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
        RSA用的时候需要注意的事情
        1、加密后的数据，需要base64编码
        2、iOS端生成私钥
        新建一个文件，用来保持生成的私钥和公钥，
        打开终端cd进入到新建的文件夹中，生成私钥，执行
        openssl genrsa -out rsa_private_key.pem 1024
        在执行
        openssl pkcs8 -topk8 -inform PEM -in rsa_private_key.pem -outform PEM -nocrypt
        这一步一定要有，需要将私钥转成PKCS8的格式才能使用，此时复制私钥
     
        3、iOS端生成公钥
        在终端继续执行
        openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem
        在新建的文件中就多了一个公钥文件，可以用编辑器打开
     
    */
    
    self.view.backgroundColor = [UIColor whiteColor];

    //公钥
       NSString *publicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDdWOCSKTZT0+KyGPQJ2l+oTbxdOQw+TGQwn1iobaq34mNgcRdX3g50YxlRtBz4QQkqWYVk7IXgwPTMxW6ZOFjYMRsKSX7d7yEjshMbhwm2wgISO6pN0/THoZilWD36uF4goy7VqQ2iyFVkbALfqYdF77MmHPh+ET1dXOrpMz+5pQIDAQAB";
       //私钥
       NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAN1Y4JIpNlPT4rIY9AnaX6hNvF05DD5MZDCfWKhtqrfiY2BxF1feDnRjGVG0HPhBCSpZhWTsheDA9MzFbpk4WNgxGwpJft3vISOyExuHCbbCAhI7qk3T9MehmKVYPfq4XiCjLtWpDaLIVWRsAt+ph0XvsyYc+H4RPV1c6ukzP7mlAgMBAAECgYAr8MLUAR5p0bxFArMfaZxnutbT4slNbLjO9jMRbIPhcS2tLYYmyUwxSqLyF0FQ/wgkwhS7DkEddvCh3eewvwDTu2AKyjYksu3yj97VB2maVLy9Ihva8RFEmkWvEystnsn3vlTAY8jMfv1A3VPIcGwId1GXoYzpqJtYpclcC9LFWQJBAP7u3DpoSe+VUHt3nZiXti6i4QnKmhqRwQEYDo+o0wL+8Qd00nX6OBiSF3pA/2syHv1o5Xwp5m9coYAPG2MQUbsCQQDeRghQKXNGDnO+RhNGvnkIWevV9kVRLCIQ5IXEAza0AKV3+65DJfyJtlEGmjYcUjjxstZtem3O4SRdliZqejwfAkA8BnPWUM3v2oFrwNtbnYUo7/L6wjiMvvrpzgdHriGZF/wanFgdrT/eES/z+i/pxpBjbHp0RM1cNTxVkbkKF0KXAkEAzGx4ZNFadUoBZTOpstynD+kznzq6EaeXRRYHeHjELNSTWkAcyyD6m+UTrBDUR0PPn2stDs8UgrpJ6dCYUEFPXQJACAK9gHImAEwtU0ljTjsRGpI33O0xSmAw+K41/dhTzAKbcV7tDftOozun5DdbKu6vmk38Nme0hqFeynAfAuaDrw==";

        //测试要加密的数据
       NSString *sourceStr = @"iOS端RSA";
       //公钥加密
       NSString *encryptStr = [RSA encryptString:sourceStr publicKey:publicKey];
       //私钥解密
       NSString *decrypeStr = [RSA decryptString:encryptStr privateKey:privateKey];
       NSLog(@"加密后的数据 %@ 解密后的数据 %@",encryptStr,decrypeStr);
    
    
}



@end
