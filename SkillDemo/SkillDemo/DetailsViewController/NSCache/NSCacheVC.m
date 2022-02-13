//
//  NSCacheVC.m
//  SkillDemo
//
//  Created by pjw on 2021/3/13.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "NSCacheVC.h"

@interface NSCacheVC ()<NSCacheDelegate>
@property(nonatomic,strong)NSCache * cache;
@end

@implementation NSCacheVC

-(NSCache *)cache{
    if (!_cache) {
        _cache = [NSCache new];
        //缓存中总共可以存储多少条
        _cache.countLimit = 5;
    }
    return _cache;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
        NSCache是苹果提供的一套缓存机制
        1.和NSMutableDictionary使用起来相似
        2.线程安全，Mutable开发的类一般都是线程不安全的
        3.当内存不足时会自动释放内存(所以缓存中取数据的时候总要判断是否为空)
        4.指定缓存的限额，当缓存超出限额自动释放内存
            i:缓存限额
                1、缓存数量
                    countLimit
                2、缓存成本
                    totalCostLimit
        
        
        SDWebImage的常见面试题
        1、默认缓存的时间为1周
        maxCacheAge
        2、使用的缓存对象是_memCache = [[NSCache alloc]init];
        3、SDImageCache内处理内存警告，以通知的方式，clearMemory
        4、cleanDisk的执行过程
            4.1先遍历所有的缓存文件，记录过期的文件，计算缓存文件的总大小
            4.2删除所有过期的文件
            4.3判断maxCacheSize的值是否大于0.如果大于0再判断缓存的文件总大小是否大于maxCacheSize
            4.4如果缓存文件的总大小超过maxCacheSize，删除最早的文件
        5、SDWebImage的最大并发数是多少？
            _downloadQueue.maxConcurrentOperation = 6;
        6、SDWebImage支持gif么
            支持UIImage+GIF
        7、SDWebImage中怎么判断文件的类型的
            NSData+ImageContentType.m中
            根据文件头的第一个字节判断的
        8、SDWebImage缓存文件名称
            为了防止缓存的图片名称冲突，根据md5计算的
            md5重复的几率很小很小很小
            终端中测试：  echo -n "pjw" | md5
     
     
    */
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //设置NSCache的代理
    self.cache.delegate = self;
    
    //添加缓存数据
    for (int i = 0; i < 10; i++) {
        [self.cache setObject:[NSString stringWithFormat:@"hello %d",i] forKey:[NSString stringWithFormat:@"h%d",i]];
    }
    
    //从缓存中读取数据
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@",[self.cache objectForKey:[NSString stringWithFormat:@"h%d",i]]);
    }
}

//将要从NSCache中移除一项的时候执行
- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
    NSLog(@"从缓存中移除   %@",obj);
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
    //当收到内存警告时，调用removeAllObjeces之后，无法再次往缓存中添加数据
    [self.cache removeAllObjects];
    //输出从缓存中的数据
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@",[self.cache objectForKey:[NSString stringWithFormat:@"h%d",i]]);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //添加缓存数据
    for (int i = 0; i < 10; i++) {
        [self.cache setObject:[NSString stringWithFormat:@"hello %d",i] forKey:[NSString stringWithFormat:@"h%d",i]];
        NSLog(@"添加    %@",[NSString stringWithFormat:@"hello %d",i]);
    }
    
    //从缓存中读取数据
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@",[self.cache objectForKey:[NSString stringWithFormat:@"h%d",i]]);
    }
}



@end
