//
//  UIButton+HHExtend.h
//  HHBaseDemo
//
//  Created by 浩哥哥 on 2019/2/25.
//  Copyright © 2019 浩哥哥. All rights reserved.
//
typedef enum {
    iconLeft,
    iconRight,
    iconTop,
    iconBottom
}IconDirection;


@interface UIButton (HHExtend)

-(UIButton *)initNavigationButton:(UIImage *)image;
-(UIButton *)initNavigationButtonWithTitle:(NSString *)str color:(UIColor *)color;


///设置文字和图片的方向
- (void)setIconDirection:(IconDirection)iconDirection withTitleSpace:(CGFloat)space;




@end
