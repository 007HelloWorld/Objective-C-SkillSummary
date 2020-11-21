//
//  ScreenViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/11/19.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "ScreenViewController.h"
#import "Man.h"

@interface ScreenViewController ()
@property(nonatomic,strong) NSMutableArray * dataArr;
@property(nonatomic,strong) NSMutableArray * localDataArr;

@property(nonatomic,assign) NSInteger time;

@end

@implementation ScreenViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)localDataArr{
    if (!_localDataArr) {
        _localDataArr = [NSMutableArray array];
    }
    return _localDataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

//    self.time = 0;
    
    [self sorting];
    
//    [self filter];
    
    
    
    //此方法可作为本地筛选逻辑
    self.localDataArr = [self loadData];
    
    //下面这个是筛选项，里面的值要么为空值，要么有值，由用户筛选点击确定后拿到数据，随机的
    NSString * name = @"1";
    NSString * age = @"";
    NSString * weight = @"111";
    NSString * height = @"";
    
    //数据源中一共有5条数据，满足name为1，并且weight为111的只有p0跟p4这个两条数据，及筛选完后，只是这两条数据
    //怎么处理这块逻辑
    NSArray * array = @[name,age,weight,height];
    [self filterBy:array];
}

-(NSMutableArray *)filterBy:(NSArray *)array {
    NSMutableArray * tempArray = [NSMutableArray new];
    //遍历所有数据源
    for (int i = 0; i < self.localDataArr.count; i++) {
        //将数据源里面的数据存入personArray中
        Man * item = self.localDataArr[i];
        NSMutableArray * personArray = [NSMutableArray new];
        [personArray addObject:item.name];
        [personArray addObject:item.age];
        [personArray addObject:item.weight];
        [personArray addObject:item.height];
        
        NSMutableArray * tem = [NSMutableArray arrayWithArray:array];
        //遍历筛选项
        for (int k = 0; k < tem.count; k++) {
            NSString * value = tem[k];
            //当筛选项里面没有值时，传入对应的value值
            if (value.length == 0) {
                tem[k] = personArray[k];
            }
            NSLog(@"1   %@",tem);
            NSLog(@"2   %@",personArray);
        }
        
        NSLog(@"    pjw      %ld",tem.count);
        NSLog(@"    pjw      %ld",personArray.count);

        //判断personArray  跟tem是否相同，如果相同，那么加入到数组中
        if ([self jugeSameArray:personArray andArray:tem]) {
            [tempArray addObject:item];
        }
    }
    
    NSLog(@"%@",tempArray);
    return tempArray;
    
}

// 判断两个数组中的元素是否相同
-(BOOL)jugeSameArray:(NSArray *)arr1 andArray:(NSArray *)arr2 {
     if (arr1.count != arr2.count) {
         return NO;
     }
     for (NSString *str in arr1) {
         if (![arr2 containsObject:str]) {
             return NO;
         }
     }
     for (NSString *str in arr2) {
         if (![arr1 containsObject:str]) {
             return NO;
         }
     }
    
    return YES;
}



//起定时器，根据价格高低，进行数据排序
-(void)sorting{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"name"] = @"西瓜";
    dict[@"price"] = @"2";
    
    NSMutableDictionary * dict1 = [NSMutableDictionary dictionary];
    dict1[@"name"] = @"黄瓜";
    dict1[@"price"] = @"3";
    
    NSMutableDictionary * dict2 = [NSMutableDictionary dictionary];
    dict2[@"name"] = @"南瓜";
    dict2[@"price"] = @"4";
    [self.dataArr addObject:dict];
    [self.dataArr addObject:dict1];
    [self.dataArr addObject:dict2];

    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.time ++;
        
        for (NSMutableDictionary * dict in self.dataArr) {
            if ([dict[@"name"] isEqualToString:@"西瓜"]) {
                [dict setValue:[NSString stringWithFormat:@"%u",arc4random() % 100] forKey:@"price"];
            }else if ([dict[@"name"] isEqualToString:@"黄瓜"]) {
                [dict setValue:[NSString stringWithFormat:@"%u",arc4random() % 100] forKey:@"price"];
            }else if ([dict[@"name"] isEqualToString:@"南瓜"]) {
                [dict setValue:[NSString stringWithFormat:@"%u",arc4random() % 100] forKey:@"price"];
            }
        }
        [self uploadData];
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    for (int i = 0; i < 3; i ++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(50, 200+50*i, 200, 40)];
        label.tag = 100 + i;
        label.text = @"1";
        label.textColor = [UIColor orangeColor];
        [self.view addSubview:label];
    }
}


//一些筛选方法
-(void)filter{
    
    //判断里面是否包含指定的数据
    NSNumber * testNum = @123;
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"SELF = 123"];
    if ([pre evaluateWithObject:testNum]) {
        NSLog(@" 有数据  %@",pre);
    }
    
    //判断里面是否包含数据
    NSPredicate * pre1 = [NSPredicate predicateWithFormat:@"SELF BETWEEN {100,200}"];
    if ([pre1 evaluateWithObject:testNum]) {
        NSLog(@"满足条件");
    }else{
        NSLog(@"不满足条件");
    }
    
    NSArray * testArr = @[@1,@2,@3,@4,@5,@6];
    NSPredicate * pre2 = [NSPredicate predicateWithFormat:@"SELF > 2 && SELF < 5"];
    NSArray * filterArr = [testArr filteredArrayUsingPredicate:pre2];
    NSLog(@"filterArr :%@",filterArr);
    
    //检查某个字符串是否以指定的字符串开头(如判断字符串是否以a开头)
    NSString * string = @"adsfsdfgkklj";
    NSPredicate * pre3 = [NSPredicate predicateWithFormat:@" %@ BEGINSWITH 'a'",string];
    if ([pre3 evaluateWithObject:string]) {
        NSLog(@"string3:  %@ ",string);
    }
    
    NSPredicate * pre4 = [NSPredicate predicateWithFormat:@" %@ ENDSWITH 'j'",string];
    if ([pre4 evaluateWithObject:string]) {
        NSLog(@"string4:  %@ ",string);
    }
    
    NSPredicate * pre5 = [NSPredicate predicateWithFormat:@" %@ CONTAINS 'fsdf'",string];
    if ([pre5 evaluateWithObject:string]) {
        NSLog(@"string5:  %@ ",string);
    }
    
    NSPredicate * pre6 = [NSPredicate predicateWithFormat:@" %@ LIKE '*fsdf*'",string];
    if ([pre6 evaluateWithObject:string]) {
        NSLog(@"string6:  %@ ",string);
    }
    
    NSPredicate * pre7 = [NSPredicate predicateWithFormat:@" %@ LIKE '?adsf*'",string];
    if ([pre7 evaluateWithObject:string]) {
        NSLog(@"string7:  %@ ",string);
    }
}

-(void)uploadData{
    
//    for (int i = 0; i < self.dataArr.count; i ++) {
//        for (int j = i + 1 ; j < self.dataArr.count; j ++) {
//            if ([self.dataArr[i][@"price"] intValue] < [self.dataArr[j][@"price"] intValue]) {
//                [self.dataArr exchangeObjectAtIndex:i withObjectAtIndex:j];
//            }
//        }
//    }
//    NSLog(@"%@",self.dataArr);
    
    
    [self.dataArr sortUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2)
    {
        //此处的规则含义为：若前一元素比后一元素小，则返回降序（即后一元素在前，为从大到小排列）
        if ([obj1[@"price"] integerValue] < [obj2[@"price"] integerValue])
        {
            return NSOrderedDescending;
        }
        else
        {
            return NSOrderedAscending;
        }
    }];
    
    UILabel * label = [self.view viewWithTag:100];
    UILabel * label1 = [self.view viewWithTag:101];
    UILabel * label2 = [self.view viewWithTag:102];
    label.text = [NSString stringWithFormat:@"%@    %@",self.dataArr[0][@"name"],self.dataArr[0][@"price"]];
    label1.text = [NSString stringWithFormat:@"%@    %@",self.dataArr[1][@"name"],self.dataArr[1][@"price"]];
    label2.text = [NSString stringWithFormat:@"%@    %@",self.dataArr[2][@"name"],self.dataArr[2][@"price"]];
}



-(NSMutableArray *)loadData{
    
    NSMutableArray * tempArr = [NSMutableArray array];
    
    Man * p0 = [Man new];
    p0.name = @"1";
    p0.age = @"11";
    p0.weight = @"111";
    p0.height = @"1111";
    
    Man * p1 = [Man new];
    p1.name = @"1";
    p1.age = @"18";
    p1.weight = @"100";
    p1.height = @"180";
    
    Man * p2 = [Man new];
    p2.name = @"1";
    p2.age = @"18";
    p2.weight = @"100";
    p2.height = @"180";
    
    Man * p3 = [Man new];
    p3.name = @"1";
    p3.age = @"18";
    p3.weight = @"100";
    p3.height = @"180";
    
    Man * p4 = [Man new];
    p4.name = @"1";
    p4.age = @"18";
    p4.weight = @"111";
    p4.height = @"180";

    [tempArr addObject:p0];
    [tempArr addObject:p1];
    [tempArr addObject:p2];
    [tempArr addObject:p3];
    [tempArr addObject:p4];
    return tempArr;
}

@end
