//
//  BaseModel.m
//  ZhiTong
//
//  Created by 付凯 on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dictionary];
        
//        self = [NSClassFromString(self.className) modelWithDictionary:dictionary];
        
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
//    NSLog(@"className : %@ \n undefinedKey: %@ \n  value: %@",[self className],key,value);
}


@end
