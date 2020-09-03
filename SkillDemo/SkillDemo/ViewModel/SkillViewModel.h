//
//  SkillViewModel.h
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^succ)(id datas);
typedef void(^fail)(void);

@interface SkillViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *datas;/**<数据*/

- (instancetype)initWithSucc:(succ)succ fail:(fail)fail;

- (void)refreshAction;


@end

NS_ASSUME_NONNULL_END
