//
//  NetWorkVC.m
//  SkillDemo
//
//  Created by pjw on 2021/4/11.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "NetWorkVC.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface NetWorkVC ()
@property (weak, nonatomic) IBOutlet UITextField *ipView;
@property (weak, nonatomic) IBOutlet UITextField *duankouVirw;
@property (weak, nonatomic) IBOutlet UITextField *sendMsgView;
@property (weak, nonatomic) IBOutlet UILabel *recvMsgView;

@property(nonatomic,assign)int clientSocket;

@end

@implementation NetWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self 网络通讯];
    
    [self 网络知识];
    
    [self 配置Apache];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self socketDemo];
}

-(void)socketDemo{
    
    /*
        1、创建Socket
        2、连接到服务器
        3、发送数据给服务器
        4、从服务器接收数据
        5、关闭连接
     
        需要导入头文件
        #import <sys/socket.h>
        #import <netinet/in.h>
        #import <arpa/inet.h>
    */
    
    
    /*
        1、创建socket
        第一个参数：协议域AF_INET   IPV4
        第二个参数：Socket 类型，SOCK_STREAM(TCP)/SOCK_DGRAM(报文UDP)
        第三个参数：如果传0.会自动根据第二个参数，选中合适的协议
        返回值  0就是成功
    */
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    /*
        2、连接到服务器
        第一个参数：客户端socket
        第二个参数：指向数据结构socketaddr的指针，其中包括了目的端口和IP地址
        第三个参数：结构体数据长度
        返回值 0成功         其他错误代码
    */
    struct sockaddr_in serverAddr;
    serverAddr.sin_family = AF_INET;
    //端口
    serverAddr.sin_port = htons(12345);//终端执行nc -lk 12345     始终监听本地计算机12345端口的数据
    //IP地址
    serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    int connResult = connect(clientSocket, (const struct sockaddr *)&serverAddr, sizeof(serverAddr));
    if (connResult == 0) {
        NSLog(@"连接成功");
    }else{
        NSLog(@"失败   %d",connResult);
        return;
    }
    
    //3、发送数据到服务器
    /*
     第一个参数：客户端socket
     第二个参数：发送内容地址
     第三个参数：发送内容长度
     第四个参数：发送方式标志，一般为0
     返回值
     如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR
    */
    NSString * sendMsg = @"潘家伟";
    ssize_t sendLen = send(clientSocket, sendMsg.UTF8String, strlen(sendMsg.UTF8String), 0);
    NSLog(@"%ld",sendLen);
    
    //4、从服务器接受数据
    /*
     第一个参数：客户端socket
     第二个参数：接收内容缓冲区地址
     第三个参数：接收内容缓存区地址
     第四个参数：接收方式，0表示阻塞，必须等到服务器返回数据
     返回值
     如果成功，则返回读入的字节数，失败则返回SOCKET_ERROR
    */
    uint8_t buffer[1024];
    ssize_t recvLen = recv(clientSocket, buffer, sizeof(buffer), 0);
    NSLog(@"接受了    %ld   个字节",recvLen);
    
    //获取服务器返回的数据，从缓冲区中读取 recvLen个字节！
    NSData * data = [NSData dataWithBytes:buffer length:recvLen];
    //转换成字符串
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"  接受到数据了      %@",str);
    
    //5、断开连接
    /*
        长连接：连接上就一直连，通常用于QQ，及时通讯，效率很高！(一对一)
        短连接：通讯一次，马上断开，下次再次建立连接，效率低！(一对多)
    */
    close(clientSocket);
}

-(void)网络通讯{
    /*
        网络通讯三要素
        一、IP地址(主机名)
            网络中设备的标示
            不易记忆，可以用主机名
            本地回环地址:127.0.0.1  主机名：localhost
        二、端口号
            用于标示进程的逻辑地址，不同进程的标示
            有效端口：0----65535
            其中0----1024由系统使用或者保留端口，开发中不要使用1024以下的端口
        三、传输协议(通讯的规则)
            TCP
            UDP
     
        IP地址  网络的前身是电话
        互联网的计算机都有一个唯一的IP地址
        IP地址的格式是0-255           2^8^4=42亿
     
        想要查询一个ip地址是哪个城市的，可以在在终端执行ping 域名，或者直接拿到ip地址，在ip138网站中，查询
     
        常见网络协议
        HTTP          80端口                     网站服务   Apache
        HTTPS         110端口                    电子邮箱
        FTP           21端口                     FTP
        POP3
        SMTP
        telnet
     
     
        OSI网络模型----数据传输示意图
        应用层 表示层 会话层 传输层 网络层 数据链路层 物理层       7层
        物理层是网线
        数据链路层是交换机、网卡，打包数据
        网络层是路由器
        传输层以下都是硬件，硬件内部有芯片，有程序，固定写死
     
        电流有高低电频     0   1
        中继器就是放大电信号
            
        7层中
        应用层                 应用层         表示层     会话层
        传输层(TCP/UDP)        传输层
        网络互连层(IP)          网络层
        网络接口层              数据链路层   物理层
     
        将应用数据，前面加TCP数据，IP头部，帧
     
        TCP & UDP
        UDP(用户数据报协议)：提供的则是不保证可靠性(并不是不可靠)、无连接的数据传输服务
        只管发送，不确认对方是否接收到
        将数据及源和目的封装成数据包中，不需要建立连接
        每个数据报的大小限制在64k之内
        因为无需连接，因此是不可靠协议
        不需要建立连接，速度快
        应用场景：网络流媒体、游戏
     
        TCP(传输控制协议)：提供一种可靠的，通过三次握手来连接的数据传输服务
        建立连接，形成传输数据的通道
        在连接中进行大数据传输(数据大小不受限制)
        通过三次握手完成连接,是可靠协议，安全送达
        必须建立连接，效率会稍低
     
        三次握手
        我发送STY给服务器，服务器被动打开(bind)
        服务器发送SYN-ACK给我
        我发送ACK给服务器
        
        断开连接的四次握手
        我发送FIN给服务器
        服务器发送ACK和FIN给我
        我发送ACK给服务器(我等待连接终止)
        服务器连接终止
     
        
        Socket(套接字层，插座----AT&T)：两个计算机通讯的过程，就像两个人打电话一样
        Socket就是为网络服务提供的一种机制
        在Unix中，网络既是Socket，并不局限在TCP、UDP
        Socket可以用于自定义协议
        通信的两端都是Socket
        网络通信其实就是Socket间的通信
        数据在两个Socket间通过IO传输
        Socket是纯C开发的，是跨平台的
        HTTP协议是基于Socket的，HTTP协议的底层使用就是Socket
    */
}

-(void)网络知识{
    /*
     网络基本概念
     客户端：应用
     服务器：为客户端提供服务、数据、资源的机器
     请求：客户端向服务器索取数据
     响应：服务器对客户端的请求作出反应，一般是返回给客户端数据
     
     服务器
     内网服务器
     外网服务器
     本地测试服务器
     
     准备获取网络上的资源，首先要了解URL
     什么是URL，学名叫统一资源定位符
     网络中每一个资源都对应唯一的地址-------URL
     
     URL的基本格式
     协议://主机地址:端口号/路径
     协议: 不同的协议代表不同的资源获取方式
     主机地址:主机的唯一表示(IP地址、域名)
     路径:资源在主机中的具体位置
     举例:http://www.baidi.com:80/image
     
     URL常见协议
     HTTP、FTP、mailto、File、tel://、sms://
     
     
     HTTP协议简介
     什么是协议
     双方规定好的约定
     
     什么是HTTP协议
     超文本传输协议
     浏览器和web服务器通讯时遵守的约定
     互联网使用最多的协议
     提供超文本传输服务
     通过浏览器打开网站使用的就是HTTP提供的服务，开发App也会经常使用HTTP协议从网络上获取数据
     
     通过浏览器打开网站使用的就是http提供的服务
     开发app，也会经常使用http协议从网络上获取数据
     
     IP地址
     两个计算机通讯必须要知道的
     IP地址和端口号
     
     IP地址
     IP地址是一个32位的二进制数，通常被分割为8位二进制数，通常用点分10进制表示
     192.168.1.1
     唯一标示互联网上的一台计算机(ip地址不好记，所以有了域名)
     一个计算机可能有多个可用的ip地址，比如:两块网卡(集成网卡和无线网卡)
     内网的计算机，都通过路由器上网。他们对外的地址都是路由器的ip地址
     
     端口号
     标示进程(程序)的逻辑地址，不同进程(程序)的标示
     端口号取值范围:0------65535
     端口的分类
     公认端口           0---1024
     注册端口           1025-----49151      分配给用户进程或应用程序，这些进程主要是用户选择安装的一些应用程序
     动态和/私有端口     49152------65535    因为它一般不固定分配某种服务，而是动态分配

    */
}

-(void)配置Apache{
    /*
     1、目标：自己搭建Web服务器，测试从网络加载数据
        
     什么是Apache
     web服务器
    
     配置配置Apache
        a、在当前用户的目录创建一个文件夹
        b、打开finder进入/etc/apache2            /etc/apache2是系统目录，默认不显示
        进入该目录有两种方法
        c、
     
     
     
     
     
    */
    
}

//连接
- (IBAction)connectClick:(UIButton *)sender {
    [self connect:self.ipView.text port:[self.duankouVirw.text intValue]];
}

//发送
- (IBAction)sendClick:(id)sender {
    
   self.recvMsgView.text = [self sendAndRecv:self.sendMsgView.text];
    
}

-(NSString *)sendAndRecv:(NSString *)sendMsg{
    
    const char * msg = sendMsg.UTF8String;
    ssize_t sendLen = send(self.clientSocket, msg, strlen(msg), 0);
    NSLog(@"%ld",sendLen);
    
    //4、从服务器接受数据
    /*
     第一个参数：客户端socket
     第二个参数：接收内容缓冲区地址
     第三个参数：接收内容缓存区地址
     第四个参数：接收方式，0表示阻塞，必须等到服务器返回数据
     返回值
     如果成功，则返回读入的字节数，失败则返回SOCKET_ERROR
    */
    uint8_t buffer[1024];
    ssize_t recvLen = recv(self.clientSocket, buffer, sizeof(buffer), 0);
    NSLog(@"接受了    %ld   个字节",recvLen);
    
    //获取服务器返回的数据，从缓冲区中读取 recvLen个字节！
    NSData * data = [NSData dataWithBytes:buffer length:recvLen];
    //转换成字符串
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"  接受到数据了      %@",str);
    return str;
}

//关闭
- (IBAction)closeClick:(id)sender {
    close(self.clientSocket);
}

//1.连接到服务器
-(BOOL)connect:(NSString *)ip port:(int)port{
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    self.clientSocket = clientSocket;
    
    struct sockaddr_in serverAddr;
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(port);//终端执行nc -lk 12345     始终监听本地计算机12345端口的数据
    //IP地址
    serverAddr.sin_addr.s_addr = inet_addr(ip.UTF8String);
    int connResult = connect(clientSocket, (const struct sockaddr *)&serverAddr, sizeof(serverAddr));
    if (connResult == 0) {
        return YES;
    }else{
        NSLog(@"失败   %d",connResult);
        return NO;
    }
}


/*
 
 Cookie:sssss
 Accept-Encoding: gzip, deflate, br
 Host: www.jianshu.com
 User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15
 Accept-Language: zh-cn
 Referer: https://www.baidu.com/link?url=ZrQyhcgbBpgoeDadFcdAYai1PN2rnpQn7UKZ2rtcdMwLK_TR-5sADDcUl-IlALQH&wd=&eqid=83eb8c3b000c5da8000000046072d614
 Connection: keep-alive
 
*/



@end
