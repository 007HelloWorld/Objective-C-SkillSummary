//
//  ProgressBarViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "ProgressBarViewController.h"
#import "SMProgressView.h"

@interface ProgressBarViewController ()
@property (nonatomic, strong) SMProgressView *profitProView;//

@end

@implementation ProgressBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.profitProView.progressValue = 300*79/100.0;
    [self.view addSubview:self.profitProView];
    
    
}


-(SMProgressView*)profitProView{
    if (!_profitProView) {
        _profitProView = [[SMProgressView alloc] initWithFrame:CGRectMake(20, 100, 300, 30)];
        _profitProView.progressHeight = 5;
        _profitProView.progressTintColor = [UIColor redColor];
        _profitProView.trackTintColor = [UIColor blueColor];
    }
    return _profitProView;
}



@end
