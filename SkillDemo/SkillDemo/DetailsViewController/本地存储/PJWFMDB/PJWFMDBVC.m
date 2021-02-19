//
//  PJWFMDBVC.m
//  SkillDemo
//
//  Created by pjw on 2021/1/23.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "PJWFMDBVC.h"
#import <BGFMDB.h>
#import "people.h"

#define BGTablename @"pjw"

@interface PJWFMDBVC ()

@property(nonatomic,strong)UILabel * tipLabel;
@property(nonatomic,strong)People * modelP;
@property(nonatomic,strong)NSMutableArray * imageArr;


@end

@implementation PJWFMDBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

//    bg_setDebug(YES);//打开调试模式,打印输出调试信息.

    UILabel * la = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 40)];
    self.tipLabel = la;
    la.textAlignment = NSTextAlignmentCenter;
    la.textColor = [UIColor orangeColor];
    [self.view addSubview:la];
    
    //读取数据
    for (int i = 0; i < 4; i ++) {
        UIButton * btn = [UIButton new];
        btn.frame = CGRectMake(100, 200+60*i, 100, 40);
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        if (i == 0) {
            [btn setTitle:@"增加" forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setTitle:@"删除" forState:UIControlStateNormal];
        }else if (i == 2){
            [btn setTitle:@"修改" forState:UIControlStateNormal];
        }else if (i == 3){
            [btn setTitle:@"查询" forState:UIControlStateNormal];
        }
        [self.view addSubview:btn];
    }
    
    //获取存储数据        modelP
    People * model = [[People bg_findAll:BGTablename] firstObject];
    self.modelP = model;
    
    
    
    
    
}

-(void)save:(UIButton *)sender{
    if (sender.tag == 100) {
        [self add];
    }else if (sender.tag == 101){
        [self delete];
    }else if (sender.tag == 102){
        [self update];
    }else if (sender.tag == 103){
        [self query];
    }
}

-(void)add{
    
    People * model = [[People bg_findAll:BGTablename] firstObject];
    if (!model) {
        People* p = [self people];
        p.bg_tableName = BGTablename;//自定义数据库表名称(库自带的字段).
        [p bg_coverAsync:^(BOOL isSuccess) {//覆盖存储，即清除之前的数据，只存储当前的数据
            if (isSuccess) {
                NSLog(@"存储成功");
                self.modelP = p;
            }else{
                NSLog(@"存储失败");
            }
        }];
    }
}

-(void)delete{
    [People bg_deleteAsync:BGTablename where:nil complete:^(BOOL isSuccess) {
        NSLog(@"删除成功");
    }];
}

-(void)update{
    
    //更改一级目录的数据
//    self.modelP.bg_tableName = BGTablename;//自定义的数据库表名称(库自带的字段).  bg_equal
//    NSString * where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"name"),bg_sqlValue(self.modelP.name)];
//    self.modelP.name = [self name];
//    [self.modelP bg_updateAsyncWhere:where complete:^(BOOL isSuccess) {
//        if (isSuccess) {
//            NSLog(@"成功");
//        }else{
//            NSLog(@"失败");
//        }
//    }];
//    People *model = [[People bg_findAll:BGTablename] firstObject];
//    NSLog(@" 查看数据0    %@",model.name);
    
    
    //更改二级目录的数据
    self.modelP.bg_tableName = BGTablename;//自定义的数据库表名称(库自带的字段).  bg_equal
    NSString * where = [NSString stringWithFormat:@"where %@",bg_keyPathValues(@[@"user.name",bg_equal,self.modelP.user.name])];
    self.modelP.user.name = [self name];
    [self.modelP bg_updateAsyncWhere:where complete:^(BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"成功");
        }else{
            NSLog(@"失败");
        }
    }];
    People *model = [[People bg_findAll:BGTablename] firstObject];
    NSLog(@" 查看数据0    %@",model.user.name);
    
    
//    更改三级目录的数据
//    self.modelP.bg_tableName = BGTablename;//自定义的数据库表名称(库自带的字段).  bg_equal
//    NSString * where = [NSString stringWithFormat:@"where %@",bg_keyPathValues(@[@"user.student.num",bg_equal,self.modelP.user.student.num])];
//    self.modelP.user.student.num = [self name];
//    [self.modelP bg_updateAsyncWhere:where complete:^(BOOL isSuccess) {
//        if (isSuccess) {
//            NSLog(@"成功");
//        }else{
//            NSLog(@"失败");
//        }
//
//        People *model = [[People bg_findAll:BGTablename] firstObject];
//        NSLog(@" 查看数据0    %@",model.user.student.num);
//    }];

    
    //更改四级目录的数据,对于数组的存储，使用先修改，后删除缓存，在删除
//    self.modelP.bg_tableName = BGTablename;//自定义的数据库表名称(库自带的字段).  bg_equal
//    NSMutableArray * arr = [NSMutableArray arrayWithArray:self.modelP.user.student.names];
//    [arr replaceObjectAtIndex:0 withObject:[self name]];
//    self.modelP.user.student.names = nil;
//    self.modelP.user.student.names = arr;
//
//    [People bg_deleteAsync:BGTablename where:nil complete:^(BOOL isSuccess) {
//        NSLog(@"删除成功");
//    }];
//
//    self.modelP.bg_tableName = BGTablename;//自定义数据库表名称(库自带的字段).
//    [self.modelP bg_coverAsync:^(BOOL isSuccess) {//覆盖存储，即清除之前的数据，只存储当前的数据
//        if (isSuccess) {
//            NSLog(@"存储成功");
//        }else{
//            NSLog(@"存储失败");
//        }
//
//        People *model = [[People bg_findAll:BGTablename] firstObject];
//        NSArray * arr = model.user.student.names;
//
//        NSLog(@" 查看数据0    %@",arr.firstObject);
//    }];
    
    
    
    //修改图片
    self.modelP.bg_tableName = BGTablename;//自定义的数据库表名称(库自带的字段).  bg_equal
    self.modelP.arrM = [self imagesArr];
    [People bg_deleteAsync:BGTablename where:nil complete:^(BOOL isSuccess) {
        NSLog(@"删除成功");
    }];
    
    
    [self.modelP bg_coverAsync:^(BOOL isSuccess) {//覆盖存储，即清除之前的数据，只存储当前的数据
        if (isSuccess) {
            NSLog(@"存储成功");
        }else{
            NSLog(@"存储失败");
        }

        People *model = [[People bg_findAll:BGTablename] firstObject];
        NSLog(@" 查看数据0    %@",model.arrM);
    }];
}

-(void)query{
    //一级目录
//    People *model = [[People bg_findAll:BGTablename] firstObject];
//    NSString * name = model.name;
//    self.tipLabel.text = name;
    
//    //二级目录
    People *model = [[People bg_findAll:BGTablename] firstObject];
    NSString * name = model.user.name;
    self.tipLabel.text = name;
    
//    //三级目录
//    People *model = [[People bg_findAll:BGTablename] firstObject];
//    NSString * name = model.user.student.num;
//    self.tipLabel.text = name;
    
    
    //四级目录
//    NSArray * nameArr = model.user.student.names;
//    self.tipLabel.text = nameArr.firstObject;
    
    
    //对图片的数据存储
    if (self.imageArr.count > 0) {
        for (UIImageView * image in self.imageArr) {
            [image removeFromSuperview];
        }
    }
    
    if (model.arrM.count > 0) {
        for (int i = 0; i < model.arrM.count; i++) {
            UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(40*i, 500, 40, 40)];
            [self.view addSubview:image];
            image.image = [UIImage imageWithData:model.arrM[i]];
            [self.imageArr addObject:image];
        }
    }
    
}

-(NSString *)name{
    NSString * str = @"";
    str = [NSString stringWithFormat:@"数据存储 - %d",arc4random() % 64];
    return str;
}

-(NSMutableArray *)nameArr{
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0 ; i < 5; i++) {
        NSString * str = [NSString stringWithFormat:@"数据存储 - %d",arc4random() % 64];
        [arr addObject:str];
    }
    return arr;
}


-(NSMutableArray *)imagesArr{
    NSMutableArray * arr = [NSMutableArray array];
    NSInteger count = arc4random() % 4 + 1;
    [arr addObject:UIImageJPEGRepresentation([UIImage imageNamed:[NSString stringWithFormat:@"ima%ld",(long)count]], 1)];
    return arr;
}



-(People*)people{
    
    //存储对象使用示例
    People* p = [People new];
    p.name = @"斯巴达7";
    p.num = @(220.88);
    p.age = 99;
    p.sex = @"男";
    p.eye = @"末世眼皮111";
    p.Url = [NSURL URLWithString:@"http://www.baidu.com"];
    p.addBool = YES;
    p.range = NSMakeRange(0,10);
    p.rect = CGRectMake(0,0,10,20);
    p.size = CGSizeMake(50,50);
    p.point = CGPointMake(2.55,3.14);
    p.color = [UIColor colorWithRed:245 green:245 blue:245 alpha:1.0];
    NSMutableAttributedString* attStrM = [[NSMutableAttributedString alloc] initWithString:@"BGFMDB"];
    [attStrM addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    p.attriStr = attStrM;
    p.image = [UIImage imageNamed:@"MarkMan"];
    NSData* data = UIImageJPEGRepresentation(p.image, 1);
    p.data2 = data;
    p.arrM = [NSMutableArray array];
    for(int i=1;i<=5;i++){
        [p.arrM addObject:UIImageJPEGRepresentation([UIImage imageNamed:[NSString stringWithFormat:@"ima%d",i]], 1)];
    }
    [p setValue:@(110) forKey:@"testAge"];
    p->testName = @"测试名字";
    p.sex_old = @"新名";
    
    
    
    User* user = [[User alloc] init];
    user.name = @"陈浩南";
    user.attri = @{@"用户名":@"黄芝标",@"密码":@(123456),@"数组":@[@"数组1",@"数组2"],@"集合":@{@"集合1":@"集合2"}};
    
    Student* student = [[Student alloc] init];
    student.num = @"标哥";
    student.names = @[@"小哥哥",@"小红",@(110),@[@"数组元素1",@"数组元素2"],@{@"集合key":@"集合value"}];
    student.count = 199;
    
    Human* human = [[Human alloc] init];
    human.sex = @"女";
    human.body = @"小芳";
    human.humanAge = 98;
    human.age = 18;
    
    student.human = human;
    user.student = student;
    
    p.students = @[@(1),@"呵呵",@[@"数组元素1",@"数组元素2"],@{@"集合key":@"集合value"},student,data,student];
    p.infoDic = @{@"name":@"标哥",@"年龄":@(1),@"数组":@[@"数组1",@"数组2"],@"集合":@{@"集合1":@"集合2"},@"user":user,@"data":data};

    
    NSHashTable* hashTable = [NSHashTable new];
    [hashTable addObject:@"h1"];
    [hashTable addObject:@"h2"];
    [hashTable addObject:student];
    NSMapTable* mapTable = [NSMapTable  new];
    [mapTable setObject:@"m_value1" forKey:@"m_key1"];
    [mapTable setObject:@"m_value2" forKey:@"m_key2"];
    [mapTable setObject:user forKey:@"m_key3"];
    NSSet* set1 = [NSSet setWithObjects:@"1",@"2",student, nil];
    NSMutableSet* set2 = [NSMutableSet set];
    [set2 addObject:@{@"key1":@"value"}];
    [set2 addObject:@{@"key2":user}];

    
    People* userP = [People new];
    userP.name = @"互为属性测试";
    user.userP = userP;

    p.user = user;
    p.user1 = [User new];
    p.user1.name = @"小明_fuck2222";
    p.bfloat = 8.88;
    p.bdouble = 100.567;
    p.user.userAge = 13;
    p.user.userNumer = @(3.14);
    p.user.student.human.humanAge = 9999;

    p.hashTable = hashTable;
    p.mapTable = mapTable;
    p.nsset = set1;
    p.setM = set2;
    p.date = [NSDate date];
    return p;
}

- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
@end
