//
//  NDBaseWebViewController.m
//  niudanios
//
//  Created by lsc on 2018/10/14.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBaseWebViewController.h"
#import <WebKit/WebKit.h>
#import "NDAccountPayViewController.h"
@interface NDBaseWebViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)WKWebViewConfiguration *webConfig;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic,assign)CGFloat progressTop;

@end

@implementation NDBaseWebViewController



- (instancetype)init
{
    self = [super init];
    if (self) {
        _progressTop = 0.0f;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}
-(WKWebView *)webView{
    if(_webView == nil){
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero
                                      configuration:self.webConfig];
    }
    return _webView;
}

-(WKWebViewConfiguration *)webConfig{
    if(_webConfig == nil){
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 设置偏好设置
        config.preferences = [[WKPreferences alloc] init];
        // 默认为0
        config.preferences.minimumFontSize = 10;
        // 默认认为YES
        config.preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        // web内容处理池，由于没有属性可以设置，也没有方法可以调用，不用手动创建
        config.processPool = [[WKProcessPool alloc] init];
        // 通过JS与webview内容交互
        config.userContentController = [[WKUserContentController alloc] init];
        
        _webConfig = config;
    }
    return _webConfig;
}



-(UIProgressView *)progressView{
    if(_progressView == nil){
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        _progressView.tintColor = HEXCOLOR(0x1997eb);
        _progressView.trackTintColor = HEXCOLOR(0xF1F1F1);
        _progressView.hidden = YES;
    }
    return _progressView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self FVSetUpSubviews];
    // Do any additional setup after loading the view.

}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    [self.webConfig.userContentController addScriptMessageHandler:self name:@"jsToApp"];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.webConfig.userContentController removeScriptMessageHandlerForName:@"jsToApp"];
    
}

-(void)updateViewConstraints{
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(_progressTop);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1.0f);
    }];
    [super updateViewConstraints];
}

-(void)FVSetUpSubviews{
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self.view);
    }];
    
    NSURL *url = [NSURL URLWithString:[self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //    [request addValue:cookieString forHTTPHeaderField:@"Cookie"];
    [self.webView loadRequest:request];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.delegate = self;
    
    // 添加KVO监听
    [self.webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        _progressTop = 0.0f;
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else if ([keyPath isEqualToString:@"title"]) {
        //        self.title = self.webView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
    }
    
    // 加载完成
    if (!self.webView.loading) {
        // 手动调用JS代码
        // 每次页面完成都会调用
        
        _progressTop = -1.0f;
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.8 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            _progressView.hidden = YES;
        }];
    }
}

#pragma mark - WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"jsToApp"]) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"余额不足" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NDAccountPayViewController * payVC = [[NDAccountPayViewController alloc] init];
                [self.navigationController pushViewController:payVC animated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
    }
}


// 在JS端调用alert函数时，会触发此代理方法。
// JS端调用alert时所传的数据可以通过message拿到
// 在原生得到结果后，需要回调JS，是通过completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);
    //    completionHandler();
}

// JS端调用confirm函数时，会触发此方法
// 通过message可以拿到JS端所传的数据
// 在iOS端显示原生alert得到YES/NO后
// 通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    //    NSLog(@"%s", __FUNCTION__);
    //
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    //    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        completionHandler(YES);
    //    }]];
    //    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //        completionHandler(NO);
    //    }]];
    //    [self presentViewController:alert animated:YES completion:NULL];
    //
    //    NSLog(@"%@", message);
    completionHandler(YES);
}

// JS端调用prompt函数时，会触发此方法
// 要求输入一段文本
// 在原生输入得到文本内容后，通过completionHandler回调给JS
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    //    NSLog(@"%s", __FUNCTION__);
    //
    //    NSLog(@"%@", prompt);
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    //    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //        textField.textColor = [UIColor redColor];
    //    }];
    //
    //    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        completionHandler([[alert.textFields lastObject] text]);
    //    }]];
    //
    //    [self presentViewController:alert animated:YES completion:NULL];
    completionHandler(@"");
}

#pragma mark - WKNavigationDelegate
// 请求开始前，会先调用此代理方法
// 与UIWebView的
// - (BOOL)webView:(UIWebView *)webView
// shouldStartLoadWithRequest:(NSURLRequest *)request
// navigationType:(UIWebViewNavigationType)navigationType;
// 类型，在请求先判断能不能跳转（请求）
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
        && ![hostname containsString:@".baidu.com"]) {
        // 对于跨域，需要手动跳转
        //        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        
        // 不允许web内跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    NSLog(@"%s", __FUNCTION__);
}

// 在响应完成时，会回调此方法
// 如果设置为不允许响应，web内容就不会传过来
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"%s", __FUNCTION__);
}

// 开始导航跳转时会回调
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

// 接收到重定向时会回调
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
}

// 页面内容到达main frame时回调
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

// 导航完成时，会回调（也就是页面载入完成了）
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"loading"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.webView.navigationDelegate = nil;
    self.webView.UIDelegate = nil;
    self.webView.scrollView.delegate = nil;
    
}

@end
