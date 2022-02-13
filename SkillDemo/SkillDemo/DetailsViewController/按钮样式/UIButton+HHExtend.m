//
//  UIButton+HHExtend.m
//  HHBaseDemo
//
//  Created by 浩哥哥 on 2019/2/25.
//  Copyright © 2019 浩哥哥. All rights reserved.
//

#import "UIButton+HHExtend.h"

#undef    NAV_BUTTON_MIN_WIDTH
#define    NAV_BUTTON_MIN_WIDTH    (40.0f)

#undef    NAV_BUTTON_MIN_HEIGHT
#define    NAV_BUTTON_MIN_HEIGHT    (40.0f)

#undef    NAV_BAR_HEIGHT
#define    NAV_BAR_HEIGHT    (44.0f)

@implementation UIButton (HHExtend)

-(UIButton *)initNavigationButton:(UIImage *)image{
    CGRect buttonFrame = CGRectZero;
    
    buttonFrame = CGRectMake(0, 0, image.size.width, NAV_BAR_HEIGHT);
    
    if ( buttonFrame.size.width >= NAV_BUTTON_MIN_WIDTH )
    {
        buttonFrame.size.width = NAV_BUTTON_MIN_WIDTH;
    }
    
    if ( buttonFrame.size.height >= NAV_BUTTON_MIN_HEIGHT )
    {
        buttonFrame.size.height = NAV_BUTTON_MIN_HEIGHT;
    }
    
    self = [self initWithFrame:buttonFrame];
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundColor = [UIColor clearColor];
    [self setImage:image forState:UIControlStateNormal];
    return self;
}
-(UIButton *)initNavigationButtonWithTitle:(NSString *)str color:(UIColor *)color{
    CGRect buttonFrame = CGRectZero;
    
    CGSize titleSize = [str boundingRectWithSize:CGSizeMake(999999.0f, NAV_BAR_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;
    
    
    buttonFrame = CGRectMake(0, 0, titleSize.width, NAV_BAR_HEIGHT);
    
    self = [self initWithFrame:buttonFrame];
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitle:str forState:UIControlStateNormal];
    return self;
}


- (void)setIconDirection:(IconDirection)iconDirection withTitleSpace:(CGFloat)space
{
    CGFloat imgWidth = self.imageView.bounds.size.width;
    CGFloat imgHeight = self.imageView.bounds.size.height;
    CGFloat labWidth = self.titleLabel.bounds.size.width;
    CGFloat labHeight = self.titleLabel.bounds.size.height;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (labWidth < frameSize.width) {
        labWidth = frameSize.width;
    }
    
    CGFloat kMargin = space;
    switch (iconDirection) {
            case iconLeft://图左字右
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -kMargin, 0, kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, kMargin, 0, -kMargin)];
            break;
            case iconRight://图右字左
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, labWidth + kMargin, 0, -labWidth - kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth - kMargin, 0, imgWidth + kMargin)];
            break;
            case iconTop://图上字下
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, labHeight + space, -labWidth)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imgHeight + space, -imgWidth, 0, 0)];
            break;
            case iconBottom://图下字上
            [self setImageEdgeInsets:UIEdgeInsetsMake(labHeight + space,0, 0, -labWidth)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth, imgHeight + space, 0)];
            
            break;
        default:
            break;
    }
    
    
    
    
}



@end
