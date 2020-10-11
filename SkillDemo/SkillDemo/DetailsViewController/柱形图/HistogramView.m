//
//  HistogramView.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "HistogramView.h"

@implementation HistogramView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    //底部数据
    [self addSubview:self.bottomLabel];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(35);
    }];
    
    //柱状图
    [self addSubview:self.itemsView];
    [self.itemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomLabel.mas_top);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(0);
    }];
    
    //顶部数据
    [self addSubview:self.topLabel];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.itemsView.mas_top).offset(-2);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(20);
    }];
    
}

-(void)setModel:(HistogramModel *)model{
    _model = model;
    //顶部数据
    self.topLabel.text = [NSString stringWithFormat:@"%@",[self removeZero:(model.overallSatisfaction*100)]];
    //底部数据
    self.bottomLabel.text = [DemoUtils isNullString:model.orgName];
    //柱状图
    [self.itemsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomLabel.mas_top);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo([[self removeZero:(model.overallSatisfaction*100)] floatValue]*143.0/100.0);
    }];
    
    NSLog(@"   xxcscsasdadada         %f",[[self removeZero:(model.overallSatisfaction*100)] floatValue]*143.0/100.0);
}


#pragma 柱状图
-(UIView*)itemsView{
    if (!_itemsView) {
        _itemsView = [[UIView alloc]init];
        _itemsView.backgroundColor = [DemoUtils colorWithHexString:@"#4A5BEF" alpha:1.0];
        [_itemsView addRoundedCornersWithRadius:6.0];
    }
    return _itemsView;
}

#pragma 顶部数据
-(UILabel*)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.text = @"";
        _topLabel.numberOfLines = 1;
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _topLabel.textColor = [DemoUtils colorWithHexString:@"#4A5BEF" alpha:1.0];
    }
    return _topLabel;
}

#pragma 底部 地块 数据
-(UILabel*)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.text = @"";
        _bottomLabel.numberOfLines = 0;
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        _bottomLabel.textColor = [DemoUtils colorWithHexString:@"#3F5270" alpha:1.0];
    }
    return _bottomLabel;
}


//移除后面的0
-(NSString *)removeZero:(double )dataDouble{
    NSString *tempString = [NSString stringWithFormat:@"%.2lf",dataDouble];
    return [self removeFloatAllZeroByString:tempString];
}

-(NSString*)removeFloatAllZeroByString:(NSString *)testNumber{
    NSString *Str = @"";
    NSInteger offset = testNumber.length - 1;
    while (offset){
        Str = [testNumber substringWithRange:NSMakeRange(offset, 1)];
        if ([Str isEqualToString:@"0"]){
            offset--;
        }else if ([Str isEqualToString:@"."]){
            offset--;
            break;
        }else{
            break;
        }
    }
    NSString *outNumber = [testNumber substringToIndex:offset+1];
    return outNumber;
}

@end
