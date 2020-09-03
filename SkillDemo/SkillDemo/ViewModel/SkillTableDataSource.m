//
//  SkillTableDataSource.m
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "SkillTableDataSource.h"
#import "SkillTableViewCell.h"

@interface SkillTableDataSource ()
@property (nonatomic,copy) void (^configure) (id cell,id model, NSIndexPath *indexPath);
@property (nonatomic,copy) NSString *identifier;
@end


@implementation SkillTableDataSource

-(instancetype)initWithCellIdentifier:(NSString *)identifier configureInfo:(void(^)(id cell,id model,NSIndexPath * indexPath))configure{
    if (self == [super init]) {
        _configure = configure;
        _identifier = identifier;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SkillTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.identifier];
    if (cell == nil) {
        cell = [[SkillTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.identifier];
    }
    if (self.configure) {
        self.configure(cell, self.datas[indexPath.row], indexPath);
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

@end
