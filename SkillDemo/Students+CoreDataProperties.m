//
//  Students+CoreDataProperties.m
//  SkillDemo
//
//  Created by pjw on 2020/8/31.
//  Copyright © 2020 pjw. All rights reserved.
//
//

#import "Students+CoreDataProperties.h"

@implementation Students (CoreDataProperties)

+ (NSFetchRequest<Students *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Students"];
}

@dynamic age;
@dynamic name;
@dynamic sex;

@end
