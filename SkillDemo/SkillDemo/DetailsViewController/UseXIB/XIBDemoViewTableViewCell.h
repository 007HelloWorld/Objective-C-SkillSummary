//
//  XIBDemoViewTableViewCell.h
//  SkillDemo
//
//  Created by pjw on 2020/10/4.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XIBDemoViewTableViewCell : UITableViewCell
//加载xib的方法(自己写的,不是系统自带)
+(instancetype)xibTableViewCell;
@end

NS_ASSUME_NONNULL_END
