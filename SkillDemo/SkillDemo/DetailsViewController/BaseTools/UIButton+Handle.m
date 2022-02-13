//
//  UIButton+Handle.m
//  Image
//
//  Created by pjw on 2021/3/18.
//

#import "UIButton+Handle.h"

@implementation UIButton (Handle)

+(UIButton *)showBottomLineTitle:(NSString *)title TitleColor:(UIColor *)titleColor BottomColor:(UIColor *)bottomColor{
    
    UIButton * button = [[UIButton alloc] init];
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:title];
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    [tncString addAttribute:NSForegroundColorAttributeName value:titleColor  range:NSMakeRange(0,[tncString length])];
    [tncString addAttribute:NSUnderlineColorAttributeName value:bottomColor range:(NSRange){0,[tncString length]}];
    [button setAttributedTitle:tncString forState:UIControlStateNormal];
    return button;
}

@end
