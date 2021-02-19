//
//  AlineOfButtonVC.m
//  SkillDemo
//
//  Created by pjw on 2021/2/19.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "AlineOfButtonVC.h"
#import "SMFacilityNameModel.h"
#import "SMFacilityNameCell.h"

@interface AlineOfButtonVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * collectionV;
@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation AlineOfButtonVC

- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 12.5;

    self.dataArr = [NSMutableArray array];
    for (int i = 0; i < 6; i ++) {
        SMFacilityNameModel * model = [SMFacilityNameModel new];
        if (i == 0) {
            model.title = @"弱电井";
            model.lanYa = 0;
            model.complete = NO;
        }else if (i == 1){
            model.title = @"弱电井弱电井";
            model.lanYa = 0;
            model.complete = YES;
        }else if (i == 2){
            model.title = @"弱电井弱电井弱电井";
            model.lanYa = 1;
            model.complete = NO;
        }else if (i == 3){
            model.title = @"弱电井弱电井弱电井弱电井";
            model.lanYa = 1;
            model.complete = YES;
        }else if (i == 4){
            model.title = @"弱电井弱电井弱电井弱电井弱电井";
            model.lanYa = 2;
            model.complete = NO;
        }else if (i == 5){
            model.title = @"弱电井弱电井弱电井弱电井弱电井弱电井";
            model.lanYa = 2;
            model.complete = YES;
        }
        [self.dataArr addObject:model];
    }

    if (self.dataArr.count > 0) {
        [self uploadIconNum:self.dataArr];
    }

    [self.view addSubview:self.collectionV];

    [self.collectionV reloadData];
}

-(void)uploadIconNum:(NSMutableArray *)modelArr{
    for (SMFacilityNameModel * model in modelArr) {
        if (model.lanYa == 0 && model.complete == NO) {
            model.iconNum = 0;
        }else if (model.lanYa == 0 && model.complete == YES){
            model.iconNum = 1;
        }else if(model.lanYa == 1 && model.complete == NO){
            model.iconNum = 1;
        }else if (model.lanYa == 1 && model.complete == YES){
            model.iconNum = 2;
        }else if (model.lanYa == 2 && model.complete == NO){
            model.iconNum = 1;
        }else if (model.lanYa == 2 && model.complete == YES){
            model.iconNum = 2;
        }
    }
    [self.collectionV reloadData];
}

#pragma mark -----------------------UICollectionView代理方法区域
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"   点击了我     ");
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{

}

//边距设置:整体边距的优先级，始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);//分别为上、左、下、右
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    SMFacilityNameCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SMFacilityNameCell" forIndexPath:indexPath];
    [cell loadModel:self.dataArr[indexPath.item]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //标题长度
    SMFacilityNameModel * model = self.dataArr[indexPath.item];
    CGFloat titleW = [self hx_getTextWidthWithText:model.title height:30 font:[UIFont systemFontOfSize:14]];
    //是否需要多放出来宽度
    CGFloat iconW = 0;
    if (model.iconNum == 1){
        iconW = 16;
    }else if (model.iconNum == 2){
        iconW = 32;
    }

    return CGSizeMake(titleW + iconW + 28, 30);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.collectionV reloadData];

    SMFacilityNameModel * model = self.dataArr[0];
    model.lanYa = 2;
    model.complete = YES;
    [self uploadIconNum:self.dataArr];

}

//collectionV
-(UICollectionView *)collectionV{
    if (!_collectionV) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
//        layout.itemSize = CGSizeMake(500, 30);
//        layout.minimumInteritemSpacing = 10;
//        layout.minimumLineSpacing = 10;
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 30) collectionViewLayout:layout];
        _collectionV.backgroundColor = [UIColor whiteColor];
        _collectionV.tag = 11;
        _collectionV.dataSource = self;
        _collectionV.delegate = self;
        _collectionV.bounces = NO;
        _collectionV.alwaysBounceHorizontal = YES;
        _collectionV.alwaysBounceVertical = NO;
        _collectionV.showsHorizontalScrollIndicator = NO;
        _collectionV.showsVerticalScrollIndicator = NO;
        [_collectionV registerNib:[UINib nibWithNibName:@"SMFacilityNameCell" bundle:nil] forCellWithReuseIdentifier:@"SMFacilityNameCell"];
    }
    return _collectionV;
}

//根据文本字数/文本宽度约束/文本字体 求得text的width
- (CGFloat)textWidthWithText:(NSString*)text
               ContentHeight:(CGFloat)height
                        font:(UIFont*)font
{
    CGSize size = CGSizeMake(MAXFLOAT, height);
    return [self textSizeWithText:text ContentSize:size font:font].width;
}

//根据字数的不同,返回UILabel中的text文字需要占用多少Size
- (CGSize)textSizeWithText:(NSString*)text
               ContentSize:(CGSize)size
                      font:(UIFont*)font
{
    return [text boundingRectWithSize:size
                              options:
            NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font}
                              context:nil].size;
}

- (CGFloat)hx_getTextWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font {
    CGSize newSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return newSize.width;
}

@end
