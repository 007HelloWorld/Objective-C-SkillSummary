//
//  SMQualityInspectionMoreItem.h
//  Image
//
//  Created by pjw on 2021/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SMFacilityNameModel;

@interface SMFacilityNameCell : UICollectionViewCell

-(void)loadModel:(SMFacilityNameModel *)model;

//选中样式
-(void)selectItem;

//未选中样式
-(void)unSelectItem;

@end

NS_ASSUME_NONNULL_END
