//
//  FMDBViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/11/12.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "FMDBViewController.h"
#import "CZFFMDBExecute.h"
#import "OldUser.h"


#import <CommonCrypto/CommonDigest.h>
#import "JQFMDB.h"
#import "PersonModel.h"


@interface FMDBViewController ()

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //这种存储，需要改动代码，兼容性低
    [self basicsFMDB];
    
    //拓展性强的FMDB
    [self pjwFMDB];
    
}

-(void)basicsFMDB{
    
    //增加
    [self addBasicsFMDB];
    //修改
    [self uploadBasicsFMDB];
    //删除
    [self deleteBasicsFMDB];
    //查
    [self queryBasicsFMDB];
}

-(void)addBasicsFMDB{
    
    for (int i = 0; i < 3; i ++) {
        OldUser *user = [OldUser new];
        user.userId = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
        user.username = [NSString stringWithFormat:@"张三%ld", random()];
        user.age = 18;
        user.createTime = [NSDate date];
        user.income = [[NSDecimalNumber alloc] initWithFloat:1233.04338];
        user.isMan = YES;
        user.userIcon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573042496310&di=d6b4363fe0bb7455d97672b4d5d0e316&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D4232323981%2C903032036%26fm%3D214%26gp%3D0.jpg";

        [[CZFFMDBExecute shareInstance] addUser:user];
    }
}

-(void)uploadBasicsFMDB{
    NSArray *userList = [[CZFFMDBExecute shareInstance] getUserList];
    OldUser *user = userList[0];
    user.username = @"sadasdaad";
    [[CZFFMDBExecute shareInstance] updateUser:user];
}

-(void)deleteBasicsFMDB{
    
    //指定哪个userId进行删除
    NSArray *userList = [[CZFFMDBExecute shareInstance] getUserList];
    OldUser *user = userList[0];
    [[CZFFMDBExecute shareInstance] deleteUser:user.userId];
}

-(void)queryBasicsFMDB{
    NSArray *userList = [[CZFFMDBExecute shareInstance] getUserList];
    NSLog(@"%@",userList);
}


-(void)pjwFMDB{
    
    //增
    [self addPjwFMDB];
    
    //删
    [self uploadPjwFMDB];
    
    //改
    [self deleteBPjwFMDB];
    
    //查
    [self queryPjwFMDB];
}

-(void)addPjwFMDB{
    
    PersonModel *person = [[PersonModel alloc] init];
    person.name = @"cleanmonkey";
    person.phoneNum = @(18866668888);
    person.photoData = UIImagePNGRepresentation([UIImage imageNamed:@"bg.jpg"]);
    person.luckyNum = 7;
    person.sex = 0;
    person.age = 26;
    person.height = 172.12;
    person.weight = 120.4555;
    
    
    // 用来测试操作一组数据
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 3; i++) {
        PersonModel *person = [[PersonModel alloc] init];
        person.name = [self randomName];
        person.phoneNum = @(18866668888);
        person.photoData = UIImagePNGRepresentation([UIImage imageNamed:@"bg.jpg"]);
        person.luckyNum = 7;
        person.sex = arc4random()%2;
        person.age = 26;
        person.height = 172.12;
        person.weight = 120.4555;
        
        [mArr addObject:person];
    }
    
    JQFMDB *db = [JQFMDB shareDatabase];
    NSLog(@"last:%ld", (long)[db lastInsertPrimaryKeyId:@"user"]);
    
    //插入一条数据
    [db jq_insertTable:@"user" dicOrModel:person];
    
    //插入一组数据, 数据多建议使用事务插入, 效率很高
    [db jq_insertTable:@"user" dicOrModelArray:mArr];
    
    //保证线程安全插入一条数据, jq_inDatabase的block中即可保证线程安全
    [db jq_inDatabase:^{
        [db jq_insertTable:@"user" dicOrModel:person];
    }];
    
    //异步(防止UI卡死)插入一条数据, 也同样可以使用线程安全的方法(在jq_inDatabase的block中插入)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [db jq_insertTable:@"user" dicOrModel:person];
        dispatch_sync(dispatch_get_main_queue(), ^{
            //刷新tableview
        });
    });
    
    //用事务插入1000条数据, 数据量多的话用事务插入会很快, 就像生产一件零件就送走和生产一堆零件再送走的效率问题
    [db jq_inTransaction:^(BOOL *rollback) {
        for (int i = 0; i < 1000; i++) {
            BOOL flag = [db jq_insertTable:@"user" dicOrModel:person];
            if (flag == NO) {
                *rollback = YES; //回滚操作
                return; //不加return会一直循环完1000
            }
        }
    }];
}

-(void)uploadPjwFMDB{
    JQFMDB *db = [JQFMDB shareDatabase];

    NSArray *allArr = [db jq_lookupTable:@"user" dicOrModel:[PersonModel class] whereFormat:nil];
    //更新最后一条数据 name=testName , dicOrModel的参数也可以是name为testName的person
    [db jq_updateTable:@"user" dicOrModel:@{@"name":@"testName"} whereFormat:@"WHERE rowid = '%@'",@"2"];
    
    //把表中所有的name改成godlike
    [db jq_updateTable:@"user" dicOrModel:@{@"name":@"godlike"} whereFormat:nil];
    
    //保证线程安全更新最后一条数据 name = safeName
    [db jq_inDatabase:^{
        [db jq_updateTable:@"user" dicOrModel:@{@"name":@"safeName"} whereFormat:@"WHERE rowid = (SELECT max(rowid) FROM user)"];
    }];
    
    //异步(防止UI卡死)更新最后一条数据 name = asyncName
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [db jq_inDatabase:^{
            [db jq_updateTable:@"user" dicOrModel:@{@"name":@"asyncName"} whereFormat:@"WHERE rowid = (SELECT max(rowid) FROM user)"];
        }];
        dispatch_sync(dispatch_get_main_queue(), ^{
            //刷新tableview
        });
    });
    
}

-(void)deleteBPjwFMDB{
    
    JQFMDB *db = [JQFMDB shareDatabase];
    //删除最后一条数据
    [db jq_deleteTable:@"user" whereFormat:@"WHERE rowid = '%@'",@"2"];
    
    //保证线程安全删除最后一条数据
    [db jq_inDatabase:^{
        [db jq_deleteTable:@"user" whereFormat:@"WHERE rowid = (SELECT max(rowid) FROM user)"];
    }];
    
    //异步(防止UI卡死)删除最后一条数据
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [db jq_inDatabase:^{
            [db jq_deleteTable:@"user" whereFormat:@"WHERE rowid = (SELECT max(rowid) FROM user)"];
        }];
        dispatch_sync(dispatch_get_main_queue(), ^{
            //刷新tableview
        });
    });
    
    //删除全部数据
    [db jq_deleteAllDataFromTable:@"user"];
    
    
}

-(void)queryPjwFMDB{
    
    JQFMDB *db = [JQFMDB shareDatabase];

    //查找表中所有数据
    NSArray *allArr = [db jq_lookupTable:@"user" dicOrModel:[PersonModel class] whereFormat:nil];
    NSLog(@"查找表中所有数据  :%@", allArr);

    //查找name=cleanmonkey的数据
    NSArray *cleanmonkeyArr = [db jq_lookupTable:@"user" dicOrModel:[PersonModel class] whereFormat:@"where name = 'cleanmonkey'"];
    NSLog(@"查找name=cleanmonkey的数据  :%@", allArr);
    
    //保证线程安全查找name=cleanmonkey
    [db jq_inDatabase:^{
       NSArray *personArr = [db jq_lookupTable:@"user" dicOrModel:[PersonModel class] whereFormat:@"where name = 'cleanmonkey'"];
       NSLog(@"(safe)name=cleanmonkey   :%@", personArr);
    }];
    
    //异步(防止UI卡死)查找name=cleanmonkey
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *personArr = [db jq_lookupTable:@"user" dicOrModel:[PersonModel class] whereFormat:@"where name = 'cleanmonkey'"];
        NSLog(@"异步(防止UI卡死)查找name=cleanmonkey    :%@", personArr);
    });
}


// 获得随机字符名称
- (NSString *)randomName{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 7; i++) {
        int figure = (arc4random() % 26) + 97;
        char character = figure;
        NSString *tempString = [NSString stringWithFormat:@"%c", character];
        string = [string stringByAppendingString:tempString];
    }
    return string;
}




@end
