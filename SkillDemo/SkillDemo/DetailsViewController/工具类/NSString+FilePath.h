//
//  NSString+FilePath.h
//  SkillDemo
//
//  Created by pjw on 2021/3/13.
//  Copyright © 2021 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FilePath)

-(instancetype)appendCache;

-(instancetype)appendTemp;

-(instancetype)appendDocument;

@end

NS_ASSUME_NONNULL_END
