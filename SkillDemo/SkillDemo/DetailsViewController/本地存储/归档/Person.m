//
//  Person.m
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "Person.h"

@implementation Person


//保存到文件的时候调用
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInteger:self.age forKey:@"age"];
}

//读取一个文件的时候调用
- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self == [super init]) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.age = [coder decodeIntegerForKey:@"age"];
    }
    return self;
}

//ios11以后新增
+(BOOL)supportsSecureCoding{
    return YES;
}

@end
