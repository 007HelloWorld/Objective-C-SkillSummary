//
//  SMQualityInspectionMoreModel.h
//  Image
//
//  Created by pjw on 2021/2/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMFacilityNameModel : NSObject

@property(nonatomic,copy)NSString * title;
@property(nonatomic,assign)NSInteger lanYa;//0无蓝牙       1蓝牙检查失败     2蓝牙检查成功
@property(nonatomic,assign)BOOL complete;//NO完成     YES已完成
@property(nonatomic,assign)NSInteger iconNum;//0无图片     1有一张图片      2有两张图片
@property(nonatomic,assign)BOOL isSelect;//NO未选中     YES已选中



@end

NS_ASSUME_NONNULL_END
