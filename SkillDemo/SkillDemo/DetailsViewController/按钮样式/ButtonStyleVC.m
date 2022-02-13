//
//  ButtonStyleVC.m
//  Image
//
//  Created by pjw on 2022/2/10.
//

#import "ButtonStyleVC.h"
#import "UIButton+HHExtend.h"

@interface ButtonStyleVC ()

@end

@implementation ButtonStyleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < 4; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100 + 80 * i, 100, 70)];
        [btn setTitle:@"按钮" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"蓝牙"] forState:UIControlStateNormal];
        if (i == 0) {
            [btn setIconDirection:iconTop withTitleSpace:10];
        }else if (i == 1){
            [btn setIconDirection:iconLeft withTitleSpace:10];
        }else if (i == 2){
            [btn setIconDirection:iconBottom withTitleSpace:10];
        }else if (i == 3){
            [btn setIconDirection:iconRight withTitleSpace:10];
        }
        
        [self.view addSubview:btn];
    }
}

@end
