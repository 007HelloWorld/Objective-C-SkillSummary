//
//  ComplexModel.m
//  Mode
//
//  Created by pjw on 2020/12/10.
//

#import "ComplexModel.h"



@implementation WHC

@end

@implementation Gcxjgdzyb

@end

@implementation Gcxjgdgzjdb

@end

@implementation SMInitDataModel

@end

@implementation Sub_gcxjgdgzjdb

@end

@implementation InstructionList

@end

@implementation DeviceList
+ (NSDictionary *)modelCustomPropertyMapper {
    // 将idString映射到key为id的数据字段
    return @{@"idString":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"instructionList" : @"InstructionList"};
}


@end

@implementation InstructionDto
+ (NSDictionary *)modelCustomPropertyMapper {
    // 将idString映射到key为id的数据字段
    return @{@"idString":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"deviceList" : @"DeviceList",
             @"instructionList" : @"InstructionList",
    };
}


@end


@implementation Sub_gcxjgdzyb


@end


@implementation ComplexModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sub_gcxjgdgzjdb" : @"Sub_gcxjgdgzjdb",
             @"sub_gcxjgdzyb" : @"Sub_gcxjgdzyb",
    };
}

@end


@implementation Data

@end


@implementation Value

@end
