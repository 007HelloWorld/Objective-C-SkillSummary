//
//  SMQualityInspectionMoreItem.m
//  Image
//
//  Created by pjw on 2021/2/3.
//

#import "SMFacilityNameCell.h"
#import "SMFacilityNameModel.h"


@interface SMFacilityNameCell ()

@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UIImageView *itemIocn0;
@property (weak, nonatomic) IBOutlet UIImageView *itemIcon1;


@end


@implementation SMFacilityNameCell

-(void)loadModel:(SMFacilityNameModel *)model{
    self.itemTitle.text = model.title;
    
    if (model.lanYa == 0 && model.complete == NO) {
        [self noLanYaNoComplete];
        model.iconNum = 0;
    }else if (model.lanYa == 0 && model.complete == YES){
        [self noLanYaComplete];
        model.iconNum = 1;
    }else if(model.lanYa == 1 && model.complete == NO){
        [self lanYaFailNoComplete];
        model.iconNum = 1;
    }else if (model.lanYa == 1 && model.complete == YES){
        [self lanYaFailHaveComplete];
        model.iconNum = 2;
    }else if (model.lanYa == 2 && model.complete == NO){
        [self lanYaSucceedNoComplete];
        model.iconNum = 1;
    }else if (model.lanYa == 2 && model.complete == YES){
        [self lanYaSucceedComplete];
        model.iconNum = 2;
    }
    
    if (model.isSelect) {//选中
//        self.itemTitle.textColor = [UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>]
    }else{//未选中
        
    }
    
}


//没有蓝牙   没有完成
-(void)noLanYaNoComplete{
    self.itemIocn0.hidden = YES;
    self.itemIcon1.hidden = YES;
}

//没有蓝牙   已完成
-(void)noLanYaComplete{
    self.itemIocn0.hidden = NO;
    self.itemIcon1.hidden = YES;
    self.itemIocn0.image = [UIImage imageNamed:@"已完成圆圈"];
}

//未检查到蓝牙，未完成
-(void)lanYaFailNoComplete{
    self.itemIocn0.hidden = NO;
    self.itemIcon1.hidden = YES;
    self.itemIocn0.image = [UIImage imageNamed:@"蓝牙"];
}

//未检查到蓝牙，已完成
-(void)lanYaFailHaveComplete{
    self.itemIocn0.hidden = NO;
    self.itemIcon1.hidden = NO;
    self.itemIocn0.image = [UIImage imageNamed:@"灰色蓝牙"];
    self.itemIcon1.image = [UIImage imageNamed:@"已完成圆圈"];
}

//有检查到蓝牙，未完成
-(void)lanYaSucceedNoComplete{
    self.itemIocn0.hidden = NO;
    self.itemIcon1.hidden = YES;
    self.itemIocn0.image = [UIImage imageNamed:@"蓝牙"];
}

//有检查到蓝牙，已完成
-(void)lanYaSucceedComplete{
    self.itemIocn0.hidden = NO;
    self.itemIcon1.hidden = NO;
    self.itemIocn0.image = [UIImage imageNamed:@"蓝牙"];
    self.itemIcon1.image = [UIImage imageNamed:@"已完成圆圈"];
}


//选中样式
-(void)selectItem{
    self.itemTitle.textColor = [UIColor colorWithRed:63/256.0 green:82/256.0 blue:112/256.0 alpha:1];
}

//未选中样式
-(void)unSelectItem{
    self.itemTitle.textColor = [UIColor colorWithRed:156/256.0 green:165/256.0 blue:182/256.0 alpha:1];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
