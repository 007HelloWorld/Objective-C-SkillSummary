//
//  CoverView.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:1];
    UIView * tipV = [[UIView alloc]initWithFrame:CGRectMake(100, 200, self.frame.size.width-200, 400)];
    tipV.backgroundColor = [UIColor orangeColor];
    [self addSubview:tipV];
}


@end
