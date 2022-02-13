//
//  KVOModel.h
//  SkillDemo
//
//  Created by pjw on 2021/4/11.
//  Copyright © 2021 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVODog.h"
NS_ASSUME_NONNULL_BEGIN

@interface KVOModel : NSObject

@property(nonatomic,copy)NSString * age;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,strong)KVODog * dog;


@end

NS_ASSUME_NONNULL_END
