//
//  HeaderFactory.h
//  Image
//
//  Created by pjw on 2021/3/31.
//

#import <Foundation/Foundation.h>

@class FirstView;
@class SecondView;

NS_ASSUME_NONNULL_BEGIN

@interface HeaderFactory : UIView

+(UIView *)createFirstView;
+(UIView *)createSecondView;

@end

NS_ASSUME_NONNULL_END
