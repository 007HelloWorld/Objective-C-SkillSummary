//
//  BlockViewController.h
//  Image
//
//  Created by pjw on 2021/3/9.
//

#import <UIKit/UIKit.h>

typedef void(^DemoBlock)(NSString * str);

NS_ASSUME_NONNULL_BEGIN

@interface QualifierVC : UIViewController

@property(nonatomic,strong)DemoBlock demo;

@end

NS_ASSUME_NONNULL_END
