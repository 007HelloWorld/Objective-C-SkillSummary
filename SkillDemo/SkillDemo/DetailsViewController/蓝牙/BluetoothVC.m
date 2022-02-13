//
//  BluetoothVC.m
//  SkillDemo
//
//  Created by pjw on 2021/4/11.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "BluetoothVC.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BluetoothVC ()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager * mgr;//中心设备管理器
@property (nonatomic, strong) NSMutableArray * peripheralArray;//扫描到的外围设备的数据数组



@end

@implementation BluetoothVC

- (NSMutableArray *)peripheralArray{
    if (!_peripheralArray) {
        _peripheralArray = [NSMutableArray array];
    }
    return _peripheralArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     Core Bluetooth测试比较麻烦，正常情况下，得至少有2台真实的蓝牙4.0设备
        
     如何让iOS模拟器也能测试蓝牙4.0程序？
     买一个CSR蓝牙4.0USB适配器，插在Mac上
     在终端输入sudo nvram bluetoothHostControllerSwitchBehavior="never"
     重启Mac
     用Xcode4.6调试代码，将程序跑在iOS6.1的模拟器上(苹果把iOS7.0模拟器对BLE的支持移除掉了)
     
     Core Bluetooth的使用场景
     运动手环，智能家居，嵌入式设备等等(金融刷卡器、心电测量器)
     
     Core Bluetooth的基本常识
     每个蓝牙4.0设备都是通过服务(Service)和特征(Characteristic)来展示自己的
     一个设备必然包含一个多多个服务，每个服务下面又包含若干个特征
     
     特征是与外界交互的最小单位
     比如说，一台蓝牙4.0设备，用特征A来描述自己的出厂信息，用特征B来收发数据
     
     服务和特征都是用UUID来唯一标识的，通过UUID就能区别不同的服务和特征
     
     设备里面各个服务(Service)和特征(Characteristic)的功能，均有蓝牙设备硬件厂家提供，比如哪些是用来交互(读写)，哪些可获得模块信息(只读)等
     
     Core Bluetooth的开发步骤
     1、建立中心设备
     2、扫描外设(Discover Peripheral)
     3、连接外设(Connect Peripheral)
     4、扫描外设中的服务和特征(Discover Services And Characteristic)
     5、利用特征与外设做数据交互(Explore And Interact)
     6、断开连接(Disconnect)
     
    */

    
    /*
        具体实现步骤
        1、建立中央管理者
        2、扫描周边设备
        3、当发现外围设备时，会调用的方法，在此方法中记录扫描到的设备
        4、(用户点击后的方法)连接扫描到的设备-->此方法是咱们自己写的，连接外围设备
        5、设置外围设备的代理--->一旦连接外设，那么将有外设来管理服务和特征的处理
        6、连接到外设时会调用的代理方法中扫描服务
        7、当发现到服务的时候会调用的代理方法，获取指定的服务，然后根据此服务来查找特征
        8、获取指定的特征，然后根据此特征，才能根据自己的需求进行数据交互处理
        9、断开连接
    */
    //1、建立中央管理者             queue如果传空，就代表在主队列
    self.mgr = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    //2、扫描周边设备
    //Services:是服务的UUID，而且是个数据，如果不穿，默认扫描全部服务
    [self.mgr scanForPeripheralsWithServices:nil options:nil];
    
}

#pragma mark -------------------CBCentralManagerDelegate代理方法
#pragma mark 必须调用的代理方法
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"服务已开启");
            //扫描外界设备
//            [_centralManager scanForPeripheralsWithServices:nil  options:nil];
            break;
            
        case CBCentralManagerStatePoweredOff:
            NSLog(@"服务已关闭");
            break;
            
        case CBCentralManagerStateResetting:
            NSLog(@"正在重置");
            break;
            
        case CBCentralManagerStateUnsupported:
            NSLog(@"未支持");
            break;
            
        case CBCentralManagerStateUnauthorized:
            NSLog(@"未授权");
            break;
            
        default:
            break;
    }
}


#pragma mark 当发现外围设备时，会调用的方法
/*
 peripheral:            外围设备
 advertisementData:     相关的数据
 RSSI:                  信号强度
*/
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    //3、连接扫描到的设备
    if (![self.peripheralArray containsObject:peripheral]) {
        [self.peripheralArray addObject:peripheral];
    }
    //隐藏的步骤，你应该搞一个列表给用户选择，让用户自己选择要连接到哪一个设备
}

#pragma mark -------------------连接扫描到的设备，此方法是我们自己IE的，用户选中了设备时，应该调用此方法
-(void)connectPeripheral:(CBPeripheral *)peripheral{
    //4、连接到外围设备
    [self.mgr connectPeripheral:peripheral options:nil];
    
    //5、设置外围设备的代理------> 一旦连接到外设，那么将有外设来管理服务和特征的处理
    peripheral.delegate = self;
}

#pragma mark -------------------此方法是连接到外设时会调用的代理方法
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    //6、扫描服务 ---->  可以传入UUID
    //传空，代表扫描所有服务
    [peripheral discoverServices:nil];
}

#pragma mark -------------------外设的代理方法，当发现到服务的时候会调用
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    //7、获取制定的服务，然后根据此服务来查找特征
    //假如我们的服务的UUID是123
    for (CBService * service in peripheral.services) {
        if ([service.UUID.UUIDString isEqualToString:@"123"]) {
            //如果UUID一致，则开始扫描特征
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

#pragma mark -------------------外设的代理方法，当发现到特征的时候会调用
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    //8、获取指定的特征，然后根据此特征，才能根据自己的需求进行数据交互处理
    //characteristics:服务的数组中，会包含在一个characteristics的数组中
    for (CBCharacteristic * characteristic in service.characteristics) {
        //假如我们的特征的UUID是"456"
        if ([characteristic.UUID.UUIDString isEqualToString:@"456"]) {
            //如果获取到了指定的特征，则可以进行数据交互处理
//            [peripheral readValueForCharacteristic:characteristic];
//            [peripheral writeValue:<#(nonnull NSData *)#> forCharacteristic:<#(nonnull CBCharacteristic *)#> type:<#(CBCharacteristicWriteType)#>];
        }
    }
}

#pragma mark -------------------断开链接
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.mgr stopScan];
}

@end










































