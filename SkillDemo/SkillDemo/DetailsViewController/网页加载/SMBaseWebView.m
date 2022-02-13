//
//  SMBaseWebView.m
//  Image
//
//  Created by pjw on 2021/3/5.
//

#import "SMBaseWebView.h"

#define Height_NavBar 44.0f
#define Height_StatusBar [[UIApplication sharedApplication] statusBarFrame].size.height
#define Height_TopBar (Height_StatusBar + Height_NavBar)
#define WEAKSELF __weak __typeof(self)weakSelf = self;


#ifdef __IPHONE_14_0

#import <PhotosUI/PHPicker.h>

@interface SMBaseWebView ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UIImagePickerControllerDelegate,PHPickerViewControllerDelegate>

#else

@interface SMBaseWebView ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

#endif

@property (nonatomic,strong) UIRefreshControl *refreshControl;  //刷新
@end

@implementation SMBaseWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    if ([[self isNullString:self.richTextString] isEqualToString:@""]) {
        [self loadRequest];
    }else{
        [self loadRichTextRequest];
    }
    
}

-(void)setupUI{
    [self.view addSubview:self.wkWebView];
}


- (void)loadRequest {
    if (![self.urlString hasPrefix:@"http"]) {//容错处理 不要忘记plist文件中设置http可访问 App Transport Security Settings
        self.urlString = [NSString stringWithFormat:@"https://%@",self.urlString];
    }
    
    NSLog(@"self.urlString=====%@",self.urlString);
    NSURL * url = [NSURL URLWithString:[self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [_wkWebView loadRequest:request];
}

- (void)loadRichTextRequest {
    [_wkWebView loadHTMLString:self.richTextString baseURL:nil];
}



#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    _progress.hidden = NO;
    _wkWebView.hidden = NO;
    // 看是否加载空网页
    if ([webView.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    //执行JS方法获取导航栏标题
    WEAKSELF
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        if (self.setTitle.length>0) {
            [weakSelf setNaviTitle:self.setTitle];
        }else{
            [weakSelf setNaviTitle:title];
        }
        
    }];
    
    [_refreshControl endRefreshing];
}

// 返回内容是否允许加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
    
    
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
    webView.hidden = YES;
}

#pragma mark UIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    if(@available(iOS 13.0, *)) {
        alertController.modalPresentationStyle = 0;
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    
}

#pragma mark WKScriptMessageHandler js 拦截 调用OC方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
    NSLog(@"方法名:%@", message.name);
    NSLog(@"参数:%@", message.body);
    
    if ([message.name isEqualToString:@"chooseFinished"] && [message.body isKindOfClass:[NSDictionary class]]) {
        NSDictionary *bodyDict = (NSDictionary*)message.body;
        NSString *userIdStr = [NSString stringWithFormat:@"%@",[bodyDict objectForKey:@"userId"]];
        NSString *userNameStr = [NSString stringWithFormat:@"%@",[bodyDict objectForKey:@"userName"]];
        self.headPersonBlock(userIdStr,userNameStr);
        return;
    }else if ([message.name isEqualToString:@"targetPaiOrder"]){//是否创建派工单
        //是否创建派工单
        NSDictionary *bodyDict = (NSDictionary*)message.body;
        return;
    }else if ([message.name isEqualToString:@"inspectionDetails"]){//跳转 巡查工单
        
        return;
    }
    
    if([message.body isKindOfClass:[NSString class]] && [message.body isEqualToString:@"getPic3"]){
        // do something
        
    } else {
        if([message.name isEqualToString:@"getPic1"]){
            // do something
        
        }
        
        if([message.name isEqualToString:@"getPic2"]){
            // do something
        
        }
    }
    
    if ([message.name isEqualToString:@"back"]) {
        NSLog(@"     调用了原生方法       ");
    }
    //修改标题
    if ([message.name isEqualToString:@"setTitle"]) {
        
    }
    //扫码
    if ([message.name isEqualToString:@"startScanner"]) {
        
    }
    if ([message.name isEqualToString:@"openView"]) {
       
    }
    
    if ([message.name isEqualToString:@"backPosHome"]) {
       
    }
    if ([message.name isEqualToString:@"showSearch"]) {
        
    }
    if ([message.name isEqualToString:@"showFiltrate"]) {
        
    }
    if ([message.name isEqualToString:@"showBill"]) {
        
    }
    if ([message.name isEqualToString:@"showHistory"]) {
        
    }
    if ([message.name isEqualToString:@"askLocation"]) {
    }
    if ([message.name isEqualToString:@"makePhoneCall"]) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",message.body];
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:str];
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            //OpenSuccess=选择 呼叫 为 1  选择 取消 为0
            NSLog(@"OpenSuccess=%d",success);
        }];
    }
    //拉起微信小程序
    if ([message.name isEqualToString:@"billShowWx"]) {//催缴按钮
        
    }
}


//刷新H5 UI 的UI效果
-(void)setValueStr:(NSString *)valueStr currentEventNameStr:(NSString *)currentEventNameStr{
    
    NSString *jsStr = [NSString stringWithFormat:@"returnPic1('%@')",@""];

    if ([currentEventNameStr isEqualToString:@"getPic2"]) {
        jsStr = [NSString stringWithFormat:@"returnPic2('%@')",@""];
    }
    
    if ([currentEventNameStr isEqualToString:@"getPic3"]) {
        jsStr = [NSString stringWithFormat:@"returnPic3('%@')",@""];
    }
    if ([currentEventNameStr isEqualToString:@"handleScanResult"]) {
        jsStr = [NSString stringWithFormat:@"handleScanResult('%@')",@""];
    }
    if ([currentEventNameStr isEqualToString:@"showScreen"]) {
        jsStr = [NSString stringWithFormat:@"showScreen()"];
    }
    if ([currentEventNameStr isEqualToString:@"respondsLocation"]) {
        jsStr = [NSString stringWithFormat:@"respondsLocation('%@')",@""];
    }
    
    [self.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        
    }];
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        _progress.progress = [change[@"new"] floatValue];
        if (_progress.progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _progress.hidden = YES;
            });
        }
    }else if ([keyPath isEqualToString:@"URL"]) {
        WEAKSELF
       [_wkWebView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
           if (self.setTitle.length>0) {
               [weakSelf setNaviTitle:self.setTitle];
           }else{
               [weakSelf setNaviTitle:title];
           }
           
       }];
    }
}

-(void)setNaviTitle:(NSString *)title{
    self.navigationItem.title = title;
}

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        // 设置WKWebView基本配置信息
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.preferences = [[WKPreferences alloc] init];
        configuration.allowsInlineMediaPlayback = YES;
        configuration.selectionGranularity = YES;
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"getPic1"];
        [userContentController addScriptMessageHandler:self name:@"getPic2"];
        [userContentController addScriptMessageHandler:self name:@"getPic3"];
        [userContentController addScriptMessageHandler:self name:@"back"];
        [userContentController addScriptMessageHandler:self name:@"chooseFinished"];
        [userContentController addScriptMessageHandler:self name:@"targetPaiOrder"];
        [userContentController addScriptMessageHandler:self name:@"inspectionDetails"];
        [userContentController addScriptMessageHandler:self name:@"setTitle"];
        [userContentController addScriptMessageHandler:self name:@"startScanner"];
        [userContentController addScriptMessageHandler:self name:@"openView"];
        [userContentController addScriptMessageHandler:self name:@"backPosHome"];
        [userContentController addScriptMessageHandler:self name:@"showSearch"];
        [userContentController addScriptMessageHandler:self name:@"showFiltrate"];
        [userContentController addScriptMessageHandler:self name:@"showBill"];
        [userContentController addScriptMessageHandler:self name:@"showHistory"];
        [userContentController addScriptMessageHandler:self name:@"askLocation"];
        [userContentController addScriptMessageHandler:self name:@"makePhoneCall"];
        [userContentController addScriptMessageHandler:self name:@"billShowWx"];
        if (self.jsString) {
            WKUserScript *jsString = [[WKUserScript alloc] initWithSource:self.jsString injectionTime:(WKUserScriptInjectionTimeAtDocumentStart) forMainFrameOnly:NO];
            [userContentController addUserScript:jsString];
        }
        configuration.userContentController = userContentController;
        
        self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Height_TopBar, self.view.bounds.size.width, self.view.bounds.size.height-Height_TopBar) configuration:configuration];
        // 设置代理
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 是否开启下拉刷新
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0 && _canDownRefresh) {
            _wkWebView.scrollView.refreshControl = self.refreshControl;
        }
        // 添加进度监听
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:(NSKeyValueObservingOptionNew) context:nil];
        [_wkWebView addObserver:self forKeyPath:@"URL" options:(NSKeyValueObservingOptionNew) context:nil];
        
    }
    return _wkWebView;
}

- (UIRefreshControl *)refreshControl{
    if (!_refreshControl) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(wkWebViewReload) forControlEvents:(UIControlEventValueChanged)];
    }
    return _refreshControl;
}

- (void)wkWebViewReload{
    [_wkWebView reload];
}

//为空转空串
- (NSString *)isNullString:(NSString *)string{
    
    if ([string isEqual:[NSNull null]]) {
        return @"";
    }else if (string == nil || string == NULL) {
        return @"";
    }else if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"";
    }
    
    return string;
}

#pragma mark Dealloc
- (void)dealloc{
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_wkWebView removeObserver:self forKeyPath:@"URL"];
    [_wkWebView stopLoading];
    _wkWebView.UIDelegate = nil;
    _wkWebView.navigationDelegate = nil;
}


@end
