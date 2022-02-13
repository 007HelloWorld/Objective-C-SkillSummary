//
//  UIButton+Handle.h
//  Image
//
//  Created by pjw on 2021/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Handle)
///底部加横线
+(UIButton *)showBottomLineTitle:(NSString *)title TitleColor:(UIColor *)titleColor BottomColor:(UIColor *)bottomColor;

@end

NS_ASSUME_NONNULL_END
