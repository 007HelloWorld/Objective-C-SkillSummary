//
//  CameraRollVC.m
//  SkillDemo
//
//  Created by pjw on 2021/2/19.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "CameraRollVC.h"
#import "gzhPhotoManager.h"

@interface CameraRollVC ()<gzhPhotoManagerDelegate>
@property(nonatomic,strong)UIImageView * selectImageView;

@end

@implementation CameraRollVC

- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _selectImageView = [[UIImageView alloc]init];
    _selectImageView.frame = CGRectMake(100, 400, 200, 200);
    _selectImageView.contentMode = UIViewContentModeScaleAspectFit;
    _selectImageView.clipsToBounds = YES;
    _selectImageView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_selectImageView];
    
    UIButton * btn = [UIButton new];
    btn.frame = CGRectMake(100, 200, 100, 40);
    [btn setTitle:@"选择" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)save{
    //调用
    [[gzhPhotoManager instance]selectPhotoWithController:self delegate:self];
}

-(void)selectedPhotoImage:(UIImage *)image{
    _selectImageView.image = image;
}

@end
