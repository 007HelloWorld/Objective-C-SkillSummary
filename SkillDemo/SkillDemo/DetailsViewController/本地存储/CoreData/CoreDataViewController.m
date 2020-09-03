//
//  CoreDataViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/8/31.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "CoreDataViewController.h"
#import <CoreData/CoreData.h>
#import "Students+CoreDataClass.h"


@interface CoreDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSManagedObjectContext * context;
@property(nonatomic,strong)NSMutableArray * dataSource;
@property(nonatomic,strong)UITableView * tableV;

@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
        1.新建一个Data Model文件
        2.在这个Data Model里面，点击Add Entity按钮，新建一个实体，首字母必须大写
        3.在Attributes里面，新建实体属性，数据类型
        4.在右侧的第三个中，点击Module，选择Manua/None
        5.在右侧的第一个中，在Code Generation中的语言，选择OC
    
    */
    
    
    //创建数据库
    [self createSqlite];
    
    [self setUI];
}

-(void)createSqlite{
    //1、创建模型对象
    //获取模型路径
    NSURL * modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    //根据模型文件创建模型对象
    NSManagedObjectModel * model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    //2、创建持久化存储助理：数据库
    //利用模型对象创建助理对象
    NSPersistentStoreCoordinator * store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    //数据库的名称和路径
    NSString * docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
    NSLog(@"数据库 path = %@",sqlPath);
    NSURL * sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
    NSError * error = nil;
    //设置数据库相关信息，添加一个持久化存储库并设置存储类型和路径，NSSQLiteStoreType：SQLite作为存储库
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
    if (error) {
        NSLog(@"添加数据库失败：%@",error);
    }else{
        NSLog(@"添加数据库成功");
    }
    
    //创建上下文，保存信息，操作数据库
    NSManagedObjectContext * context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //关联持久化助理
    context.persistentStoreCoordinator = store;
    
    self.context = context;
}

-(void)setUI{
    CGFloat itemW = [UIScreen mainScreen].bounds.size.width/5;
    for (int i = 0; i < 5; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(itemW * i, 64, itemW, 60)];
        if (i == 0) {
            [btn setTitle:@"新增" forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setTitle:@"删除" forState:UIControlStateNormal];
        }else if (i == 2){
            [btn setTitle:@"更新" forState:UIControlStateNormal];
        }else if (i == 3){
            [btn setTitle:@"查询" forState:UIControlStateNormal];
        }else if (i == 4){
            [btn setTitle:@"排序" forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
}

-(void)btnClick:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    if (index == 0) {
        [self insertData];
    }else if (index == 1){
        [self deleteData];
    }else if (index == 2){
        [self updateData];
    }else if (index == 3){
        [self readData];
    }else if (index == 4){
        [self sort];
    }
}

-(void)insertData{
    Students * person = [NSEntityDescription insertNewObjectForEntityForName:@"Students" inManagedObjectContext:self.context];
    person.name = [NSString stringWithFormat:@"pjw---%d",arc4random()%100];
    person.age = arc4random()%20;
    person.sex = arc4random()%2 == 0 ? @"美女" : @"帅哥";
    
    //查询所有数据的请求
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Students"];
    NSArray * resArray = [self.context executeFetchRequest:request error:nil];
    self.dataSource = [NSMutableArray arrayWithArray:resArray];
    [self.tableV reloadData];
    
    //保存插入的数据
    NSError * error = nil;
    if ([self.context save:&error]) {
        NSLog(@"插入数据库成功");
    }else{
        NSLog(@"插入数据库失败");
    }
    
    NSLog(@"%lu",(unsigned long)self.dataSource.count);
}

-(void)deleteData{
    //创建删除请求
    NSFetchRequest * deleRequest = [NSFetchRequest fetchRequestWithEntityName:@"Students"];
    //删除条件
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"age < %d",30];
    deleRequest.predicate = pre;
    //返回需要删除的对象数组
    NSArray * deleArray = [self.context executeFetchRequest:deleRequest error:nil];
    //从数据库中删除
    for (Students * stu in deleArray) {
        [self.context deleteObject:stu];
    }
    //没有任何条件就是读取所有数据
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Students"];
    NSArray * resArray = [self.context executeFetchRequest:request error:nil];
    self.dataSource = [NSMutableArray arrayWithArray:resArray];
    [self.tableV reloadData];
    
    NSError * error = nil;
    if ([self.context save:&error]) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除数据失败，%@",error);
    }
    
    NSLog(@"%lu",(unsigned long)self.dataSource.count);
}

//更新的意思是，根据指定的条件，将数据更新
-(void)updateData{
    //创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Students"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"age = %d", 13];
    request.predicate = pre;
    
    //发送请求
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    
    //修改
    for (Students *stu in resArray) {
        stu.name = @"且行且珍惜_iOS";
    }
    
    _dataSource = [NSMutableArray arrayWithArray:resArray];
    [self.tableV reloadData];
    
    //保存
    NSError *error = nil;
    if ([_context save:&error]) {
        NSLog(@"更新所有帅哥的的名字为“且行且珍惜_iOS");
    }else{
        NSLog(@"更新数据失败, %@", error);
    }
}

    
//根据指定的条件，进行数据获取
-(void)readData{
    //创建查询请求
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Students"];
    //查询条件
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"age = %d", 15];
    request.predicate = pre;
    //发送查询请求，并返回结果
    NSArray * resArray = [self.context executeFetchRequest:request error:nil];
    self.dataSource = [NSMutableArray arrayWithArray:resArray];
    [self.tableV reloadData];
    NSLog(@"读取");
}

-(void)sort{
    //创建排序请求
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Students"];
    //实例化排序对象
    NSSortDescriptor * ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    request.sortDescriptors = @[ageSort];
    //发送请求
    NSError * error = nil;
    NSArray * resArray = [self.context executeFetchRequest:request error:nil];
    self.dataSource = [NSMutableArray arrayWithArray:resArray];
    [self.tableV reloadData];
    if (error == nil) {
        NSLog(@"");
    }
}
 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"indexPath";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    Students * student = self.dataSource[indexPath.row];
    cell.textLabel.text = student.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",student.age];
    return cell;
}
    
    
    
    
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 124) style:UITableViewStylePlain];
        _tableV.dataSource = self;
        _tableV.delegate = self;
        [self.view addSubview:_tableV];
    }
    return _tableV;
}
    
@end
