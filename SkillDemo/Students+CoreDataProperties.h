//
//  Students+CoreDataProperties.h
//  SkillDemo
//
//  Created by pjw on 2020/8/31.
//  Copyright © 2020 pjw. All rights reserved.
//
//

#import "Students+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Students (CoreDataProperties)

+ (NSFetchRequest<Students *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;

@end

NS_ASSUME_NONNULL_END
