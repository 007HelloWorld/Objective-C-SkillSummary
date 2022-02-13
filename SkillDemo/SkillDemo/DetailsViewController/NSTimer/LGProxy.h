//
//  LGProxy.h
//  SkillDemo
//
//  Created by pjw on 2021/3/27.
//  Copyright © 2021 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGProxy : NSProxy

@property(nonatomic,weak)id target;

@end

NS_ASSUME_NONNULL_END
