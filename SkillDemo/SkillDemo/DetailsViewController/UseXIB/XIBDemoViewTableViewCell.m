//
//  XIBDemoViewTableViewCell.m
//  SkillDemo
//
//  Created by pjw on 2020/10/4.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "XIBDemoViewTableViewCell.h"

@implementation XIBDemoViewTableViewCell

+(instancetype)xibTableViewCell{
    return [[[NSBundle mainBundle] loadNibNamed:@"XIBDemoViewTableViewCell" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
