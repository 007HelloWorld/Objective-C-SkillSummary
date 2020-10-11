//
//  MainTabBar.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "MainTabBar.h"

/** 屏幕宽高 **/
#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height
#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)


@implementation MainTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.barTintColor = [UIColor yellowColor];
        self.translucent = NO;
        self.plusItem = [[UIButton alloc] init];
        self.plusItem.adjustsImageWhenHighlighted = NO; // 去除选择时高亮
        [self.plusItem setBackgroundImage:[UIImage imageNamed:@"new_order_gowork"] forState:UIControlStateNormal];
        [self addSubview:self.plusItem];
        
        //去掉tabBar顶部线条
        CGRect rect = CGRectMake(0, 0, kScreenW, kScreenH);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self setBackgroundImage:img];
        [self setShadowImage:img];
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width / 2;
    
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    NSInteger index = 0;
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *child in self.subviews) {
        if ([child isKindOfClass:class]) {
            CGFloat width = itemWidth;
            CGFloat height = child.frame.size.height;
            CGFloat x = index * width;
            CGFloat y = child.frame.origin.y;
            child.frame = CGRectMake(x, y, width, height);
            index++;
            if (index == 2) {
                
                CGFloat plusX = [UIScreen mainScreen].bounds.size.width / 2 - 21;
                CGFloat plusY = 0;
                if (IS_IPhoneX_All) {
                    plusY = 6;
                }else{
                    plusY = 3;
                }
                
                self.plusItem.frame = CGRectMake(plusX, plusY, self.plusItem.currentBackgroundImage.size.width, self.plusItem.currentBackgroundImage.size.height);
                index ++;
            }
        }
    }
    [self bringSubviewToFront:self.plusItem];
}

#pragma mark - 处理超出区域点击无效的问题
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.hidden) {
        return [super hitTest:point withEvent:event];
    } else {
        //转换坐标
        CGPoint tempPoint = [self convertPoint:point toView:self.plusItem];
        //判断点击的点是否在按钮区域内
        if ([self.plusItem pointInside:tempPoint withEvent:event]) {
            return self.plusItem;
        } else {
            return [super hitTest:point withEvent:event];
        }
    }
}
@end
