//
//  UMShareViewController.m
//  Image
//
//  Created by pjw on 2021/3/5.
//

#import "UMShareViewController.h"
#import <Masonry.h>
//#import "WXApi.h"

#define RGB(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]


@interface UMShareViewController ()

@end

@implementation UMShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];


//    导入libc.tbd        微信集成导入
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * saveBtn = [UIButton new];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 20;
    saveBtn.layer.borderColor = RGB(234, 234, 237, 1).CGColor;
    saveBtn.layer.borderWidth = 1;
    saveBtn.backgroundColor = RGB(255, 255, 255, 1);
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [saveBtn setTitle:@"保存草稿" forState:UIControlStateNormal];
    [saveBtn setTitleColor:RGB(63, 82, 112, 1) forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.centerY.equalTo(self.view.mas_centerY);
        make.right.equalTo(self.view.mas_centerX).offset(-7.5);
        make.height.offset(40);
    }];
}

-(void)saveEvent{
//    WXMediaMessage * msg = [[WXMediaMessage alloc]init];
//    msg.title = @"催缴详情";
//    msg.description = @"催缴详情";
//    UIImage *image = [UIImage imageNamed:@"xiaoCode"];
//    msg.thumbData = UIImagePNGRepresentation(image);

//    WXMiniProgramObject *miniProgramObj = [[WXMiniProgramObject alloc]init];
//    miniProgramObj.webpageUrl = @"https://smcloud-uat.shimaowy.com/pages/ensure-pay/ensure-pay?payId=421158";
//    #ifdef DEBUG
//    miniProgramObj.miniProgramType = WXMiniProgramTypePreview;
//    #else
//    miniProgramObj.miniProgramType = WXMiniProgramTypeRelease;
//    #endif
//    miniProgramObj.userName = @"gh_ca2f53ccc6e2";
//    miniProgramObj.path = @"/pages/ensure-pay/ensure-pay?payId=421158";
//
//    msg.mediaObject = miniProgramObj;


//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
//    req.message = msg;
//    req.scene = WXSceneSession; //WXSceneSession          WXSceneTimeline
//
//    [WXApi sendReq:req];
}

@end
