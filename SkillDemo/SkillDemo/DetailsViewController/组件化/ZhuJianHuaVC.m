//
//  ZhuJianHuaVC.m
//  SkillDemo
//
//  Created by pjw on 2021/3/27.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "ZhuJianHuaVC.h"

@interface ZhuJianHuaVC ()

@end

@implementation ZhuJianHuaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
        什么是组件化
        将一个工程分解为各个组件，然后按照某种方式任意组织成为一个拥有完整业务逻辑的工具
        
        组件化的优点
        1、组件的独立性
        2、资源重用
        3、高效迭代
        4、配合我们二进制，加快项目的编译速度
     
        组件划分
        基础组件
        基础配置(宏,常量)分类，网络(AFN,SDW二次封装)、工具类(日期时间的处理,文件处理，设备处理)
     
        功能组件
        控件(弹幕，轮播器，选项卡);功能(断点续传，音频处理)
     
        业务组件
        业务线一        业务线二
     
     
    */
    
    /*
        制作本地仓库
        1、cd到一个文件中，这个文件即你需要创建私有库的方法
        2、执行pod lib create PJWUtils
        3、等待网络响应
        4、What platform do you want to use?? [ iOS / macOS ]
            选择iOS
        5、What language do you want to use?? [ Swift / ObjC ]
            选择ObjC
        6、Would you like to include a demo application with you library? [Yes / No]
            选择YES
        7、Which testing frameworks will you use? [Specta / Kiwi / None]
            选择None
        8、Would you like to do view based testing? [Yes / No]
            选择No
        9、What is your class prefix?
             填写PJW
        10、随后项目会被自动打开
        11、我们需要在Pod下面的Development Pods文件夹下的项目名称文件夹下，将ReplaceMe替换
        12、将自己的代码放到Class中
        13、podfile文件中的头部，use_frameworks!，如果不使用了这个，就是把podfile里面的东西编译成.a的静态库
            如果使用了之后，就是把podfile里面的东西生成相应的framework
     
        制作远程仓库
        1、在码云网站上创建一个项目
        2、将本地代码提交到本地仓库中
        3、通过git remote add origin 后面跟着https
        4、执行git push origin master -f   将代码强制提交远程仓库
     
        
        修改项目中的Podspec Metadata下面的demo.podspec
        这个里面就是这个私有库的描述信息
        替换里面的s.source  使用码云上的项目地址
     
        打个tag
        执行git tag 0.1.0
        执行git push --tags
       
        将spec提交到远程中
        执行
        pod repo push LGSpecs LGUtils.podspec
        
     
        探讨下面这个方法是干嘛的
        pod repo add LGSpecs
        
     
     
     */

}

@end
