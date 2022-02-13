//
//  HeaderView.h
//  Image
//
//  Created by pjw on 2021/3/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderView : UIView

@property(nonatomic,strong)UILabel * messageLabel;

@property(nonatomic,strong)UIImageView * tipImage;

-(void)isHiddenMessage:(BOOL)hidden;


@end

NS_ASSUME_NONNULL_END
