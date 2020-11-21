//
//  SVGAViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/11/15.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "SVGAViewController.h"
#import <SVGA.h>

@interface SVGAViewController ()<SVGAPlayerDelegate>

@property (nonatomic, strong) SVGAParser *parser;
@property (nonatomic, strong) SVGAPlayer *aPlayer;

@end

@implementation SVGAViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat orginY = 100;
    CGFloat orginX = 40;
    CGFloat weight = [UIScreen mainScreen].bounds.size.width - 2*orginX;
    CGFloat height = 440;
    
    //加上最新的动画效果
    self.aPlayer.frame = CGRectMake(orginX, orginY, weight, height);
    self.aPlayer.delegate = self;
    [self.view addSubview:self.aPlayer];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.parser parseWithNamed:@"站内信" inBundle:[NSBundle mainBundle] completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (videoItem != nil) {
            self.aPlayer.videoItem = videoItem;
            [self.aPlayer startAnimation];
        }
    } failureBlock:^(NSError * _Nonnull error) {
        
    }];

}

- (void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player{
    [self.aPlayer removeFromSuperview];
}



- (SVGAPlayer *)aPlayer {
    if (_aPlayer == nil) {
        _aPlayer = [[SVGAPlayer alloc] init];
        _aPlayer.loops = 0;
        _aPlayer.clearsAfterStop = YES;
    }
    return _aPlayer;
}

- (SVGAParser *)parser {
    if (_parser == nil) {
        _parser = [[SVGAParser alloc] init];
    }
    return _parser;
}


@end
