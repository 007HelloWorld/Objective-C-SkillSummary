//
//  SkillTableDataSource.h
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SkillTableDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSArray *datas;

-(instancetype)initWithCellIdentifier:(NSString *)identifier configureInfo:(void(^)(id cell,id model,NSIndexPath * indexPath))configure;


@end

NS_ASSUME_NONNULL_END
