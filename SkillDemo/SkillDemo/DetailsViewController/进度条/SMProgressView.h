//
//  SMProgressView.h
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMProgressView : UIView

/**
 *  进度条高度  height: 5~100
 */
@property (nonatomic) CGFloat progressHeight;

/**
 *  进度值  maxValue:  <= SMProgressView.width
 */
@property (nonatomic) CGFloat progressValue;

/**
 *   动态进度条颜色  Dynamic progress
 */
@property (nonatomic, strong) UIColor *trackTintColor;
/**
 *  静态背景颜色    static progress
 */
@property (nonatomic, strong) UIColor *progressTintColor;


@end

NS_ASSUME_NONNULL_END
