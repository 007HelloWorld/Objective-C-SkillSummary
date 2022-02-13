//
//  AppleLoginVC.m
//  Image
//
//  Created by pjw on 2022/2/10.
//

#import "AppleLoginVC.h"
#import <AuthenticationServices/AuthenticationServices.h>
#define ApplicationWindow           ([UIApplication sharedApplication].windows[0])

API_AVAILABLE(ios(13.0))
@interface AppleLoginVC ()<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>
@property(nonatomic,strong)ASAuthorizationAppleIDButton *authorizationButton;

@end

@implementation AppleLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     1、Error Domain=com.apple.AuthenticationServices.AuthorizationError Code=1000 "
     项目配置中未添加 Sign in with Apple，参考文章第一步
     选择项目 TARGETS -> Signing&Capabilities ，单击下图中的 3：Capability：
     启用 Sign in with Apple
     在弹出框中搜索找到 Sign in with Apple：
    */
    
    self.navigationItem.title = @"pg";
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 13.0, *)) {
        if (@available(iOS 13.2, *)) {
            ASAuthorizationAppleIDButton *appleLoginBtn = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignUp authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleBlack];
            appleLoginBtn.frame = CGRectMake(0, 0, 50, 50);
            appleLoginBtn.layer.cornerRadius = 5;
            appleLoginBtn.layer.masksToBounds = YES;
            [appleLoginBtn addTarget:self action:@selector(appleID_Login) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:appleLoginBtn];
            appleLoginBtn.frame = CGRectMake(100, 100, 200, 60);
        } else {
            // Fallback on earlier versions
        }
    } else {
        // Fallback on earlier versions
    }
}

-(void)appleID_Login{
    if (@available(iOS 13.0, *)) {
        [self click];
    } else {
        // Fallback on earlier versions
    }
}

-(void)click API_AVAILABLE(ios(13.0)){
    ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc]init];
    ASAuthorizationAppleIDRequest *request = [appleIDProvider createRequest];
    request.requestedScopes = @[ASAuthorizationScopeFullName,ASAuthorizationScopeEmail];
    ASAuthorizationController *auth = [[ASAuthorizationController alloc]initWithAuthorizationRequests:@[request]];
    auth.delegate = self;
    auth.presentationContextProvider = self;
    [auth performRequests];
}

///代理主要用于展示在哪里
-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
    return ApplicationWindow;
}

-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
        if([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]){
            ASAuthorizationAppleIDCredential *apple = authorization.credential;
            ///将返回得到的user 存储起来
            NSString *userIdentifier = apple.user;
            NSPersonNameComponents *fullName = apple.fullName;
            NSString *email = apple.email;
            //用于后台像苹果服务器验证身份信息
            NSData *identityToken = apple.identityToken;
            
            
            NSLog(@"userIdentifier->%@ fullName-> %@ email-> %@ identityToken-> %@",userIdentifier,fullName,email,identityToken);
            [self requestAppleIDLogin:userIdentifier];
        }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
            
            //// Sign in using an existing iCloud Keychain credential.
            ASPasswordCredential *pass = authorization.credential;
            NSString *username = pass.user;
            NSString *passw = pass.password;
            
        }
    
}



///回调失败
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    NSLog(@"%@",error);
    NSLog(@"       登录失败      ");
}

-(void)requestAppleIDLogin:(NSString *)info{
    NSLog(@"       返回信息     %@ ",info);
}

@end
