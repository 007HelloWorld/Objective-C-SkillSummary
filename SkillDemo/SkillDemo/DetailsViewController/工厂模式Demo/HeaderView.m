//
//  HeaderView.m
//  Image
//
//  Created by pjw on 2021/3/31.
//

#import "HeaderView.h"

@interface HeaderView ()

@property(nonatomic,strong)UILabel * tipLabel;

@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.messageLabel = [UILabel new];
    self.messageLabel.text = @"图层请根据问题严重程度分别上传图片(最多6张)";
    self.messageLabel.textColor = [UIColor redColor];
    [self addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.offset(30);
    }];
        
    UILabel * tip = [UILabel new];
    tip.text = @"问题程度";
    self.tipLabel = tip;
    [self addSubview:tip];

    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.mas_top).offset(71);
        make.height.offset(30);
    }];
    
    [self addSubview:self.tipImage];
    [self.tipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tip);
        make.left.equalTo(tip.mas_right).offset(10);
        make.width.offset(100);
    }];
}



- (UIImageView *)tipImage{
    if (!_tipImage) {
        _tipImage = [UIImageView new];
    }
    return _tipImage;
}

-(void)isHiddenMessage:(BOOL)hidden{
    self.messageLabel.hidden = hidden;
    if (hidden) {
        [self.tipLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(20);
        }];
    }else{
        [self.tipLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(71);
        }];
    }
}



@end
