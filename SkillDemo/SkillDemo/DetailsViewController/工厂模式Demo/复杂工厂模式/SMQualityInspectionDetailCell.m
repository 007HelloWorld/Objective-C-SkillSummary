//
//  SMQualityInspectionDetailCell.m
//  SMProject
//
//  Created by pjw on 2021/2/2.
//  Copyright © 2021 xuhan. All rights reserved.
//

#import "SMQualityInspectionDetailCell.h"
#import "BaseTools.h"

#define QUALIFIEDITEMHEIGHT 110

@interface SMQualityInspectionDetailCell ()
///合格
@property (weak, nonatomic) IBOutlet UIButton *qualifiedBtn;
///不合格按钮
@property (weak, nonatomic) IBOutlet UIButton *noQualifiedBtn;

///派单按钮
@property (weak, nonatomic) IBOutlet UIButton *sendOrdersBtn;
///查看派单按钮
@property(nonatomic,strong)UIButton * viewSendOrder;

///附件
@property (weak, nonatomic) IBOutlet UIView *accessoryBackView;
///问题描述
@property (weak, nonatomic) IBOutlet UIView *describeBackView;

///抽样检查比例
@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *hiddenView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;




@end

@implementation SMQualityInspectionDetailCell

#pragma mark -----------------------初始化布局
- (void)awakeFromNib {
    [super awakeFromNib];

    self.section = 0;
    
}

- (UIButton *)viewSendOrder{
    if (!_viewSendOrder) {
        _viewSendOrder = [UIButton showBottomLineTitle:@"查看派单" TitleColor:RGB(74, 91, 239, 1) BottomColor:RGB(74, 91, 239, 1)];
        _viewSendOrder.hidden = YES;
        _viewSendOrder.titleLabel.font = [UIFont systemFontOfSize:14];
        [_viewSendOrder addTarget:self action:@selector(viewSenderHandel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _viewSendOrder;
}

-(void)viewSenderHandel{
    if (self.viewOrdersBlock) {
        self.viewOrdersBlock();
    }
}

- (void)setModel:(SMQualityInspectionDetailModel *)model{
    _model = model;
    
}






#pragma mark -----------------------事件点击区域
//合格点击事件
- (IBAction)qualifiedEvent:(UIButton *)sender {
    [self.hiddenView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(0.01);
    }];
    self.hiddenView.hidden = YES;
    self.model.itemHeight = 154;
    
    if (self.uploadPhotoBlock) {
        self.uploadPhotoBlock(self.section);
    }
}

//不合格点击事件
- (IBAction)noQualifiedEvent:(UIButton *)sender {
    [self.hiddenView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(361);
    }];
    self.hiddenView.hidden = NO;
    self.model.itemHeight = 515;
   
    if (self.uploadJiGePhotoBlock) {
        self.uploadJiGePhotoBlock(self.section);
    }
}

#pragma mark -----------------------UICollectionView代理方法区域
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

-(void)uploadItemHeight{
    if (self.uploadItemHeightBlock) {
        self.uploadItemHeightBlock(self.section);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}











- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)unclickable{

}

-(void)canClickable{

}


@end


