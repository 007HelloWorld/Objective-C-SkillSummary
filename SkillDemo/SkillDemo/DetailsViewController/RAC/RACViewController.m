//
//  RACViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/9/26.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "RACViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "BtnClickV.h"

@interface RACViewController ()
@property (nonatomic, assign) int  age;
@property (nonatomic, assign) int  height;
@end
#define REGEX_MOBILE @"^1\\d{10}$"

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //按钮
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 150, 100, 50)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"你点击了我");
    }];

    //KVO
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(100, 250, 100, 40)];
    lab.text = @"点击屏幕";
    lab.textColor = [UIColor orangeColor];
    [self.view addSubview:lab];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.height = 100;
    [[self rac_valuesForKeyPath:@"age" observer:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"获取到的值   %@",x);
    }];
    
    //通知
    NSMutableDictionary * para = [NSMutableDictionary dictionary];
    para[@"age"] = @"18";
    para[@"height"] = @"180";
    
    NSNotification * noti = [[NSNotification alloc]initWithName:@"NOTI" object:nil userInfo:para];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
    
    
    //UITextField
    UITextField * tf = [[UITextField alloc]initWithFrame:CGRectMake(40, 320, 200, 60)];
    tf.placeholder = @"限制11位手机号码";
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:tf];
    
    /*!       用RAC去做一个手机号码的校验及11位限制        */
    [[tf.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        //限制输入11位手机号码
        if (value.length > 11) {
            tf.text = [value substringToIndex:11];
            return NO;
        }else{
            return YES;
        }
        
    }] subscribeNext:^(NSString * _Nullable x) {
        //当输入的手机号码长度为11位时，进行下面的判断
        if (x.length == 11) {
            BOOL isyes = [self isValidateMobile:x];
            if (isyes) {
                NSLog(@"    RAC  是正确号码    ");
            }else{
                NSLog(@"    RAC 不是正确号码  ");
            }
            NSLog(@"    RAC 拿到里面的数据            %@",tf.text);
        }
    }];
    
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 400, 100, 50)];
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitle:@"取值" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    [[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"取值   %@",tf.text);
    }];
    
    
    /*! 需要注意是命名尽量规范，否则以后维护起来你会很痛苦。 */
    BtnClickV * v = [[BtnClickV alloc]initWithFrame:CGRectMake(20, 500, 200, 200)];
    [v.btnClickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"拿到回调数据          %@",x);
    }];
    [self.view addSubview:v];
}

//判断是否为正确的手机号
- (BOOL)isValidateMobile:(NSString *)mobileString {
    
    NSString *regex = REGEX_MOBILE;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobileString];
    
    if (isMatch) {
        return YES;
    }
    return NO;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.age ++;
}

@end
