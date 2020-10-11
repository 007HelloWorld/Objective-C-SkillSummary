//
//  HistogramView.h
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistogramModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistogramView : UIView

@property (nonatomic, strong) UIView *itemsView;//柱状图
@property (nonatomic, strong) UILabel *topLabel;//顶部数据
@property (nonatomic, strong) UILabel *bottomLabel;//底部数据
@property (nonatomic, strong) HistogramModel * model;//数据


@end

NS_ASSUME_NONNULL_END
