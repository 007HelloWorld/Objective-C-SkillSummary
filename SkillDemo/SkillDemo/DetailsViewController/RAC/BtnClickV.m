//
//  BtnClickV.m
//  SkillDemo
//
//  Created by pjw on 2020/9/26.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "BtnClickV.h"

@implementation BtnClickV

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
    
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 100, 40)];
        [btn setTitle:@"点我" forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        btn.tag = 200;
        btn.backgroundColor = [UIColor orangeColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"---------你点击了我------------");
            /*! RAC下的代理 */
            [_btnClickSignal sendNext:@"我可以代替代理了哦"];
        }];
        [self addSubview:btn];
    }
    return self;
}

-(RACSubject *)btnClickSignal{
    
    if (!_btnClickSignal) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}


@end
