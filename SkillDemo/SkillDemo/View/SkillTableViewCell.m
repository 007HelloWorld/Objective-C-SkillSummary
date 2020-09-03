//
//  SkillTableViewCell.m
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "SkillTableViewCell.h"

@implementation SkillTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUi];
    }
    return self;;
}

-(void)setUi{
    [self addSubview:self.skillName];
}

- (UILabel *)skillName{
    if (!_skillName) {
        _skillName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width-20, 40)];
        _skillName.numberOfLines = 0;
    }
    return _skillName;;
}


@end
