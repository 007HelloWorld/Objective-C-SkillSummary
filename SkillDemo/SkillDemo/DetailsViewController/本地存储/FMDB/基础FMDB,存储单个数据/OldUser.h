//
//  User.h
//  Demo11
//
//  Created by pjw on 2020/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OldUser : NSObject
 
@property(nonatomic,copy)NSString * userId;
@property(nonatomic,copy)NSString * username;
@property(nonatomic,copy)NSString * userIcon;
@property(nonatomic,assign)int age;
@property(nonatomic,strong)NSDate * createTime;
@property(nonatomic,copy)NSDecimalNumber * income;
@property(nonatomic,assign)int isMan;

@end

NS_ASSUME_NONNULL_END
