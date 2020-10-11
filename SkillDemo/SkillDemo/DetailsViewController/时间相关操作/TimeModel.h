//
//  TimeModel.h
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeModel : NSObject

@property (nonatomic, strong) NSNumber *selectNumber;//选中 状态
@property (nonatomic, copy) NSString *monthStr;//中文月数
@property (nonatomic, copy) NSString *eMonthStr;//英文 月数
@property (nonatomic, copy) NSString *yearsStr;//年月数

@end

NS_ASSUME_NONNULL_END
