//
//  Person.h
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<NSCoding,NSSecureCoding>//NSSecureCoding  ios11以后新增

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger age;

@end

NS_ASSUME_NONNULL_END
