//
//  BtnClickV.h
//  SkillDemo
//
//  Created by pjw on 2020/9/26.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface BtnClickV : UIView

@property (strong, nonatomic) UIButton * btn;/*! 外漏的按钮 */
@property (strong, nonatomic) RACSubject * btnClickSignal;

@end

NS_ASSUME_NONNULL_END
