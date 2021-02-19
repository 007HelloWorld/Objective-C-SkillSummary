//
//  DemoTableViewCell.m
//  Image
//
//  Created by pjw on 2021/1/29.
//

#import "DemoTableViewCell.h"

@interface DemoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *testModeLabel;


@end

@implementation DemoTableViewCell


-(void)loadTitle:(NSString *)str{
    self.testModeLabel.text = str;
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
