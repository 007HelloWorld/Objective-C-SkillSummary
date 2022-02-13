//
//  NSString+FilePath.m
//  SkillDemo
//
//  Created by pjw on 2021/3/13.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "NSString+FilePath.h"

@implementation NSString (FilePath)

-(instancetype)appendCache{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];
}

-(instancetype)appendTemp{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[self lastPathComponent]];
}

-(instancetype)appendDocument{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];

}

@end
