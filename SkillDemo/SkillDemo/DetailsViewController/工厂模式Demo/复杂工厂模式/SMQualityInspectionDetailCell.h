//
//  SMQualityInspectionDetailCell.h
//  SMProject
//
//  Created by pjw on 2021/2/2.
//  Copyright © 2021 xuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMQualityInspectionDetailModel.h"
NS_ASSUME_NONNULL_BEGIN




typedef void(^SendOrdersEventBlock)(NSInteger index);
typedef void(^ViewOrdersEventBlock)(void);

typedef void(^UploadItemHeightBlock)(NSInteger index);

typedef void(^UploadPhotoBlock)(NSInteger index);
typedef void(^UploadJIGEPhotoBlock)(NSInteger index);
typedef void(^ViewImageBlock)(NSInteger index,NSInteger picIndex);



@interface SMQualityInspectionDetailCell : UITableViewCell
///问题描述控件

///检查内容描述
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
///派单
@property(nonatomic,copy)SendOrdersEventBlock sendOrdersBlock;
///查看派单
@property(nonatomic,copy)ViewOrdersEventBlock viewOrdersBlock;
///更新item高度
@property(nonatomic,copy)UploadItemHeightBlock uploadItemHeightBlock;
///点击不合格图片上传的操作
@property(nonatomic,copy)UploadPhotoBlock uploadPhotoBlock;
///上传及格图片上传的操作
@property(nonatomic,copy)UploadJIGEPhotoBlock uploadJiGePhotoBlock;
///放大图片
@property(nonatomic,copy)ViewImageBlock viewImageBlock;
///及格不及格的事件

///检查内容索引
@property(nonatomic,assign)NSInteger section;

@property(nonatomic,strong)SMQualityInspectionDetailModel * model;



///当为查兰派单的时候，不可点击
-(void)unclickable;

///当为派单模式先，可以进行点击
-(void)canClickable;


@end

NS_ASSUME_NONNULL_END
