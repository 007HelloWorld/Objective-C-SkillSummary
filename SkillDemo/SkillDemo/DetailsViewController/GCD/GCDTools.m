//
//  GCDTools.m
//  SkillDemo
//
//  Created by pjw on 2021/3/13.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "GCDTools.h"

@implementation GCDTools

+(instancetype)shareGCDTools{
    
    static id tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tool) {
            tool = [[self alloc]init];
        }
    });
    return tool;
}

-(void)say{
    NSLog(@"wwwww");
}

@end
