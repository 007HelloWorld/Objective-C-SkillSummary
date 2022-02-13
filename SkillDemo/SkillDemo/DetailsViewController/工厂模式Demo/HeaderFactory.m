//
//  HeaderFactory.m
//  Image
//
//  Created by pjw on 2021/3/31.
//

#import "HeaderFactory.h"
#import "FirstView.h"
#import "SecondView.h"

@implementation HeaderFactory

+(UIView *)createFirstView{
    FirstView * view = [FirstView new];
    [view setFirstStyle];
    [view isHiddenMessage:NO];
    return view;
}

+(UIView *)createSecondView{
    SecondView * view = [SecondView new];
    [view setSecondStyle];
    [view isHiddenMessage:YES];
    return view;
}


@end
