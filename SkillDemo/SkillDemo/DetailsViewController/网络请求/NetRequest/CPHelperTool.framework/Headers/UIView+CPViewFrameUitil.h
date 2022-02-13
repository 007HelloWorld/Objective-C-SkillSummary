//
//  UIView+CPViewFrameUitil.h
//  CatPaw
//
//  Created by lk on 2017/6/19.
//  Copyright © 2017年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKTool.h"

/**
 *  为了避免组件库进入其他项目之后使用的同名属性被其他Category方法覆盖修改
 *
 *  我们增加cucf_前缀确保始终进入正确的设置流程
 */

@interface UIView (CUCFViewFrameUitil)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat cucf_left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat cucf_top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat cucf_right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat cucf_bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat cucf_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat cucf_height;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint cucf_origin;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGFloat cucf_originY;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGFloat cucf_originX;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize cucf_size;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat cucf_centerX;

/**
 *  右上角
 *  self.origin.x+self.size.width,self.origin.y
 */
@property (nonatomic) CGPoint cucf_topRight;

/**
 *  左下角
 *
 *  self.origin.x,self.origin.y+self.size.height
 */
@property (nonatomic) CGPoint cucf_bottomLeft;

/**
 *  右下角
 *
 *  self.origin.x+self.size.width,self.origin.y+self.size.height
 */
@property (nonatomic) CGPoint cucf_bottomRight;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat cucf_centerY;

/**
 *  Shortcut for right to superview
 *  Sets frame.origin.x = superview.width - rightToSuper -frame.size.width
 */
@property (nonatomic) CGFloat cucf_rightToSuper;

/**
 *  shortcut for bottom to superview
 *  set frame.origin.y = superview.height - bottomToSuper - frame.size.height
 */
@property (nonatomic) CGFloat cucf_bottomToSuper;


@end
